//
//  MyCollectionViewCell.m
//  wey_tools
//
//  Created by wey on 16/1/11.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.f;
}

@end
