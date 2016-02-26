//
//  AppDelegate.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UIColor+Util.h"
#import "GuidePageVIew.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark --- 测试账号
//if (![[NSUserDefaults standardUserDefaults] boolForKey:@"init"]) {
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"init"];
//    user *model = [[user alloc]init];
//    model.userName = @"admin123";
//    model.password = @"admin123";
//    [[DateHelper shareInstance] addUser:model];
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:[[RootViewController alloc]init]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    
    self.isNightModel = [[NSUserDefaults standardUserDefaults] boolForKey:@"isNightMode"];
    NSLog(@"%d",self.isNightModel);
    
    /************ 控件外观设置 **************/
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithHex:0x15A230]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x15A230]} forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor titleBarColor]];
    
    
    // 引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"start"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"start"];
        [self setGuidePage];
    }

    

    return YES;
}

- (void)setGuidePage {

    NSArray *imgArr = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    GuidePageVIew *startView = [[GuidePageVIew alloc]init];
    startView.imageDatas = imgArr;
    __weak typeof(GuidePageVIew) *weakStartView = startView;
    startView.buttonAction = ^{
        [UIView animateWithDuration:2.f animations:^{
            weakStartView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakStartView removeFromSuperview];
        }];
    };
    [self.window addSubview:startView];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
