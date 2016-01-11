//
//  UIBarButtonItem+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (Extension)


//设置barbarturnItem 的点击是一张图片,点击下去之后是另一张图片,
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
