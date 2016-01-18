//
//  User.h
//  wey_tools
//
//  Created by wey on 16/1/17.
//  Copyright © 2016年 wey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phoneNum;

@end
