//
//  AUEntityMapping.m
//  Json
//
//  Created by Emil Wojtaszek on 26.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUEntityMapping.h"

@implementation AUEntityMapping

- (id)initWithClass:(Class)objectClass
{
    NSAssert(YES, @"You can not invoke `initWithClass:` selector, use `initWithEntity:`");
    return nil;
}

- (id)initWithEntity:(NSEntityDescription *)entity
{
    self = [super init];
    if (self) {
        NSParameterAssert(entity);
        _entityDescription = entity;
    }
    return self;
}

+ (instancetype)mappingForEntity:(NSEntityDescription *)entity
{
    return [[self alloc] initWithEntity:entity];
}

- (id)object
{
    NSAssert(YES, @"You can not invoke `object` selector, use `objectWithManagedObjectContext:`");
    return nil;
}

- (id)objectWithManagedObjectContext:(NSManagedObjectContext *)context
{
    NSParameterAssert(context);
    return [NSEntityDescription insertNewObjectForEntityForName:[_entityDescription managedObjectClassName]
                                         inManagedObjectContext:context];
}

@end
