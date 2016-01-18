//
//  FmdbDemoViewController.m
//  wey_tools
//
//  Created by wey on 16/1/16.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "FmdbDemoViewController.h"
#import "DataHelper.h"
@interface FmdbDemoViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FmdbDemoViewController

- (void)addAction {
    
    [self.navigationController showViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addd"] sender:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark --- 导入Sqlite 3.0
    

    self.title  = @"人员列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addAction)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
