//
//  DataHelper.h
//  wey_tools
//
//  Created by wey on 16/1/16.
//  Copyright © 2016年 wey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject


+ (instancetype)shareInstance;
// 插入公司数据
- (void)insertCompanyWithName:(NSString *)name;
// 所有公司数据
- (void)queryAllCompanyName:(void(^)(NSArray *resultArr))success :(void(^)())error;

@end
