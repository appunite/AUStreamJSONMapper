//
//  User+Additions.m
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "User+Additions.h"

@implementation User (Additions)

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (AUEntityMapping *)attributeObjectMappingWithContext:(NSManagedObjectContext *)context
{
    // post mapping
    AUEntityMapping *mapping = [AUEntityMapping mappingForEntityForName:@"User"];
    [mapping addMappingsFromArray:@[ @"age", @"email", @"name", @"surname" ]];
    [mapping addMappingsFromDictionary:@{ @"id": @"uid", @"created_at": @"createdAt" }];
    
    return mapping;
}

@end
