//
//  GuidePageVIew.h
//  wey_tools
//
//  Created by wey on 16/2/26.
//  Copyright © 2016年 wey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageVIew : UIView

@property(nonatomic,strong)NSArray *imageDatas;
@property(nonatomic,copy)void (^buttonAction)();

- (instancetype)initWithImageDatas:(NSArray *)imageDatas completion:(void(^)(void))buttonAction;


@end
