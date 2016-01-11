//
//  NSString+md5Sting.m
//  commanCrypto
//
//  Created by wey on 16/1/7.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "NSString+md5Sting.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (md5Sting)

- (instancetype) MD5String {
   
    unsigned char result[CC_MD5_DIGEST_LENGTH];
     // 其余都一样 只是换一个数组 比如CC_MD2
//    CC_MD2(<#const void *data#>, <#CC_LONG len#>, <#unsigned char *md#>)
    CC_MD5([self UTF8String], CC_MD5_DIGEST_LENGTH, result);
    CC_MD5([self UTF8String], (CC_LONG)self.length, result);
    NSMutableString *target = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [target appendFormat:@"%02x",result[i]];
    }
    
    
    
    return target.copy;
}

@end
