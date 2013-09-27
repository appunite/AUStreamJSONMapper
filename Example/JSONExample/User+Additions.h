//
//  User+Additions.h
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "User.h"
#import "AUEntityMapping.h"

@interface User (Additions)
+ (AUEntityMapping *)attributeObjectMappingWithContext:(NSManagedObjectContext *)context;
@end
