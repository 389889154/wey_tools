//
//  CellHeighTableViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "CellHeighTableViewController.h"
#import "HeightModel.h"
@interface CellHeighTableViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation CellHeighTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缓存高度";
    NSString *target = @"RunTime简称运行时。就是系统在运行的时候的一些机制，其中最主要的是消息机制。对于C语言，函数的调用在编译的时候会决定调用哪个函数（ C语言的函数调用请看这里 ）。编译完成之后直接顺序执行，无任何二义性。OC的函数调用成为消息发送。属于动态调用过程。在编译的时候并不能决定真正调用哪个函数（事实证明，在编 译阶段，OC可以调用任何函数，即使这个函数并未实现，只要申明过就不会报错。而C语言在编译阶段就会报错）。只有在真正运行的时候才会根据函数的名称找 到对应的函数来调用";
    _items = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i<20; i++) {
        
        NSString *str = [target substringFromIndex:arc4random()%101];
        HeightModel *model = [[HeightModel alloc]init];
        model.text = str;
        model.cellheight = [self getCellHeightWith:str];
        [_items addObject:model];
    }
    [self.tableView reloadData];

    
}

- (CGFloat) getCellHeightWith:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 10, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeightModel *model = _items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 5, 1000)];
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:17];
        label.tag = 101;
        
        [cell.contentView addSubview:label];
    }
    UILabel *label = [cell.contentView viewWithTag:101];
    label.text = model.text;
    label.frame = CGRectMake(5, 0, self.view.frame.size.width - 5, model.cellheight);
    
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeightModel *model = _items[indexPath.row];
    NSLog(@"%.2f,",model.cellheight);
    return model.cellheight;
}




@end
