//
//  OneTableViewController.m
//  wey_tools
//
//  Created by wey on 16/2/26.
//  Copyright © 2016年 wey. All rights reserved.
//
#import "TableViewCellOne.h"
#import "OneTableViewController.h"
#define kCell_Height 44
@interface OneTableViewController ()
@property (nonatomic, strong) NSMutableArray *stateArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation OneTableViewController

- (void)initDataSource {
    
    self.sectionArray = @[@"itemA",@"itemB",@"itemC",@"itemD"].mutableCopy;
    NSArray *one = @[@"one"];
    NSArray *two = @[@"two",@"two"];
    NSArray *three = @[@"three",@"three",@"three"];
    NSArray *four = @[@"four",@"four",@"four",@"four"];
    
    self.dataSource = @[one,two,three,four].mutableCopy;
    self.stateArray = [NSMutableArray array];
    
    for (int i = 0; i<self.dataSource.count; i++) {
        // 所有分区闭合
        [self.stateArray addObject:@"0"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"折叠的tableView";
    [self initDataSource];
    self.tableView.rowHeight = kCell_Height;
//    [self.tableView registerClass:[TableViewCellOne class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCellOne" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.stateArray[section] isEqualToString:@"1"]) {
        // 如果是展开状态
        NSArray *array = [self.dataSource objectAtIndex:section];
        return array.count;
    } else {
        // 闭合状态
        return 0;
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.listLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.listLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

// headerView
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    return self.sectionArray[section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(touchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kCell_Height-22)/2, 22, 22)];
    [imgView setImage:[UIImage imageNamed:@"ico_faq_d"]];
    [button addSubview:imgView];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (kCell_Height-6)/2, 10, 6)];
    
    if ([self.stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([self.stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (kCell_Height-20)/2, 200, 20)];
//    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:self.sectionArray[section]];
    [button addSubview:tlabel];
    return button;

}

// selection Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
}


- (void)touchBtnAction:(UIButton *)sender {

    //TODO: 优化
    if ([self.stateArray[sender.tag - 1] isEqualToString:@"1"]) {
        [self.stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else {
        [self.stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return kCell_Height;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.00001;
}
@end
