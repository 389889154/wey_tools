//
//  NSTimer+Addition.m
//  CycleView
//
//  Created by 郭艳芳 on 16/1/14.
//  Copyright © 2016年 郭艳芳. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

// 暂停
- (void)pauseTimer {
    
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

// 继续
- (void)resumeTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

// 在多少秒后继续
- (void)resumeTimerAfterTimerInterVal:(NSTimeInterval)timeInterval {
    
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
}

@end
