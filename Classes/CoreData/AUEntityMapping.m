//
//  AUEntityMapping.m
//  Json
//
//  Created by Emil Wojtaszek on 26.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUEntityMapping.h"

@implementation AUEntityMapping

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithClass:(Class)objectClass
{
    NSAssert(YES, @"You can not invoke `initWithClass:` selector, use `initWithEntity:`");
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithEntityForName:(NSString *)entityName
{
    self = [super init];
    if (self) {
        NSParameterAssert(entityName);
        _entityName = [entityName copy];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)mappingForEntityForName:(NSString *)entityName
{
    return [[self alloc] initWithEntityForName:entityName];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object
{
    NSAssert(YES, @"You can not invoke `object` selector, use `objectWithManagedObjectContext:`");
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectWithManagedObjectContext:(NSManagedObjectContext *)context
{
    NSParameterAssert(context);
    return [NSEntityDescription insertNewObjectForEntityForName:_entityName
                                         inManagedObjectContext:context];
}


#pragma mark - Others

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p managedObjectClass => %@>", self.class, self, _entityName];
}

@end
