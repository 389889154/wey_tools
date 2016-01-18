//
//  AddTableViewController.m
//  wey_tools
//
//  Created by wey on 16/1/16.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "AddTableViewController.h"
#import "DataHelper.h"
@interface AddTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *companyText;
@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic, strong) NSMutableArray *companys;

@end

@implementation AddTableViewController

- (NSMutableArray *)companys {

    if (!_companys) {
        _companys = [NSMutableArray array];
    }
    return _companys;
}

#pragma mark --- pickView

- (void)loadCompanyData {
    [[DataHelper shareInstance] queryAllCompanyName:^(NSArray *resultArr) {
        self.companys = resultArr.mutableCopy;
        [self.pickView reloadAllComponents];
    } :^{
        NSLog(@"error");
    }];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.companys[row];
}
// 几列
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// 对应行数
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.companys.count;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.companyText.text = self.companys[row];
}

- (UIPickerView *)pickView {

    if (!_pickView) {
        _pickView = [[UIPickerView alloc]init];
        _pickView.backgroundColor = [UIColor redColor];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

- (void)ADdAction {

    UIAlertController *comVc = [UIAlertController alertControllerWithTitle:@"添加公司" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [comVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [comVc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            [[DataHelper shareInstance] insertCompanyWithName:comVc.textFields[0].text];
        [self loadCompanyData];
    }]];
    [comVc addTextFieldWithConfigurationHandler:nil];

    
    [self presentViewController:comVc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加人员";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加公司" style:UIBarButtonItemStyleDone target:self action:@selector(ADdAction)];
    
    self.companyText.inputView = self.pickView;
    [self loadCompanyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 保存个人记录
- (IBAction)okAction:(id)sender {
    
    
}


@end
