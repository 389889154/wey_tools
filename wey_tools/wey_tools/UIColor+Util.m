//
//  UIColor+Util.m
//  wey_tools
//
//  Created by wey on 16/1/25.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "UIColor+Util.h"
#import "AppDelegate.h"
@implementation UIColor (Util)
/** 16进制 */
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}
/** 主题色 */
+ (UIColor *) themeColor {
    if (((AppDelegate *)[UIApplication sharedApplication].delegate).isNightModel) {
        return [UIColor darkGrayColor];
    }else {
        return [UIColor whiteColor];
    }
}

+ (UIColor *)navigationbarColor {
    if (((AppDelegate *)[UIApplication sharedApplication].delegate).isNightModel) {
        return [UIColor darkGrayColor];
    }
    //    return [UIColor colorWithHex:0x15A230];//0x009000
    return [UIColor lightGrayColor];
}

+ (UIColor *)titleBarColor {
    if (((AppDelegate *)[UIApplication sharedApplication].delegate).isNightModel) {
        return  [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    }
    return [UIColor colorWithHex:0xE1E1E1];
}
@end
