//
//  SVPShow.m
//  L2CSmartMotor
//
//  Created by feaonline on 2018/9/25.
//  Copyright © 2018年 feaonline. All rights reserved.
//

#import "SVPShow.h"
#import "SVProgressHUD.h"
//#import "UIImage+GIF.h"

static CGFloat svpTime = 2.0;

static UIView *gifView;

@implementation SVPShow

+ (void)show {
 
    [self setStyle];
    [SVProgressHUD show];
}

//基本设置
+ (void)setStyle{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0, 0.8 * 255)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

+ (void)disMiss {
    
    [SVProgressHUD dismiss];
    
}

+ (void)showSuccessWithMessage:(NSString *)messgae {
    
    [self setStyle];
    
    [SVProgressHUD showSuccessWithStatus:messgae];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

+ (void)showFailureWithMessage:(NSString *)message {
    

    [self setStyle];
    [SVProgressHUD showErrorWithStatus:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

+ (void)showInfoWithMessage:(NSString *)message {

    [self setStyle];
    [SVProgressHUD showInfoWithStatus:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(svpTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

@end
