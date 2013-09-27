//
//  AUAttributeMapping.m
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUAttributeMapping.h"

@interface AUAttributeMapping ()
@property (nonatomic, weak, readwrite) AUObjectMapping *objectMapping;
@property (nonatomic, copy, readwrite) NSString *sourceKeyPath;
@property (nonatomic, copy, readwrite) NSString *destinationKeyPath;
@end

@implementation AUAttributeMapping
@synthesize objectMapping;

+ (instancetype)attributeMappingFromKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath
{

    // check values
    NSAssert(sourceKeyPath || sourceKeyPath, @"sourceKeyPath & destinationKeyPath must not be nil!");

    AUAttributeMapping *attributeMapping = [[self class] new];
    
    // assing key paths
    attributeMapping.sourceKeyPath = sourceKeyPath;
    attributeMapping.destinationKeyPath = destinationKeyPath;
    
    return attributeMapping;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p %@ => %@>", self.class, self, self.sourceKeyPath, self.destinationKeyPath];
}

@end
