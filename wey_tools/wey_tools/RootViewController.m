//
//  RootViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "RootViewController.h"
#import "CycleViewController.h"
#import "ViewController.h"
#import "CellHeighTableViewController.h"
#import "MD5ViewController.h"
#import "HudTableViewController.h"
#import "FmdbDemoViewController.h"
#import "AttributeTextVC.h"
@interface RootViewController ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *classes;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MyTools";
    _items = @[@"loopIMG",@"runtime",@"缓存高度",@"MD5",@"HUD",@"FMDBDemo",@"富文本",@"电话/跳网页/短信/相机等"];
    _classes = @[[CycleViewController class],
                 [ViewController class],
                 [CellHeighTableViewController class],
                 [MD5ViewController class],
                 [HudTableViewController class],
                 [FmdbDemoViewController class],
                 [AttributeTextVC class]
                 ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIViewController *vc = [[_classes[indexPath.row] alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title  =_items[indexPath.row];
    [self.navigationController showViewController:vc sender:nil];
    
}

@end
