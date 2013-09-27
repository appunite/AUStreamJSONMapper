//
//  AUEntitiesMappingOperation.m
//  Json
//
//  Created by Emil Wojtaszek on 26.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUEntityMapper.h"
#import "AUEntityMapping.h"

@implementation AUEntityMapper

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id<AUEntityMapperDelegate>)delegate
{
    return (id<AUEntityMapperDelegate>)[super delegate];;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDelegate:(__weak id<AUEntityMapperDelegate>)delegate 
{
    [super setDelegate:delegate];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)destinationObjectForSourceObject:(id)object mapping:(AUEntityMapping *)mapping
{
    
    if (![[self delegate] respondsToSelector:@selector(mapper:findOrCreateObject:forMappings:)]) {
        NSAssert(YES, @"todo: message");
    }

    return [[self delegate] mapper:self findOrCreateObject:object forMappings:mapping];
}

@end
