//
//  UIColor+Util.h
//  wey_tools
//
//  Created by wey on 16/1/25.
//  Copyright © 2016年 wey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)
/** 16进制 */
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

/** 主题色 */
+ (UIColor *) themeColor;
+ (UIColor *)navigationbarColor;
+ (UIColor *)titleBarColor;

@end
