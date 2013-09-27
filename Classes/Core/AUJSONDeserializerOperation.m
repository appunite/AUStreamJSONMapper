//
//  AUJSONDeserializer.m
//  Json
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUJSONDeserializerOperation.h"

// Mapper
#import "AUObjectMapper.h"

@implementation AUJSONDeserializerOperation {
    NSData *_jsonData;
    NSInputStream *_jsonInputStream;
}

#pragma mark - Init methods

- (id)init
{
    self = [super init];
    if (self) {
        _parserStatus = -1;
        _isExecuting = NO;
        _isFinished = NO;

        // We don't want *all* the individual messages from the
        // SBJsonStreamParser, just the top-level objects. The stream
        // parser adapter exists for this purpose.
        _adapter = [[SBJsonStreamParserAdapter alloc] init];
        _adapter.levelsToSkip = 1;
        
        // Set ourselves as the delegate, so we receive the messages
        // from the adapter.
        _adapter.delegate = self;
    }
    return self;
}

- (id)initWithObjectMapper:(AUObjectMapper *)objectMapper
{
    self = [self init];
    if (self) {
        _objectMapper = objectMapper;
    }
    return self;
}

#pragma mark - state changes

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didStart {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFinish {
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


#pragma mark - NSOperation class methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isExecuting {
    return _isExecuting;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isFinished {
    return _isFinished;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)start
{
    
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self didFinish]; return;
    }
    
    @try {
        @autoreleasepool {
            // mark as executing
            [self didStart];
            
            // Create a new stream parser..
            _parser = [[SBJsonStreamParser alloc] init];
            
            // .. and set our adapter as its delegate.
            _parser.delegate = _adapter;
            
            // Normally it's an error if JSON is followed by anything but
            // whitespace. Setting this means that the parser will be
            // expecting the stream to contain multiple whitespace-separated
            // JSON documents.
            _parser.supportMultipleDocuments = YES;
            
            // open stream
            [self openStream];
            
            // here: start the loop
            [[NSRunLoop currentRunLoop] run];
        }
    }
    
    @catch(NSException *exception) {
        
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel
{
    if (![self isFinished]) {
        // close stream and remove form runloop
        [self closeStream];
        
        // remove parser
        _parser = nil;
        
        // change state
        [self didFinish];
    }
}

#pragma mark - deserializing JSON methods

- (void)deserializerJSONWithData:(NSData *)data
{
    // create stream from NSData object
    NSInputStream *stream = [[NSInputStream alloc] initWithData:data];
    
    // deserialize JSON
    [self deserializerJSONWithStream:stream];
}

- (void)deserializerJSONWithFileAtPath:(NSString *)filePath
{
    // create stream with file
    NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath:filePath];

    // deserialize JSON
    [self deserializerJSONWithStream:stream];
}

- (void)deserializerJSONWithStream:(NSInputStream *)stream
{
    NSAssert(_objectMapper, @"You must define object mapper first.");
    NSParameterAssert(stream);

    // assign stream
    _jsonInputStream = stream;
    [_jsonInputStream setDelegate:self];
}

#pragma mark - NSInputStream

- (void)openStream
{
    [_jsonInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                forMode:NSDefaultRunLoopMode];
    
    // open stream
    [_jsonInputStream open];
}

- (void)closeStream
{
    [_jsonInputStream close];
    [_jsonInputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                                forMode:NSDefaultRunLoopMode];
    _jsonInputStream = nil;
}

#pragma mark - NSStreamDelegate

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
{
    switch(eventCode) {
        case NSStreamEventOpenCompleted: {
            
            // move to main queue
            dispatch_async(dispatch_get_main_queue(), ^ {

                // send delegate
                if ([_delegate respondsToSelector:@selector(JSONDeserializerDidOpenStream:)]) {
                    [_delegate JSONDeserializerDidOpenStream:self];
                }
            });
        }

        case NSStreamEventHasBytesAvailable:
        {
            uint8_t buf[1024];
            NSInteger len = [(NSInputStream *)stream read:buf maxLength:1024];;

            if (len) {
                // create chunk data
                NSData *data = [NSData dataWithBytes:(const void *)buf length:len];

                // Parse the new chunk of data. The parser will append it to
                // its internal buffer, then parse from where it left off in
                // the last chunk.
                _parserStatus = [_parser parse:data];

                // check ststaus
                if (_parserStatus == SBJsonStreamParserError) {
                    NSLog(@"Parser error: %@", _parser.error);
                    
                } else if (_parserStatus == SBJsonStreamParserWaitingForData) {
                    NSLog(@"Parser waiting for more data");
                }
            }
            break;
        }

        case NSStreamEventErrorOccurred:
        case NSStreamEventEndEncountered:
        {
            // move to main queue
            dispatch_async(dispatch_get_main_queue(), ^ {
              
                // send delegate
                if ([_delegate respondsToSelector:@selector(JSONDeserializerDidCloseStream:)]) {
                    [_delegate JSONDeserializerDidCloseStream:self];
                }
            });
                           
            // close stream and remove form runloop
            [self closeStream];
            
            // remove parser
            _parser = nil;
            
            // change state
            [self didFinish];
            break;
        }
            
        default:
            break;
            
    }
}


#pragma mark - SBJsonStreamParserAdapterDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array
{
    NSLog(@"%@", array);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict
{
    // map parsed object
    [_objectMapper mapObject:dict];
}

@end
