//
//  AUObjectMapping.m
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUObjectMapping.h"

@interface AUAttributeMapping ()
@property (nonatomic, weak, readwrite) AUObjectMapping *objectMapping;
@end

@implementation AUObjectMapping {
    NSMutableSet *_mutableMappings;
}


#pragma mark - Inits

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)mappingForClass:(Class)objectClass
{
    return [[AUObjectMapping alloc] initWithClass:objectClass];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {
        _mutableMappings = [NSMutableSet new];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithClass:(Class)objectClass
{
    self = [self init];
    if (self) {
        _objectClass = objectClass;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object
{
    return [[[self objectClass] alloc] init];
}


#pragma mark - Adding/Removing mappings

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addMapping:(AUAttributeMapping *)mappings
{
    // update object mapings
    [mappings setObjectMapping:self];
    // save object in mutable collection
    [_mutableMappings addObject:mappings];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addMappingsFromDictionary:(NSDictionary *)mappings
{
    [mappings enumerateKeysAndObjectsUsingBlock:^(NSString *sourceKeyPath, NSString *destinationKeyPath, BOOL *stop) {
        [self addMapping:[AUAttributeMapping attributeMappingFromKeyPath:sourceKeyPath
                                                               toKeyPath:destinationKeyPath]];
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addMappingsFromArray:(NSArray *)mappings
{
    [self addMappingsFromDictionary:[NSDictionary dictionaryWithObjects:mappings forKeys:mappings]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeMapping:(AUAttributeMapping *)mapping
{
    [_mutableMappings removeObject:mapping];
}


#pragma mark - Getters

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSSet *)propertyMappings
{
    return [NSSet setWithSet:_mutableMappings];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSSet *)attributeMappings
{
    NSMutableSet *set = [NSMutableSet new];
    [_mutableMappings enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isMemberOfClass:[AUAttributeMapping class]]) {
            [set addObject:obj];
        }
    }];
    return [NSSet setWithSet:set];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSSet *)relationshipMappings {
    NSMutableSet *set = [NSMutableSet new];
    [_mutableMappings enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isMemberOfClass:[AURelationshipMapping class]]) {
            [set addObject:obj];
        }
    }];
    return [NSSet setWithSet:set];
}


#pragma mark - Others

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p objectClass => %@>", self.class, self, self.objectClass];
}

@end
