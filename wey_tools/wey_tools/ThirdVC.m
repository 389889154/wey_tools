//
//  ThirdVC.m
//  wey_tools
//
//  Created by wey on 16/1/25.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "ThirdVC.h"
#import "AppDelegate.h"
@interface ThirdVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UITableView *tabelView;
@end

@implementation ThirdVC


- (UITableView *)tabelView {

    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
    }
    return _tabelView;
}
- (UIImageView *)headerView {
    
    

    if (!_headerView) {
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/3)];
        NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
        NSString *imageName = @"user-background";
        if (screenWidth.intValue < 400) {
            imageName = [NSString stringWithFormat:@"%@-%@", imageName, screenWidth];;
        }
        if (((AppDelegate *)[UIApplication sharedApplication].delegate).isNightModel) {
            imageName = [NSString stringWithFormat:@"%@-dark", imageName];
        }
        _headerView.image = [UIImage imageNamed:imageName];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    
    [self.view addSubview:self.tabelView];
    self.tabelView.tableHeaderView = self.headerView;
    
    _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default－portrait"]];
    [_headerView addSubview:_iconView];
    [_iconView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_headerView);
        make.width.height.equalTo(100.f);
    }];
    _iconView.layer.cornerRadius = 50;
    _iconView.layer.masksToBounds = YES;
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


#pragma mark --- tableView dataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"default－portrait"];
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height/2;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.shouldRasterize = YES;

 cell.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;

    return cell;
}



@end
