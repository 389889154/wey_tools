//
//  MasonryViewController.m
//  wey_tools
//
//  Created by wey on 16/1/23.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "MasonryViewController.h"
@interface MasonryViewController ()
@property UIView *topView;
@property UIView *topInnerView;
@property UIView *bottomView;
@property UIView *bottomInnerView;
// 比例
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, assign) BOOL isTouch;

@end

@implementation MasonryViewController
// 变大
- (void)tapAction2:(UITapGestureRecognizer *)tap  {
    self.isTouch = !self.isTouch;
    
    [self.greenView updateConstraints:^(MASConstraintMaker *make) {
        if (self.isTouch) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(64);
            make.height.equalTo(400);
        }else {
            make.left.right.equalTo(self.view);
            make.top.equalTo(64);
            make.height.equalTo(100);
        }
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isTouch = NO;
    _greenView = [[UIView alloc]init];
    
    _greenView.backgroundColor = UIColor.greenColor;
    _greenView.layer.borderColor = UIColor.blackColor.CGColor;
    _greenView.layer.borderWidth = 2;
    [self.view addSubview:_greenView];
    [self.greenView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(64);
        make.height.equalTo(100);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    [self.greenView addGestureRecognizer:tap
     ];

}

- (void)updateViewConstraints {

    [self.greenView updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(100 *self.scale).priorityLow();
    }];
    [super updateViewConstraints];
}
// 基本
- (void)base{
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self.view addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self.view addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self.view addSubview:blueView];
    
    UIView *superView = self.view;
    CGFloat padding = 10.f;
    
    [greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(superView).offset(padding);
        make.right.equalTo(redView.left).offset(-padding);
        make.bottom.equalTo(blueView.top).offset(-padding);
        
        make.width.height.equalTo(redView);
        make.height.equalTo(blueView);
    }];
    
    [redView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(padding);
        make.right.equalTo(superView).offset(-padding);
        make.bottom.equalTo(blueView.top).offset(-padding);
        
    }];
    
    [blueView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(padding);
        make.bottom.right.equalTo(superView).offset(-padding);
    }];
    
    
}
// 点击填充
- (void)base1 {
    _greenView = [[UIView alloc]init];
    
    _greenView.backgroundColor = UIColor.greenColor;
    _greenView.layer.borderColor = UIColor.blackColor.CGColor;
    _greenView.layer.borderWidth = 10;
    [self.view addSubview:_greenView];
    self.scale = 1.f;
    [self.greenView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(100.f).priorityLow();
        make.width.height.lessThanOrEqualTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_greenView addGestureRecognizer:tap];
    
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
        self.scale+=1;
    [self.view setNeedsLayout];
    [self updateViewConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
