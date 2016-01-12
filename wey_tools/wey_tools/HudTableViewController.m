//
//  HudTableViewController.m
//  wey_tools
//
//  Created by wey on 16/1/12.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "HudTableViewController.h"
#import "HdMsgBox.h"
@interface HudTableViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) NSArray *item;
@property (nonatomic, strong) NSArray *item2;
@end

@implementation HudTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _item = @[@"text/文字",@"title text/loading",@" delegate/加载中文字",@"按钮/"];
    _item2 = @[@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 100;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {

    NSString *title = @"";
    switch (section) {

        case 0:
            title = @"alter  ";
            break;
        case 1:
            title = @"hud";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _item[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HdMsgBox *hud = [HdMsgBox sharedInstance];
    
    if (!indexPath.section) {

    switch (indexPath.row) {
        case 0:
            [hud showAlertText:@"description"];
            break;
        case 1:
            [hud showAlertTitle:@"title" text:@"description"];
            break;
        case 2:
            [hud showAlertTitle:@"title" text:@"description" delegate:nil cancelButtonTitle:nil okButtonTitle:@"ok"];
            break;
        case 3:
            [hud showAlertTitle:@"title" text:@"description" delegate:self cancelButtonTitle:@"cancel" okButtonTitle:@"ok"];
            break;
     
        default:
            break;
    }    } else {
        
        switch (indexPath.row) {
            case 0:
                [hud showHUDTextOnly:@"只有文字 1s" duration:1 inView:self.view];
                break;
            case 1:
                [hud showHUDLoading:self.view];
                break;
            case 2:
                [hud showHUDLoadingWithText:@"加载中..." inView:self.view];
                break;
            case 3:
            {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
                view.backgroundColor = [UIColor redColor];
                [hud showHUDCustomView:view withText:@"text" afterDelay:1 inView:self.view];
                 }
                break;
            case 4:

                break;
            case 5:

                break;
                
            default:
                break;
        }
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex==1) {
        NSLog(@"1");
    }else {
    
        NSLog(@"0");
    }
}

@end
