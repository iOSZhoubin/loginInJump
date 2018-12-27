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
//
//-(void)viewDidLoad{
//    [super viewDidLoad];
//    self.tabBar.hidden = YES;
//    [self initControllers];
//    [self creatTabBar:self.viewControllers.count];
//    [self initControllers];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnWithNotification:) name:@"mobileconfigFileSave" object:nil];
//
//}
//
//#pragma mark initControllers
//-(void)initControllers{
//    VPNConnectViewController *connectViewController = [[VPNConnectViewController alloc]init];
//    [self addViewControllers:connectViewController title:@"网络连接"];
//
//    VPNResourcesViewController *resourcesViewController = [[VPNResourcesViewController alloc]init];
//    [self addViewControllers:resourcesViewController title:@"资源列表"];
//
//    VPNMessageViewController *messageViewController = [[VPNMessageViewController alloc]init];
//    [self addViewControllers:messageViewController title:@"消息中心"];
//
//    VPNMainMeViewController *mainMeViewController = [[VPNMainMeViewController alloc]init];
//    [self addViewControllers:mainMeViewController title:@"个人中心"];
//
//}
//
//#pragma mark addViewControllers
//-(void)addViewControllers:(UIViewController *)childController title:(NSString *)title{
//    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:childController];
//    childController.navigationItem.title = title;
//
//    childController.navigationItem.titleView.backgroundColor = [UIColor redColor];
////    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"sy2@2x"] forBarMetrics:UIBarMetricsDefault];
////    navigation.navigationBar.barTintColor = RGBA(198, 226, 225,1);
//    navigation.navigationBar.barTintColor = [UIColor whiteColor];
//
//    [self addChildViewController:navigation];
//}
//
//#pragma createTabBar
//- (void)creatTabBar:(NSInteger)ControllersNum
//{
//    NSArray * normImage = @[@"home2@2x",@"sources2@2x",@"message2@2x",@"me2@2x"];
//    NSArray * selectImage = @[@"home1@2x",@"sources1@2x",@"message1@2x",@"me1@2x"];
//    NSArray * titleLabel = @[@"网络连接",@"资源列表",@"消息中心",@"个人中心"];
////    UIImageView *tabbar = [[UIImageView alloc]initWithFrame:self.tabBar.frame];
//    UIImageView *tabbar = [[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight - L2C_TabbarHeight, kWidth, L2C_TabbarHeight)];
//
//    tabbar.backgroundColor =  [UIColor whiteColor];
//    tabbar.userInteractionEnabled = YES;
//    for(int i = 0;i<self.viewControllers.count;i++)
//    {
//        VPNTabBarBtn *btn = [VPNTabBarBtn buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(EACH_W(self.viewControllers.count)*i, 0, EACH_W(self.viewControllers.count), EACH_H);
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [btn setTitle:titleLabel[i] forState:UIControlStateNormal];
//        [btn setTitleColor:TEXTColor forState:UIControlStateSelected];
//        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        btn.titleLabel.font = [UIFont systemFontOfSize:10];
//        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
//        btn.tag = BTNTAG+i;
//        if (i == 1) {
//            notificationBtn = btn;
//        }
//        [tabbar addSubview:btn];
//        if(btn.tag==BTNTAG)
//        {
//            [self btnSelect:btn];
//        }
//        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    [self.view addSubview:tabbar];
//}
//
//
//- (void)btnSelect:(UIButton *)sender
//{
//    _button.selected =NO ;
//    sender.selected = YES;
//    _button = sender;
//    self.selectedIndex = sender.tag-BTNTAG;
//}
//
//-(void)btnWithNotification:(NSNotification *)notification{
//    _button.selected = NO;
//    notificationBtn.selected = YES;
//    _button = notificationBtn;
//    self.selectedIndex = notificationBtn.tag-BTNTAG;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBar];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnWithNotification:) name:@"mobileconfigFileSave" object:nil];

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
