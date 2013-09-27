//
//  NSString+Paths.m
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "NSString+Paths.h"

@implementation NSString (Paths)

+ (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
}

@end
