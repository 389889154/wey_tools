//
//  PageViewController.m
//  wey_tools
//
//  Created by wey on 16/1/21.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PageViewController



- (void)viewDidLoad {
    [super viewDidLoad];

   
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    NSString *text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"node" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    // 封装 storage
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:text];
    
    [storage addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.firstLineHeadIndent = 20;
    style.lineSpacing = 5;
    style.paragraphSpacing = 20;
    [storage addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
    // 创建layoutmanager  添加布局管理器(可以添加多个mgr)
    NSLayoutManager *mgr = [[NSLayoutManager alloc]init];
    [storage addLayoutManager:mgr];
    
   
    int i = 0;
    // 死循环
    while (YES) {
        
        // 添加贝塞尔路径
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
        UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 400) radius:100 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        
        // 创建容器
        NSTextContainer *container = [[NSTextContainer alloc]initWithSize:self.view.frame.size];
        container.exclusionPaths = @[path,path2];
        [mgr addTextContainer:container];
        
        //UITextView
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) textContainer:container];
        [_scrollView addSubview:textView];
        i++;
        
         self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * i, self.view.frame.size.height);
        
        // 判断是否可以跳出循环
        NSRange range = [mgr glyphRangeForTextContainer:container];
        if ((range.location + range.length) == text.length)  break;

    }
    
  

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
