//
//  AUObjectMapping.h
//  Mappings
//
//  Created by Emil Wojtaszek on 21.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//Mappings
#import "AUAttributeMapping.h"
#import "AURelationshipMapping.h"

@interface AUObjectMapping : NSObject

@property (nonatomic, weak, readonly) Class objectClass;

@property (nonatomic, strong, readonly) NSSet *mappings;
@property (nonatomic, strong, readonly) NSSet *attributeMappings;
@property (nonatomic, strong, readonly) NSSet *relationshipMappings;

- (id)object;

- (id)initWithClass:(Class)objectClass;
+ (instancetype)mappingForClass:(Class)objectClass;

- (void)addMapping:(AUAttributeMapping *)mappings;
- (void)removeMapping:(AUAttributeMapping *)mapping;

- (void)addMappingsFromDictionary:(NSDictionary *)mappings;
- (void)addMappingsFromArray:(NSArray *)mappings;

@end
