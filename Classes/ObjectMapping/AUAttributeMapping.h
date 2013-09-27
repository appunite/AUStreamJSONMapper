//
//  AUAttributeMapping.h
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AUObjectMapping;
@interface AUAttributeMapping : NSObject

@property (nonatomic, weak, readonly) AUObjectMapping *objectMapping;

@property (nonatomic, copy, readonly) NSString *sourceKeyPath;
@property (nonatomic, copy, readonly) NSString *destinationKeyPath;

@property (nonatomic, strong) id valueTransformer;

+ (instancetype)attributeMappingFromKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath;
@end
