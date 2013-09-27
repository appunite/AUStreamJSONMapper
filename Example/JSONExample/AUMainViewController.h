//
//  AUMainViewController.h
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "JSON.h"
#import "ObjectMapping.h"
#import "AUEntityMapper.h"

@interface AUMainViewController : UIViewController <AUEntityMapperDelegate, AUJSONDeserializerOperationDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
