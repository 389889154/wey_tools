//
//  MD5ViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "MD5ViewController.h"
#import "NSString+md5Sting.h"

#import <CommonCrypto/CommonCrypto.h>

@interface MD5ViewController ()

@end

@implementation MD5ViewController

/*
 
 C 语言类型
 基本,构造,指针,空
 hash 比较快
 MD5 sha-one
 md5 不是加密算法,因为不能解密
 MD5:压缩性
 容易计算
 抗修改 只要改变一个值,MD5 就会改变
 抗碰撞 无法解码
 
 // 加密的长度 位数 意义 (条形码.二维码的区别)
 
 
 
 MD2:
 MD4:
 MD5:
 SHA-1:
 SHA-224:
 SHA-256:
 SHA-384:
 SHA-512:
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark --- 文字加密
    
    NSString *str = @"weisenhowe";
    NSString *str2=  [str MD5String];
    NSLog(@"%@",str2);
    

#pragma mark --- 文件加密
    
    NSString *JpgPath = [[NSBundle mainBundle] pathForResource:@"MD5" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:JpgPath];
    unsigned char result2[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result2);
    NSMutableString *strr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [strr appendFormat:@"%02x",result2[i]];
    }
    NSLog(@"%@-------",strr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
