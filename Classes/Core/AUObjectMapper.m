//
//  AUMappingOperation.m
//  AUObjectMappings
//
//  Created by Emil Wojtaszek on 23.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUObjectMapper.h"
#import "AUObjectMapping.h"

// Others
#import "AUMappingUtls.h"

@implementation AUObjectMapper

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMappings:(id)mappings
{
    self = [self init];
    if (self) {
        _mappings = mappings;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapObject:(NSDictionary *)object
{
    NSAssert(_mappings, @"You must define your mappings");
    NSParameterAssert(object);

    // map object
    [self mapObject:object withMapping:_mappings belongsTo:nil];
}


#pragma mark - Private class methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectForMapping:(AUObjectMapping *)mapping
{
    return [mapping object];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (id)mapObject:(id)object withMapping:(AUObjectMapping *)mapping belongsTo:(id)belongsTo
{
    // create new mapped object
    NSObject* mappedObject = [self objectForMapping:mapping];

    // send delagate
    if ([_delegate respondsToSelector:@selector(mapper:willMapObject:withMappings:)]) {
        [_delegate mapper:self willMapObject:object withMappings:mapping];
    }
    
    // map simple attributes
    [[mapping attributeMappings] enumerateObjectsUsingBlock:^(AUAttributeMapping *attributeMappings, BOOL *stop) {
        [self mapAttributesObject:object toObject:mappedObject withAttributeMapping:attributeMappings];
    }];
    
    // send delagate
    if ([_delegate respondsToSelector:@selector(mapper:didMapObject:belongsTo:)]) {
        [_delegate mapper:self didMapObject:mappedObject belongsTo:belongsTo];
    }

    // map relationships
    [[mapping relationshipMappings] enumerateObjectsUsingBlock:^(AURelationshipMapping *relationshipMappings, BOOL *stop) {
        [self mapRelationshipObject:object toObject:mappedObject withRelationshipMapping:relationshipMappings];
    }];
    
    return mappedObject;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapAttributesObject:(id)sourceObject toObject:(id)destinationObject withAttributeMapping:(AUAttributeMapping *)attributeMapping {

    // get key and value for mapped object
    id key = attributeMapping.destinationKeyPath;
    id value = [sourceObject objectForKey:attributeMapping.sourceKeyPath];
    
    if (value) {
        NSError *error = nil;
        if ([destinationObject validateValue:&value forKeyPath:key error:&error]) {
            // update value for key of mapped object
            [destinationObject setValue:value forKey:key];
        }
        
        else {
            NSLog(@"Error: %@", error);
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)mapRelationshipObject:(id)sourceObject toObject:(id)destinationObject withRelationshipMapping:(AURelationshipMapping *)relationshipMappings {
    // get key and value for mapped object
//    id key = relationshipMappings.destinationKeyPath;
    id value = [sourceObject objectForKey:relationshipMappings.sourceKeyPath];
    
    // get object mapping
    AUObjectMapping *relationshipObjectMapping = [relationshipMappings relationshipObjectMapping];
    
    // create empty mutable collection
    if (AUObjectIsCollection(value)) {
        
        // enumerate json collection
        [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self mapObject:obj withMapping:relationshipObjectMapping belongsTo:destinationObject];
        }];
    }
    
    else {
        // map simple object
        [self mapObject:value withMapping:relationshipObjectMapping belongsTo:destinationObject];
    }
}

@end
