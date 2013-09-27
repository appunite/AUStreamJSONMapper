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

- (id)initWithEntityForName:(NSString *)entityName;
+ (instancetype)mappingForEntityForName:(NSString *)entityName;

@property (nonatomic, copy, readonly) NSString* entityName;

- (id)objectWithManagedObjectContext:(NSManagedObjectContext *)context;
@end
