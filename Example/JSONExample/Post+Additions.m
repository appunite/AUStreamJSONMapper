//
//  Post+Additions.m
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "Post+Additions.h"

@implementation Post (Additions)

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (AUEntityMapping *)attributeObjectMappingWithContext:(NSManagedObjectContext *)context
{
    // post mapping
    AUEntityMapping *mapping = [AUEntityMapping mappingForEntityForName:@"Post"];
    [mapping addMappingsFromArray:@[@"message"]];
    [mapping addMappingsFromDictionary:@{@"id": @"uid", @"created_at": @"createdAt", @"photo_url": @"photoURL"}];
    
    return mapping;
}

@end
