//
//  NSObject+AutoEncode.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "NSObject+AutoEncode.h"
#import <objc/objc-runtime.h>
@implementation NSObject (AutoEncode)

// 反归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [self init]; // 此方法是nsobject 基类 无法super
    if (self) {
        unsigned int ivarCount = 0;
        // 获取实例变量列表
        Ivar *ivarArr = class_copyIvarList([self class], &ivarCount);
        for (int a = 0; a<ivarCount; a++) {
            Ivar var = ivarArr[a];
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(var)];
            // 获取反归档的value
            id value = [aDecoder decodeObjectForKey:ivarName];
            // KVC 赋值
            [self setValue:value forKey:ivarName];
        }
    }
    return self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int ivarCount = 0;
    Ivar *ivarArr = class_copyIvarList([self class], &ivarCount);
    for (int a = 0; a<ivarCount; a++) {
        Ivar var = ivarArr[a];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(var)];
        id value = [self valueForKey:ivarName];
        [aCoder encodeObject:value forKey:ivarName];
    }
}


#pragma mark --- 非runtime

/*

 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
 
 self = [super init];
 
 if (self) {
 
 self.name = [aDecoder decodeObjectForKey:@"name"];
 
 self.age = [aDecoder decodeIntegerForKey:@"age"];
 
 self.gender = [aDecoder decodeObjectForKey:@"gender"];
 
 self.hobby = [aDecoder decodeObjectForKey:@"hobby"];
 
 }
 
 return self;
 
 }
 
 -(void)encodeWithCoder:(NSCoder *)aCoder {
 
 [aCoder encodeObject:self.name forKey:@"name"];
 
 [aCoder encodeObject:self.gender forKey:@"gender"];
 
 [aCoder encodeObject:self.hobby forKey:@"hobby"];
 
 [aCoder encodeInteger:self.age forKey:@"age"];
 
 }
 
 */

@end
