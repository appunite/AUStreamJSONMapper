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
- (id)objectForMapping:(AUEntityMapping *)mapping
{
    return [mapping objectWithManagedObjectContext:_managedObjectContext];
}

@end