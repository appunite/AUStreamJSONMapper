//
//  AUEntityMapping.h
//  Json
//
//  Created by Emil Wojtaszek on 26.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUObjectMapping.h"
#import <CoreData/CoreData.h>

@interface AUEntityMapping : AUObjectMapping

- (id)initWithEntity:(NSEntityDescription *)entityName;
+ (instancetype)mappingForEntity:(NSEntityDescription *)entity;

@property (nonatomic, strong, readonly) NSEntityDescription* entityDescription;
- (id)objectWithManagedObjectContext:(NSManagedObjectContext *)conetext;
@end
