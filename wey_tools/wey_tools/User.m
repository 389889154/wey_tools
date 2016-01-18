//
//  User.m
//  wey_tools
//
//  Created by wey on 16/1/17.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:self.email forKey:@"email"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
    }
    return self;
}

@end
