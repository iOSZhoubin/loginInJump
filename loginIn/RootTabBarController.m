//
//  RootTabBarController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/4.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "RootTabBarController.h"
#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000
#import "VPNConnectViewController.h"
#import "VPNResourcesViewController.h"
#import "VPNMessageViewController.h"
#import "VPNMainMeViewController.h"
#import "VPNTabBarBtn.h"
@implementation RootTabBarController
{
    UIButton *_button;
    UIButton *notificationBtn;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBar];
}




-(void)setTabBar{
    
    
    //设置统一样式UI_APPEARANCE_SELECTOR
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = dict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    
    //添加子控制器
    
    VPNConnectViewController *connectViewController = [[VPNConnectViewController alloc]init];
    [self setVc:connectViewController title:@"网络连接" image:@"home2" selectImage:@"home1"];
    
    VPNResourcesViewController *resourcesViewController = [[VPNResourcesViewController alloc]init];
    [self setVc:resourcesViewController title:@"资源列表" image:@"sources2" selectImage:@"sources1"];
    
    VPNMessageViewController *messageViewController = [[VPNMessageViewController alloc]init];
    [self setVc:messageViewController title:@"消息中心" image:@"message2" selectImage:@"message1"];
    
    VPNMainMeViewController *mainMeViewController = [[VPNMainMeViewController alloc]init];
    [self setVc:mainMeViewController title:@"个人中心" image:@"me2" selectImage:@"me1"];


}

-(void)setVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *images = [UIImage imageNamed:selectImage];
    images = [images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = images;
    [self addChildViewController:nav];
    
}

@end
