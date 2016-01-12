//
//  DefineConstant.h
//  wey_tools
//
//  Created by wey on 15/1/12.
//  Copyright © 2015年 wey. All rights reserved.
//

#ifndef DefineConstant_h
#define DefineConstant_h

#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO)
#define ApplicationScreenHeight ([[UIScreen mainScreen] bounds].size.height - (iOS7?0:20))
#define ApplicationScreenWidth ([[UIScreen mainScreen] bounds].size.width)


#define kWeakSelf(weakSelf) __weak __typeof(self)weakSelf = self;

/** 打印 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
/*
 #define DEBUGLOG
 #ifdef DEBUGLOG
 #define NSLog(...) NSLog(__VA_ARGS__)
 #else
 #define NSLog(...)
 #endif
 -----
 #define DEBUGLOG 1
 #if DEBUGLOG
 #define NSLog(...) NSLog(__VA_ARGS__)
 #else
 #define NSLog(...)
 #endif
 */

//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]























/** 消除警告 push<warn>pop */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
#pragma clang diagnostic pop
//“-Wincompatible-pointer-types”为警告类型
//clang为编译器名,这里也可以替换为GCC
#pragma clang diagnostic ignored后面只能跟一个忽略警告类型
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic pop

/** 
 //已知的一些编译警告类型
 -Wincompatible-pointer-types 指针类型不匹配
 -Wincomplete-implementation 没有实现已声明的方法
 -Wprotocol 没有实现协议的方法
 -Wimplicit-function-declaration 尚未声明的函数(通常指c函数)
 -Warc-performSelector-leaks 使用performSelector可能会出现泄漏(该警告在xcode4.3.1中没出现过,网上流传说4.2使用performselector:withObject: 就会得到该警告)
 -Wdeprecated-declarations 使用了不推荐使用的方法(如[UILabel setFont:(UIFont*)])
 -Wunused-variable 含有没有被使用的变量
 */

#endif /* DefineConstant_h */
