//
//  RootViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "RootViewController.h"
#import "LoopViewController.h"
#import "ViewController.h"
#import "CellHeighTableViewController.h"
#import "MD5ViewController.h"
#import "HudTableViewController.h"
@interface RootViewController ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MyTools";
    _items = @[@"loopIMG",@"runtime",@"缓存高度",@"MD5",@"HUD"];
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
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController showViewController:[[LoopViewController alloc]init] sender:nil];
            break;
        case 1:
            [self.navigationController showViewController:[[ViewController alloc]init] sender:nil];
            break;
        case 2:
            [self.navigationController showViewController:[[CellHeighTableViewController alloc]init] sender:nil];
            break;
        case 3:
            [self.navigationController showViewController:[[MD5ViewController alloc]init] sender:nil];
            break;
        case 4:
            [self.navigationController showViewController:[[HudTableViewController alloc]init] sender:nil];
            break;
            
            
        default:
            break;
    }
}



@end
