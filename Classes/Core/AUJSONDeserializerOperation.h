//
//  AUJSONDeserializer.h
//  Json
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

// Frameworks
#import <Foundation/Foundation.h>

// Parser
#import <SBJson/SBJson.h>

@class AUObjectMapper;
@protocol AUJSONDeserializerOperationDelegate;

@interface AUJSONDeserializerOperation : NSOperation <NSStreamDelegate, SBJsonStreamParserAdapterDelegate> {
    BOOL _isExecuting;
    BOOL _isFinished;
}

- (id)initWithObjectMapper:(AUObjectMapper *)objectMapper;

@property (nonatomic, weak) id<AUJSONDeserializerOperationDelegate> delegate;

// mapping
@property (nonatomic, strong, readonly) AUObjectMapper *objectMapper;

// parsing
@property (nonatomic, strong, readonly) SBJsonStreamParser *parser;
@property (nonatomic, strong, readonly) SBJsonStreamParserAdapter *adapter;
@property (nonatomic, assign, readonly) SBJsonStreamParserStatus parserStatus;

- (void)deserializerJSONWithData:(NSData *)data;
- (void)deserializerJSONWithStream:(NSInputStream *)stream;
- (void)deserializerJSONWithFileAtPath:(NSString *)filePath;
@end

@protocol AUJSONDeserializerOperationDelegate <NSObject>
- (void)JSONDeserializerDidOpenStream:(AUJSONDeserializerOperation *)JSONDeserializer;
- (void)JSONDeserializerDidCloseStream:(AUJSONDeserializerOperation *)JSONDeserializer;
@end
