//
//  LoopViewController.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#define kSize [UIScreen mainScreen].bounds.size

// SDWebimg
#import "LoopViewController.h"

@interface LoopViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *item;
@end

@implementation LoopViewController

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.minimumLineSpacing = 1.f;
//        layout.minimumInteritemSpacing = 1.f;
        layout.itemSize = CGSizeMake(kSize.width, kSize.height/3);
        _collectionView.pagingEnabled = YES;
        
    }
    return _collectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _item = @[@"first",@"second",@"three",@"four",@"five",@"six"];
    
    
}

#pragma mark --- collectionView DataSource




@end
