//
//  ViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark --- 归档 反归档
    
    Person *p1 = [[Person alloc]init];
    p1.name = @"张三";
    p1.age = 12;
    p1.hobby = @"计算机";
    p1.gender = @"男";
    // 归档 序列化
    NSData *archiver = [NSKeyedArchiver archivedDataWithRootObject:p1];
    // 反归档 反序列化
    Person *p2 = [NSKeyedUnarchiver unarchiveObjectWithData:archiver];
    NSLog(@"%@,%@,%@,%ld",p2.name,p2.gender,p2.hobby,p2.age);

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
