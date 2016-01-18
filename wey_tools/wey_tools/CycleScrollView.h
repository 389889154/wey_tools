//
//  CycleScrollView.h
//  CycleView
//
//  Created by 郭艳芳 on 16/1/14.
//  Copyright © 2016年 郭艳芳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView<UIScrollViewDelegate>

/**
 *  自定义初始化方法
 *
 *  @param frame             定义滚动视图的大小
 *  @param animationInterval 滚动的时间间隔
 *
 *  @return 返回当前初始化的对象
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationInterval;

// 图片页面的总个数
@property (nonatomic, assign) NSInteger totalPageCount;

// 刷新页面
@property (nonatomic, copy) UIView * (^featchContentViewAtIndex) (NSInteger pageIndex);

// 点击页面
@property (nonatomic, copy) void (^TapActionBlock)(NSInteger pageIndex);


@end
