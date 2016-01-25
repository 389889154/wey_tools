//
//  NSArray+Beyond.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "NSArray+Beyond.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSArray (Beyond)

+(void)load {

    Method originMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newMethod = class_getInstanceMethod([self class], @selector(wey_objectAtIndex:));
    method_exchangeImplementations(originMethod, newMethod);
}

- (id)wey_objectAtIndex:(NSUInteger)index {

    if (index<self.count) {
        return [self wey_objectAtIndex:index]; // 此时已经交换 不会死循环
    }
    NSLog(@"数组越界");
    return nil;
}

@end
