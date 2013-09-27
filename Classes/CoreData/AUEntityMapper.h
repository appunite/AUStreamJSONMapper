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

@interface AUEntityMapper : AUObjectMapper
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
