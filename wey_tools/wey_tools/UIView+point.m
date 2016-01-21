//
//  UIView+point.m
//  wey_tools
//
//  Created by wey on 16/1/21.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "UIView+point.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char * const mytag = "tag";
@implementation UIView (point)

- (void)setKHeight:(CGFloat)kHeight {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kHeight)];
    
}

- (CGFloat)kHeight {
    return self.frame.size.height;
}

- (void)setName:(NSString *)name {

    objc_setAssociatedObject(self, mytag, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {

    return objc_getAssociatedObject(self, mytag);
}


@end
