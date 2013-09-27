//
//  AUMainViewController.m
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUMainViewController.h"

// AFNetworking
#import "AFHTTPRequestOperation.h"

// Categories
#import "Post+Additions.h"
#import "User+Additions.h"
#import "NSString+Paths.h"

//Others
#import "AUEntityMapper.h"

@implementation AUMainViewController{
    NSOperationQueue *_queue;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        // create serial queue
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // main function
    [self downloadAndMapJSON];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (AUObjectMapping *)mappings
{

    // post mapping
    AUObjectMapping *postMappings = [Post attributeObjectMappingWithContext:_managedObjectContext];
    
    // user mapping
    AUObjectMapping *userMapping = [User attributeObjectMappingWithContext:_managedObjectContext];
    [userMapping addMapping:[AURelationshipMapping relationshipMappingFromKeyPath:@"posts" toKeyPath:@"posts" withMapping:postMappings]];
    
    return userMapping;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)downloadAndMapJSON
{
    // get JSON path
    NSString *jsonPath = [[NSString applicationDocumentsDirectory] stringByAppendingPathComponent:@"json1.txt"];
    
    // create URL request
    NSURL *url = [NSURL URLWithString:@"http://f.cl.ly/items/382h383J250Q3X3y1M3H/json.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // create HTTP operation
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // create object mapper
        AUEntityMapper *objectMapper = [[AUEntityMapper alloc] initWithMappings:[self mappings]];
        objectMapper.managedObjectContext = _managedObjectContext;
        objectMapper.delegate = self;
        
        AUJSONDeserializerOperation *deserializer = [[AUJSONDeserializerOperation alloc] initWithObjectMapper:objectMapper];
        deserializer.delegate = self;
        [deserializer deserializerJSONWithFileAtPath:jsonPath];
        
        [_queue addOperation:deserializer];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    // save JSON to file
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:jsonPath append:NO];
    
    // start operation
    [operation start];
}


#pragma mark - AUObjectMapperDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapper:(AUObjectMapper *)mapper didMapObject:(id)object belongsTo:(id)belongObject {
    if (belongObject && [object isKindOfClass:[Post class]]) {
        [belongObject addPostsObject:object];
    }

    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapper:(AUObjectMapper *)mapper willMapObject:(id)object withMappings:(AUObjectMapping *)objectMappings {
//    NSLog(@"2. ");
}

#pragma mark - AUJSONDeserializerOperationDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)JSONDeserializerDidOpenStream:(AUJSONDeserializerOperation *)JSONDeserializer
{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)JSONDeserializerDidCloseStream:(AUJSONDeserializerOperation *)JSONDeserializer
{
    [_managedObjectContext save:nil];
    [_managedObjectContext reset];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSManagedObject *)mapper:(AUEntityMapper *)mapper findOrCreateObject:(id)object forMappings:(AUEntityMapping *)mapping
{
    return [mapping objectWithManagedObjectContext:_managedObjectContext];
}

@end

// JSON1: http://f.cl.ly/items/052Q1m0Y2s47020Y3a18/json1.txt
// JSON2: http://f.cl.ly/items/341P1V3n3S081T3j3H20/json2.txt
// JSON3: http://f.cl.ly/items/3p0D2a1O1v2x2I1r0P18/json3.txt
