//
//  NSString +Extension.m
//  测试代码
//
//  Created by wey on 15/11/30.
//  Copyright © 2015年 wey. All rights reserved.
//

#import "NSString +Extension.h"

@implementation NSString (Extension)

- (NSString *)pinYin {

    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    return [result uppercaseString];
}

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
//计算文件或者文件夹得大小
-(NSInteger)fileSize{
    NSFileManager *mgr=[NSFileManager defaultManager];
    BOOL dir=NO;
    BOOL exists=[mgr fileExistsAtPath:self isDirectory:&dir];
    if (exists==NO) {
        return 0;
    }
    if (dir) {  //self 是一个文件夹
        NSArray *subPaths=[mgr subpathsAtPath:self];
        NSInteger totleSize=0;
        for (NSString *subpath in subPaths) {
            NSString *fullpath=[self stringByAppendingPathComponent:subpath];
            BOOL dir=NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
            if (dir==NO) {
                totleSize +=[[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] integerValue];
            }
        }
        return totleSize;

    }else {  // self 是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil] [NSFileSize] integerValue];
    
    }
 
}



- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isPhoneNumber
{
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
}

- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}
-(NSString *)URLEncodedString{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}





-(NSString *(^)())study{
    return ^{
        return self;
    };

}
-(NSString *(^)())run{

    return ^{
        return self;
    };

}


@end
