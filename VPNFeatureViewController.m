//
//  VPNFeatureViewController.m
//  loginIn
//
//  Created by 马朝阳 on 16/3/18.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//  该页面为个人设置中的功能介绍页面的展示，包括：软件说明和FAQ

#import "VPNFeatureViewController.h"

@interface VPNFeatureViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation VPNFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"功能介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
}

#pragma mark - <UITableViewDelegate,UITableVeiwDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 2) {
        return 40;
    }
    if (indexPath.row == 1) {
        return 210;
    }
    return 640;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0 && indexPath.row==0) {
            cell.textLabel.text = @"软件说明";
            cell.userInteractionEnabled = NO;
            return cell;
        }else if (indexPath.section==0 && indexPath.row==2) {
            cell.textLabel.text = @"FAQ";
            cell.userInteractionEnabled = NO;
            return cell;
        }
        if (indexPath.section==0 && indexPath.row==1) {
            UITextView *textView1 = [[UITextView alloc] init];
            self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            _paragraphStyle.lineSpacing = 4;
            NSDictionary *attributes = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:14],
                                         NSParagraphStyleAttributeName:_paragraphStyle
                                         };
            textView1.attributedText = [[NSAttributedString alloc] initWithString:@"      该软件是为捷普SSLVPN产品量身定制的iOS版手机客户端，集VPN服务和相关应用程序于一体，最便捷为广大企业用户提供远程安全接入公司内部网络的专用通道，致力于满足新时代人们的移动办公需求。该客户端目前主要支持iOS操作系统版本为8.0以上的移动设备，主要包括IP资源访问、WEB资源访问等模块，配置简单，方便使用，用户只需要输入公司VPN服务器地址、用户名、密码，便能享受移动设备远程办公所带来的非凡体验。" attributes:attributes];
            textView1.backgroundColor = BACKGROUNDColor;
            textView1.textColor = TEXTColor;
            //cell.accessoryType = textView1;
            cell.userInteractionEnabled = NO;
            [cell addSubview:textView1];
            [textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).with.offset(10);
                make.right.equalTo(cell).with.offset(-10);
                make.height.equalTo(cell).with.offset(0);
            }];
            return cell;
        }
        if (indexPath.section==0 && indexPath.row==3) {
            UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 640)];
            self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            _paragraphStyle.lineSpacing = 4;
            NSDictionary *attributes = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:14],
                                         NSParagraphStyleAttributeName:_paragraphStyle
                                         };
            textView2.attributedText = [[NSAttributedString alloc] initWithString:@"Q1.在使用iOS客户端时，为什么消息记录会被自动清空？\nA1.iOS客户端提供的消息记录功能用于记录并显示管理员给在线用户发送的即时短消息，原则上该短消息为即时会话消息，在当前会话结束后下次会话开始前就会被自动清空，以防止用户的短消息内容被泄露。\nQ2.为什么用iOS客户端或直接用移动设备自带浏览器访问WEB浏览器过程中有时会出现提交表单后页面显示空白？\nA2.由于移动设备操作系统和传统PC操作系统上WEB浏览器内核不一致，导致部分网站在移动设备上访问时会出现页面显示不全或表单提交异常，出现该问题后只能期待这些网站能对移动设备浏览器作专门的优化。\nQ3.用iOS客户端来访问WEB资源过程中点击上一页面图标或设备的<返回>键来返回上一页时，为什么有时会出现WEB资源只能在当前页刷新而不能返回上一页？\nA3.出现此问题是由于有些WEB资源页面本身在内部对返回历史纪录时间作了拦截处理，导致用户点上一页面图标或<返回>键时只能在当前页刷新。针对此问题，用户可以点首页图标来返回WEB页面首页，然后继续浏览其它资源；也可以点清除缓存图标来清空浏览器缓存，然后按<返回>键来退出WEB资源。\nQ4.使用iOS客户端能访问资源的类型有哪些？\nA4.用户登录成功后，WEB资源就可以访问，目前支持http和https类型；用户VPN连接成功后，IP资源就可以访问，目前支持http和https类型。" attributes:attributes];
            textView2.backgroundColor = BACKGROUNDColor;
            textView2.textColor = TEXTColor;
            cell.userInteractionEnabled = NO;
            [cell addSubview:textView2];
            [textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).with.offset(10);
                make.right.equalTo(cell).with.offset(-10);
                make.height.equalTo(cell).with.offset(0);
            }];
            return cell;
        }
    }
    return cell;
}

@end
