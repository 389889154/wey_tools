//
//  NSString +Extension.h
//  测试代码
//
//  Created by wey on 15/11/30.
//  Copyright © 2015年 wey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

// 根据一个字符串,字体,和最大的宽度,计算出所占的size大小.
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
-(CGSize)sizeWithFont:(UIFont *)font;

//根据一个文件或者文件夹的路径字符串,计算文件或者文件夹的大小.
-(NSInteger)fileSize;

//仅测试,链式变成,
-(NSString *(^)())study;
-(NSString *(^)())run;

-(NSString *)URLEncodedString;

/**
 *  利用正则表达式测试判断输入是不是qq.手机号,IP地址等.
 *
 *  @return 布尔值.
 */
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isIPAddress;

@end
