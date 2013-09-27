//
//  AUEntitiesMappingOperation.h
//  Json
//
//  Created by Emil Wojtaszek on 26.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUObjectMapper.h"

// Frameworks
#import <CoreData/CoreData.h>

@class AUEntityMapping;
@protocol AUEntityMapperDelegate;

@interface AUEntityMapper : AUObjectMapper

// managed object context
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

// override delegate protocol
- (id<AUEntityMapperDelegate>)delegate;
- (void)setDelegate:(__weak id<AUEntityMapperDelegate>)delegate;

@end

@protocol AUEntityMapperDelegate <AUObjectMapperDelegate>
@required
- (NSManagedObject *)mapper:(AUEntityMapper *)mapper findOrCreateObject:(id)object forMappings:(AUEntityMapping *)mapping;
@end
