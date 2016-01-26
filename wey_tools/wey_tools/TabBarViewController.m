//
//  TabBarViewController.m
//  wey_tools
//
//  Created by wey on 16/1/25.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "UIColor+Util.h"
#import "UIView+Util.h"
@interface TabBarViewController ()
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) FirstVC *firstViewController;
@property (nonatomic, strong) SecondVC *secondViewController;
@property (nonatomic, strong) ThirdVC *thirdViewController;
@property (nonatomic, assign) BOOL isPressed;
@end

@implementation TabBarViewController
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightAction:) name:@"nightMode" object:nil];
}
- (void)nightAction:(NSNotification *)sender {
    
    self.firstViewController.view.backgroundColor = [UIColor themeColor];
    self.secondViewController.view.backgroundColor = [UIColor themeColor];
    self.thirdViewController.view.backgroundColor = [UIColor themeColor];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor titleBarColor]];
    
    // 遍历子navigationVC
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UINavigationController * _Nonnull nav, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];

}



- (void)viewDidLoad {
    [super viewDidLoad];
//View controller-based status bar appearance (info.plist)修改
    
    self.firstViewController = [[FirstVC alloc]init];
    [self addChildViewController:self.firstViewController title:@"新闻" img:@"tabbar-me" selectImg:@"tabbar-me-selected"];
    
    // 中间按钮
    [self addChildViewController:[[UIViewController alloc]init]];
    [self addCenterButton];
    
    
    self.thirdViewController = [[ThirdVC alloc]init];
    [self addChildViewController:self.thirdViewController title:@"个人" img:@"tabbar-me" selectImg:@"tabbar-me-selected"];
    
    
    
}


- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title img:(NSString *)imgName selectImg:(NSString *)selectImgName {
    
    childController.title = title;
    UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImg = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:img selectedImage:selectImg];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nvc];
}

- (void) addCenterButton {

    _centerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
  CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize size = CGSizeMake(self.tabBar.frame.size.height, self.tabBar.
                             frame.size.height);
    _centerBtn.frame = CGRectMake(origin.x - size.height/2, origin.y - size.height/2, size.height, size.height);
    _centerBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _centerBtn.layer.borderWidth = 1.f;
    _centerBtn.layer.cornerRadius = size.height/2;
    [_centerBtn setBackgroundColor:[UIColor colorWithHex:0x24a83d]];
    [_centerBtn setImage:[UIImage imageNamed:@"tabbar-more"] forState:UIControlStateNormal];
    [_centerBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerBtn];
}

- (void)buttonPressed
{
    // 动画

    _isPressed = !_isPressed;
}

@end
