//
//  AUMappingUtls.m
//  AUObjectMappings
//
//  Created by Emil Wojtaszek on 24.09.2013.
//  Copyright (c) 2013 AppUnite.com. All rights reserved.
//

#import "AUMappingUtls.h"

BOOL AUClassIsCollection(Class aClass)
{
    return (aClass && ([aClass isSubclassOfClass:[NSSet class]] ||
                       [aClass isSubclassOfClass:[NSArray class]] ||
                       [aClass isSubclassOfClass:[NSOrderedSet class]]));
}

BOOL AUObjectIsCollection(id object)
{
    return AUClassIsCollection([object class]);
}
