//
//  VPNAbusViewController.m
//  loginIn
//
//  Created by 马朝阳 on 16/3/18.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//  该页面为关于我们，当点击图片时实现快捷支持的功能，包括：打电话、发邮件、访问公司官网

#import "VPNAbusViewController.h"

@interface VPNAbusViewController ()

@end

@implementation VPNAbusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDColor;
    self.navigationItem.title = @"关于我们";
    UIImageView *imageView = [[UIImageView alloc] init];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"一键支持-2_02-2@.png"];
    [imageView setImage:image];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(64);
        make.height.equalTo(self.view.frame.size.height/2);
    }];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UserClicked:)];
    [imageView addGestureRecognizer:singleTap];
}

- (void)UserClicked:(UITapGestureRecognizer *)tap{
    NSLog(@"被点击");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"快捷支持" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"029-88333000",@"800-840-9939",@"support@jump.net.cn",@"http://www.jump.net.cn", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//调用系统的打电话功能
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://029-88333000"]];
    }
    if (buttonIndex == 1) {//调用系统的打电话功能
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://800-840-9939"]];
    }
    if (buttonIndex == 2) {//调用系统的邮箱功能
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:support@jump.net.cn"]];
    }
    if (buttonIndex == 3) {//调用系统的浏览器功能
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jump.net.cn"]];
    }
}

@end
