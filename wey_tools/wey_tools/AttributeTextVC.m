//
//  AttributeTextVC.m
//  wey_tools
//
//  Created by wey on 16/1/21.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "AttributeTextVC.h"
#import "UIView+point.h"
#import "PageViewController.h"
// 数据源 布局管理器 容器 显示文本
// textstorage(数据源) layoutmanager(管理者) textcontainers (各自位置) textViews(UIlabel ,uitextField,uitextVIew)
@interface AttributeTextVC () <UITextViewDelegate>
@property (nonatomic ,strong) UIView *iview;
//@property (weak, nonatomic) IBOutlet UITextView *mainText;
@property (nonatomic, strong)  UITextView *mainText;
@property (nonatomic ,strong) NSMutableAttributedString *jumpString;
@end
// 已拓展 已维护 已管理
@implementation AttributeTextVC

- (void)rightAction:(UIBarButtonItem *)sender {
//    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page"];
//
//    [self showViewController:vc sender:nil];
    
    PageViewController *vc = [[PageViewController alloc]init];
    [self showViewController:vc
                      sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark ---  NSAttributedString
//    NSTextStorage
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    _iview = view;
    [self.view addSubview:view];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分页阅读器" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    
    view.kHeight = 10;
    NSLog(@"%.2f",view.kHeight);
    view.name = @"s.b";
    NSLog(@"%@",view.name);
 
    NSString *text = @"点击“Fix Issue”还是TM不行！！MLGBD，(--http://www.baidu.com--) 老是提示指定UUID的provisioning profile找不到，感觉很怪异。我明明重新注册UDID，重新生成provisioning profile，并且重新安装，TMD为毛还不行；百度好多都不给力，只好谷歌；\n还真通过谷歌找到了\t\t\t\t答案，虽然是英文的，但是勉强着有道着还是大概知道了原因所在！！点击“Fix Issue”还是TM不行！！MLGBD，老是提示指定UUID的provisioning profile找不到，感觉很怪异。我明明重新注册UDID，重新生成provisioning profile，并且重新安装，TMD为毛还不行；百度好多都不给力，只好谷歌；\n还真通过谷歌找到了\t\t\t\t答案，虽然是英文的，但是勉强着有道着还是大概知道了原因所在！！点击“Fix Issue”还是TM不行！！MLGBD，老是提示指定UUID的provisioning profile找不到，感觉很怪异。我明明重新注册UDID，重新生成provisioning profile，并且重新安装，TMD为毛还不行；百度好多都不给力，只好谷歌；\n还真通过谷歌找到了\t\t\t\t答案，虽然是英文的，但是勉强着有道着还是大概知道了原因所在！！点击“Fix Issue”还是TM不行！！MLGBD，老是提示指定UUID的provisioning profile找不到，感觉很怪异。我明明重新注册UDID，重新生成provisioning profile，并且重新安装，TMD为毛还不行；百度好多都不给力，只好谷歌；\n还真通过谷歌找到了\t\t\t\t答案，虽然是英文的，但是勉强着有道着还是大概知道了原因所在！！";
    // \n \t 可以换行
    self.mainText = [[UITextView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 10, self.view.frame.size.height - 100)];
    [self.view addSubview:self.mainText];
//    self.mainText.userInteractionEnabled = NO;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];
    // 修改字体样式 注意使用的时候先让所有的字体保持一致,给全部文字一个初始的值
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, text.length)];
    
//    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:[text rangeOfString:@"点击"]];
    [string addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 2)];
    //MARK MAIN  MARK DOWN
    
    
    
    // 段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    // 行 间距
    style.lineSpacing = 10; // 点
    // 段落
    // @2x @3x 向下兼容不需要@1x
    style.paragraphSpacing = 50;//逻辑像素
    // 文本间距
    [string addAttributes:@{NSKernAttributeName :@(5)} range:NSMakeRange(0, 100)];
    // 删除线 下划线 value 是NSUnderLineStyle 的返回值 (注意:删除线 只可以 0 1 )
    [string addAttributes:@{NSStrikethroughColorAttributeName:[UIColor redColor],NSStrikethroughStyleAttributeName:@1,NSUnderlineColorAttributeName :[UIColor yellowColor ],NSUnderlineStyleAttributeName:@1} range:NSMakeRange(10, 10)];
    // 首行缩进
    style.firstLineHeadIndent = 36; // 逻辑像素
    // 描边 镂空 最优3.0
    [string addAttributes:@{NSStrokeColorAttributeName:[UIColor greenColor],NSStrokeWidthAttributeName:@3.0} range:NSMakeRange(0,2)];
    // 颜色
    [string addAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor],NSBackgroundColorAttributeName:[UIColor yellowColor]} range:NSMakeRange(10, 10)];
    
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.jumpString = string;
    
#pragma mark --- 网络连接  响应链表(断开响应连)
    [string addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"]} range:[text rangeOfString:@"http://www.baidu.com"]];
    self.mainText.editable = NO;
    
    self.mainText.delegate = self;
    // 顺序 最后在加上
    self.mainText.attributedText = string;
    
}

//
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    // 点完网址
    // mutablecopy
    [self.jumpString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:@"http://www.fakecoder.cn"]} range:characterRange];
    // 此时self.mainText.attrabutedText 已经设置好了,所以要从新赋值
    self.mainText.attributedText = self.jumpString;
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
