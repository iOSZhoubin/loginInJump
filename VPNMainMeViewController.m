//
//  VPNMainMeViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/4.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//  个人设置页面，包括：个人信息、功能介绍、意见反馈、关于我们、注销登录

#import "VPNMainMeViewController.h"
#import "ViewController.h"
#import "VPNPersonlViewController.h"
#import "VPNFeatureViewController.h"
#import "VPNAbusViewController.h"
#import "AFNetworking.h"
#import <MessageUI/MessageUI.h>

@interface VPNMainMeViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *pictureArray;
@property(nonatomic)UITableView *tableView;
@property (nonatomic)UIAlertView *alertView;
@property (nonatomic) UIView *view1;
@property (nonatomic) UIScrollView *scrollView;

@end

@implementation VPNMainMeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = BACKGROUNDColor;
    [self initDataArray];
    [self createSetting];
    [UIView setAnimationsEnabled:YES];
}

- (void)initDataArray{
    self.titleArray = @[@"个人信息",@" 功能介绍",@"意见反馈",@"关于我们"];
    self.pictureArray = @[@"personl1",@"system1",@"feedback1",@"abus1"];
}

- (void)createSetting{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [_scrollView addSubview:_view1];
    _scrollView.showsVerticalScrollIndicator = NO;
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"wd5(版权）logo_02-2@.png"];
    [imageView setImage:image];
    [_view1 addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1).with.offset(0);
        make.right.equalTo(self.view1).with.offset(0);
        make.top.equalTo(self.view1).with.offset(0);
        make.height.equalTo(@200);
    }];
    
    self.tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [_view1 addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1).with.offset(0);
        make.right.equalTo(self.view1).with.offset(0);
        make.top.equalTo(imageView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.view1).with.offset(-44);
    }];
}

#pragma mark - <UITableViewDelegate,UITableViewSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        return 18;
    }
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(section == 0){
       
        return self.titleArray.count;

    }
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];

    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];

    if(indexPath.section == 1){
        
        cell.textLabel.text = @"注销登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = RGB(252, 74, 74);
        cell.textLabel.font = [UIFont systemFontOfSize:18];

    }else{
       
        cell.imageView.image = [UIImage imageNamed:[self.pictureArray objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
        
        if (indexPath.row==0) {//跳转到个人信息页面
            VPNPersonlViewController *personViewController = [[VPNPersonlViewController alloc] init];
            personViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personViewController animated:YES];
            
        }else if (indexPath.row==1) {//跳转到功能介绍页面
            
            VPNFeatureViewController *featureViewController = [[VPNFeatureViewController alloc] init];
            featureViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:featureViewController animated:YES];
            
        }else if (indexPath.row==2) {
            //调用系统的邮件功能，手机要绑定，提前配置好
            [self sendMailInApp];
            //[self sendMailInApp1];
            
        }else if (indexPath.row==3) {//跳转到关于我们页面
            VPNAbusViewController *abusViewController = [[VPNAbusViewController alloc] init];
            abusViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:abusViewController animated:YES];
            
        }
        
    }else{
     
        [self quiteAccount];

    }
}

- (void)quiteAccount{
    self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定注销？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [self.alertView show];
}

//当点击警告框中的确定按钮，调用alertView的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults]objectForKey:USER_USERNAME_PASS_SERVER];
        NSString *serverStr = [dataDict objectForKey:@"server"];
//        NSString *logOutUrl = [NSString stringWithFormat:@"https://%@/jumpvpn/logoff.php",serverStr];

 
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *logOutUrl = [NSString stringWithFormat:@"https://%@/jumpvpn/logoff.php",serverStr];
        //向服务器端发送post请求，在注销登录成功后，跳转到登录页面
        [manager POST:logOutUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"注销登录成功");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginOut" object:nil];
          
            ViewController *vc = [[ViewController alloc]init];
            
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            appdelegate.window.rootViewController = vc;
            

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          }];
       
        
    }
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 50;
}

//会导致程序暂时退出
- (void)sendMailInApp{
    NSURL *url = [NSURL URLWithString:@"mailto:support@jump.net.cn"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSLog(@"不能发送邮件");
    }
}

//iOS系统会替我们提供一个mail的UI，无法进行定制
- (void)sendMailInApp1{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setToRecipients:@[@"support@jump.net.cn"]];//发送给谁
        [controller setSubject:@"标题"];//设置标题
        [controller setMessageBody:@"内容内容" isHTML:YES];//设置内容
        controller.mailComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"不能发送邮件");
    }
}

@end
