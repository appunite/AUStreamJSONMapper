//
//  AURelationshipMapping.m
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AURelationshipMapping.h"

@interface AURelationshipMapping ()
@property (nonatomic, strong, readwrite) AUObjectMapping *relationshipObjectMapping;
@end

@implementation AURelationshipMapping

+ (instancetype)relationshipMappingFromKeyPath:(NSString *)sourceKeyPath
                                     toKeyPath:(NSString *)destinationKeyPath
                                   withMapping:(AUObjectMapping *)mapping
{
    AURelationshipMapping *relationshipMapping = [AURelationshipMapping attributeMappingFromKeyPath:sourceKeyPath toKeyPath:destinationKeyPath];
    
    relationshipMapping.relationshipObjectMapping = mapping;
    return relationshipMapping;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p %@ => %@>", self.class, self, self.sourceKeyPath, self.destinationKeyPath];
}

@end
