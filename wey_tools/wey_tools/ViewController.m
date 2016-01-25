//
//  ViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
#pragma mark --- 消息发送机制
    //    ios9 需要build setting 设置 msg no 才可以使用消息发送机制
    
    Person *p = objc_msgSend(objc_msgSend(objc_getClass("Person"), @selector(alloc)), @selector(init));
    //    Person *p = objc_msgSend(objc_msgSend([Person class],@selector(alloc)),@selector(init));
    //    Person *p = [[Person alloc]init];
    objc_msgSend(p, @selector(setName:),@"李四");
    NSLog(@"%@",objc_msgSend(p, @selector(name)));
    
 #pragma mark --- 获取类的实例变量
    
    unsigned int ivarCount = 0;
    Ivar *ivarArr = class_copyIvarList([Person class], &ivarCount);
    for (int a= 0; a<ivarCount; a++) {
        Ivar var = ivarArr[a];
        NSLog(@"%s",ivar_getName(var)); // (_name)
        NSLog(@"%s",ivar_getTypeEncoding(var)); // 类型编码 (NSString)
    }
    
#pragma mark --- 获取类的方法
    // get 隐藏参数 消息接受者 消息
    unsigned int methodCount = 0;
    Method *methodArr = class_copyMethodList([Person class], &methodCount);
    for (int a= 0; a<methodCount; a++) {
        Method m = methodArr[a];
        NSLog(@"%s",sel_getName( method_getName(m)));
        NSLog(@"%s",method_getTypeEncoding(m));
    }
    
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
    
#pragma mark --- 交换方法
    // A方法
    [self A];
    // B方法
    [self B];
    
    Method methodA = class_getInstanceMethod([self class], @selector(A));
    Method methodB = class_getInstanceMethod([self class], @selector(B));
    method_exchangeImplementations(methodA, methodB);
    [self A];
    [self B];

#pragma mark -- 动态添加方法 
    
    //    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    void(^newMethod)(id,SEL) = ^(id objc_self ,SEL objc_cmd) {
        NSLog(@"%s",sel_getName(objc_cmd));
    };
    class_addMethod([self class], sel_registerName("theNewMethod"), imp_implementationWithBlock(newMethod), "v@:");
    //    objc_msgSend(self, sel_registerName("haha"));
    [self performSelector:@selector(theNewMethod)];
    
#pragma mark --- 动态添加属性
    
    objc_setAssociatedObject(self, "name", @"我是 视图控制器", OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSLog(@"%@",objc_getAssociatedObject(self, "name"));

    
}
- (void)A {
    NSLog(@"aaaa");
#pragma mark ---  强行抛出异常
    //        @throw [NSException exceptionWithName:@"异常名字" reason:@"异常理由" userInfo:@{@"key":@"value"}];
}

- (void)B {
    NSLog(@"bbbb");
    
    
    /** flag 是否被定义 */
#define flag
#ifdef flag
    NSLog(@"flag 定义过");
    
#else
    NSLog(@"flag 未定义");
#endif
    /** 常量 */
#if 0
    NSLog(@"ture");
#else
    NSLog(@"false");
#endif
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- tabbar navigationBar

- (void)setView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *selectImg = [[UIImage imageNamed:@"fav_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:selectImg style:UIBarButtonItemStyleDone target:self action:@selector(favAction:)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
}

- (void) favAction:(UIBarButtonItem *)sender {
    
    sender.image = [[UIImage imageNamed:@"fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
@end
