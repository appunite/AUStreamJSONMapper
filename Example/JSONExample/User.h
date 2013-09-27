//
//  User.h
//  JSONExample
//
//  Created by Emil Wojtaszek on 27.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet *posts;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPostsObject:(NSManagedObject *)value;
- (void)removePostsObject:(NSManagedObject *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

@end
