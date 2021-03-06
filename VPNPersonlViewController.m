//
//  VPNPersonlViewController.m
//  loginIn
//
//  Created by 马朝阳 on 16/3/18.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNPersonlViewController.h"
#import "VPNChangeViewController.h"
#import "ViewController.h"

@interface VPNPersonlViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableView *tableView;
@property(nonatomic,copy)NSArray *titleArray;
@property(nonatomic,copy)NSString *serverStr;
@property(nonatomic,copy)NSString *userStr;
@property(nonatomic,copy)NSString *pwdStr;
@property(nonatomic,copy)NSArray *array;

@end

@implementation VPNPersonlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDColor;
    self.navigationItem.title = @"个人信息";
    [self createTableView];
    [self initDataSource];
    [self createButton];
    [UIView setAnimationsEnabled:YES];
}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    //[self.tableView hiddenExtraLine];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@240);
    }];
}

- (void)initDataSource{
    self.titleArray = @[@"服务器地址",@"用户名",@"密码"];
    //通过沙盒获取到服务器地址、用户名和密码
    NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults]objectForKey:USER_USERNAME_PASS_SERVER];
    
    _serverStr = SafeString(dataDict[@"server"]);
    _userStr = SafeString(dataDict[@"userName"]);
    
    self.array = @[_serverStr,_userStr,@"••••"];
}

- (void)createButton{
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeButton.backgroundColor = BlueColor;
    changeButton.layer.masksToBounds = YES;
    changeButton.layer.cornerRadius = 5;
    [changeButton setTitle:@"修改密码" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor colorWithRed:0.6f green:0.36f blue:0.01f alpha:1.0f] forState:UIControlStateSelected];
    changeButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [changeButton addTarget:self action:@selector(changeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(self.view).with.offset(135+74+15+20);
        make.height.equalTo(@45);
    }];
}

//点击修改密码按钮跳转到修改密码页面
- (void)changeButton:(UIButton *)button{
    VPNChangeViewController *changeViewController = [VPNChangeViewController new];
    [self.navigationController pushViewController:changeViewController animated:YES];
}

#pragma mark -<UITableViewDelegate,UITableViewSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}


@end
