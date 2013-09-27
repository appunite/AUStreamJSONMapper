//
//  AURelationshipMapping.h
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

// Frameworks
#import <Foundation/Foundation.h>

// Mappings
#import "AUObjectMapping.h"
#import "AUAttributeMapping.h"

@interface AURelationshipMapping : AUAttributeMapping

@property (nonatomic, strong, readonly) AUObjectMapping *relationshipObjectMapping;

+ (instancetype)relationshipMappingFromKeyPath:(NSString *)sourceKeyPath
                                     toKeyPath:(NSString *)destinationKeyPath
                                   withMapping:(AUObjectMapping *)mapping;

@end
