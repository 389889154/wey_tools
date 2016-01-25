
//
//  MsgViewController.m
//  wey_tools
//
//  Created by wey on 16/1/24.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "MsgViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface MsgViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)  UIImageView *portrait;
@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //    [[SDImageCache sharedImageCache] clearMemory];
    //    [[SDImageCache sharedImageCache] clearDisk];
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [telBtn setTitle:@"打电话+10086" forState:UIControlStateNormal];
    [self.view addSubview:telBtn];
    [telBtn addTarget:self action:@selector(telAction:) forControlEvents:UIControlEventTouchUpInside];
    [telBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(164);
        make.width.equalTo(100);
        make.height.equalTo(30);
        make.left.equalTo(20);
    }];
    
    UIButton *appBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [appBtn setTitle:@"appStore " forState:UIControlStateNormal];
    [self.view addSubview:appBtn];
    [appBtn addTarget:self action:@selector(appAction:) forControlEvents:UIControlEventTouchUpInside];
    [appBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telBtn.bottom).offset(30);
        make.width.equalTo(100);
        make.height.equalTo(30);
        make.left.equalTo(20);
    }];
    
    _portrait = [[UIImageView alloc]init];
    _portrait.image = [UIImage imageNamed:@"placeHolder"];
    [self.view addSubview:_portrait];
    [_portrait makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(100);
        make.center.equalTo(self.view);
    }];
    _portrait.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapV = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPortrait)];
    [_portrait addGestureRecognizer:tapV];
    
    
}
- (void) appAction:(UIButton *)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/you-min-lu-tu/id1072357838?mt=8"]];
}

- (void)telAction:(UIButton *)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"10086"]]];
}

// 分享


// 调用相机
- (void)tapPortrait
{
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"更改头像" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self lib];
    }]];
    [vc addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }]];
    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)lib {
    // 本地相册
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.allowsEditing  = YES;

    imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:imgPicker animated:YES completion:nil];
}
- (void)camera {
    // 拍照
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Device has no camera"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        
        [alertView show];
    }else {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
//        http://www.cnblogs.com/geory/archive/2013/03/26/2979895.html moblieCoreService
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
    //UIImageWriteToSavedPhotosAlbum(edit, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

 [picker dismissViewControllerAnimated:YES completion:^{
     self.portrait.image = info[UIImagePickerControllerOriginalImage];
     NSData *data = UIImageJPEGRepresentation(self.portrait.image, 0.5);
     [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"img"];
 }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
