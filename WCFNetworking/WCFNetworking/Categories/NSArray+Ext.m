//
//  NSArray+SCAddition.m
//  SCFramework
//
//  Created by Angzn on 3/5/14.
//  Copyright (c) 2014 Richer VC. All rights reserved.
//

#import "NSArray+Ext.h"
#import <objc/runtime.h>

@implementation NSArray (Ext)

/**
 *  @brief 判断是否为空
 */
- (BOOL)isNotEmpty
{
    return (![(NSNull *)self isEqual:[NSNull null]]
            && [self isKindOfClass:[NSArray class]]
            && self.count > 0);
}

@end


@implementation NSMutableArray(Ext)

+ (void)load
{
//    [self swizzeAddobject];
}

+ (void)swizzeAddobject
{
    Method old = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method new = class_getInstanceMethod(self, @selector(addSaveObject:));
    if (!old || !new) {
        return;
    }
    method_exchangeImplementations(old, new);
}

//NSArray添加数据，如果数据为NSNull类型,则添加@""
- (void)addSaveObject:(id)anObject
{
    if (anObject!=nil) {
        [self addSaveObject:anObject];
    }else{
        [self addSaveObject:@""];
    }
}

+ (NSMutableArray *)arrayWithCapacity:(NSUInteger)capacity
                           withObject:(id)theObject
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:capacity];
    for (int i = 0; i < capacity; ++i) {
        [array replaceObjectAtIndex:i withObject:theObject];
    }
    return array;
}

- (void)replaceAllObjectsWithObject:(id)theObject
{
    if (!self.isNotEmpty) {
        return;
    }
    if (!theObject) {
        return;
    }
    for (int i = 0; i < [self count]; ++i) {
        [self replaceObjectAtIndex:i withObject:theObject];
    }
}

- (void)replaceAllObjectsWithNULL
{
    [self replaceAllObjectsWithObject:[NSNull null]];
}

@end
