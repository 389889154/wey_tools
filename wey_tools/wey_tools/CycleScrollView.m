//
//  CycleScrollView.m
//  CycleView
//
//  Created by 郭艳芳 on 16/1/14.
//  Copyright © 2016年 郭艳芳. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView ()

@property (nonatomic, strong) UIScrollView *scrollView; // 滑动视图
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *animationTimer; // 定时器

@property (nonatomic, assign) NSTimeInterval animationDuration; // 动画延迟间隔
@property (nonatomic, assign) NSInteger currentPageIndex; // 当前页面
@property (nonatomic, strong) NSMutableArray *contentViews; // 内容视图

@end


@implementation CycleScrollView

#pragma mark 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.autoresizesSubviews = YES; // 设置子视图自动调整布局
        self.currentPageIndex = 0; // 默认当前是第一页
        
        // 创建UIScrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3*CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)); // 3倍屏幕宽
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0); // 显示中间的位置
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO; // 不允许反弹
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self; // 设置代理
        [self addSubview:self.scrollView];
        
        // 创建PageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)-100, CGRectGetHeight(self.scrollView.frame)-30, 100, 30)];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

// 自定义初始化方法
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationInterval {
    
    self = [self initWithFrame:frame];
    if (animationInterval > 0.0f) {
        self.animationDuration = animationInterval;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(animationTimeDidFired:) userInfo:nil repeats:YES];
        [self.animationTimer pauseTimer];

    }
    return self;
}

#pragma mark NSTimer的定时方法
- (void)animationTimeDidFired:(NSTimer *)timer {
    
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x+CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
    
}

// 重写totalPageCount的setter
- (void)setTotalPageCount:(NSInteger)totalPageCount {
    
    _totalPageCount = totalPageCount;
    if (_totalPageCount > 0) {
        
        // 配置内容有页面
        [self configContentView];
        
        // 开启定时器
        [self.animationTimer resumeTimerAfterTimerInterVal:self.animationDuration];
        
        // 设置总页数
        _pageControl.numberOfPages = self.totalPageCount;
        
    }
    
}

// 配置内容页面
- (void)configContentView {
    
    // 将scrollView上的视图全部移除
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 设置scrollView的内容数据
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView * contentView in self.contentViews) {
        
        contentView.userInteractionEnabled = YES;
        
        // 添加轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tap];
        
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame)*(counter++), 0);
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
        
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
}

// 设置scrollView的内容数据
- (void)setScrollViewContentDataSource {
    
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    // 获取前一个位置和后一个位置
    NSInteger beforePageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
    NSInteger afterPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
    if (self.featchContentViewAtIndex) {
        [self.contentViews addObject:self.featchContentViewAtIndex(beforePageIndex)];
        [self.contentViews addObject:self.featchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.featchContentViewAtIndex(afterPageIndex)];
    }
    
}

// 获取下一个页面位置
- (NSInteger)getNextPageIndex:(NSInteger)nextPageIndex {
    
    if (nextPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (nextPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return nextPageIndex;
    }
    
}

// 点击页面
- (void)contentViewTapAction:(UITapGestureRecognizer *)gesture {
    
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
    
}

#pragma mark UIScrollView的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 滑动视图时将定时器暂停，防止手动滑动与自动滑动的冲突
    [self.animationTimer pauseTimer];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 手动滑动结束之后，让定时器继续
    [self.animationTimer resumeTimerAfterTimerInterVal:self.animationDuration];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX >= 2*CGRectGetWidth(scrollView.frame)) {
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
        [self configContentView];
    }
    
    if (contentOffsetX <= 0) {
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
        [self configContentView];
    }
    _pageControl.currentPage = _currentPageIndex;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
    
}

@end
