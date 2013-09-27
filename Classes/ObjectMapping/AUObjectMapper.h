//
//  AUMappingOperation.h
//  AUObjectMappings
//
//  Created by Emil Wojtaszek on 23.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AUObjectMapping;
@protocol AUObjectMapperDelegate;

@interface AUObjectMapper : NSObject

@property (nonatomic, weak) id<AUObjectMapperDelegate> delegate;
@property (nonatomic, strong, readonly) id mappings;

- (id)initWithMappings:(id)mappings;
- (void)mapObject:(NSDictionary *)object;
@end

@protocol AUObjectMapperDelegate <NSObject>
@optional
- (void)mapper:(AUObjectMapper *)mapper didMapObject:(id)object belongsTo:(id)belongObject;
- (void)mapper:(AUObjectMapper *)mapper willMapObject:(id)object withMappings:(AUObjectMapping *)objectMappings;
@end
