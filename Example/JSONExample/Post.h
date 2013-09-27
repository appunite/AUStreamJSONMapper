//
//  Post.h
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) User *user;

@end
