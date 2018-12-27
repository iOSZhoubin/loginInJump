//
//  VPNChangeViewController.m
//  loginIn
//
//  Created by 马朝阳 on 16/3/18.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNChangeViewController.h"
#import "GDataXMLNode.h"
#import "VPNPersonlViewController.h"
#import "VPNMainMeViewController.h"
#import "ViewController.h"
#import "VPNCheckoutTextField.h"
#import "AFHTTPSessionManager.h"


@interface VPNChangeViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)UITableView *tableView;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic)UITextField *formerTextField;//旧密码的TextField
@property (nonatomic)UITextField *nowTextField;//新密码的TextField
@property (nonatomic)UITextField *againTextField;//再次确认的TextField
@property (nonatomic)UIAlertView *alertView;
//@property (nonatomic)JSONModelArray *modelArray;
@property (nonatomic)NSString *serverStr;//服务器地址
@property (nonatomic)NSString *userStr;//用户名
@property (nonatomic)NSString *pwdStr;//密码
@property (nonatomic)NSInteger nu0;//判断密码中是否含有特殊字符“&”
@property (nonatomic)NSInteger nu;//判断密码中是否包含数字的返回值
@property (nonatomic)NSInteger nu2;//判断密码中是否包含字母的返回值
@property (nonatomic)NSInteger nu3;//判断密码中是否包含特殊字符的返回值
@property (nonatomic)NSInteger nu4;//解析sameasname时policy_enable的值
@property (nonatomic)NSInteger nu5;//解析sameasoldpwd时policy_enable的值
@property (nonatomic)NSInteger nu6;//解析minlength时policy_enable的值
@property (nonatomic)NSInteger nu8;//解析minlength时policy_value的值
@property (nonatomic)NSInteger nu7;//解析complex时policy_enable的值
@property (nonatomic)NSInteger nu9;//解析complex时policy_value的值

@end

@implementation VPNChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDColor;
    //获取沙盒中的服务器地址、用户名和密码
    NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults]objectForKey:USER_USERNAME_PASS_SERVER];
    self.serverStr = [dataDict objectForKey:@"server"];
    self.userStr = [dataDict objectForKey:@"userName"];
    self.pwdStr = [dataDict objectForKey:@"passWord"];
    [self changePassword];
    [self initDataSource];
    [UIView setAnimationsEnabled:YES];

    [self createButton];
}

//修改密码调用的方法，向服务端post三个参数change_pass、oldpass、newpass，当修改成功时会弹出警告框，点击确认之后，调用alertView的代理方法跳转到个人设置页面
- (void)createPwd{

    if ([self.formerTextField.text isEqualToString:self.nowTextField.text]){
        
        [SVPShow showInfoWithMessage:@"原密码与新密码相同"];
        
        return;
        
    }else if(![self.nowTextField.text isEqualToString:self.againTextField.text]){
        
        [SVPShow showInfoWithMessage:@"两次输入的密码不同"];
        
        return;
    }
    
    [SVPShow show];
    
        NSDictionary *paramer = @{@"change_pass":@1,@"oldpass":self.formerTextField.text,@"newpass":self.nowTextField.text};
        NSString *sUrl = [NSString stringWithFormat:@"https://%@/jumpvpn/user_setting.php",_serverStr];
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:sUrl parameters:paramer success:^(AFHTTPRequestOperation *operation, id   responseObject) {
           
            NSData *data = responseObject;
            NSString *str = [data mj_JSONString];
            
            if([str isEqualToString:@"1"]){
                
                [SVPShow showSuccessWithMessage:@"密码修改成功"];
                
                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_nowTextField.text,@"passWord",_serverStr,@"server",_userStr,@"userName",nil];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:dict forKey:USER_USERNAME_PASS_SERVER];
                
                [defaults synchronize];
                
                ViewController *vc = [[ViewController alloc]init];
                
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appdelegate.window.rootViewController = vc;

                
            }else{
                
                [SVPShow showFailureWithMessage:@"密码修改失败"];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            [SVPShow showFailureWithMessage:@"密码修改失败"];

        }];

}

- (void)initDataSource{
    self.titleArray = @[@"旧 密 码:",@"新 密 码:",@"再次确认:"];
}


- (void)changePassword{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    //self.tableView.separatorColor = BACKGROUNDColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@240);
    }];
}

- (void)createButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = BlueColor;
    button.layer.cornerRadius = 5;
    [button setTitle:@"确   定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //button.translatesAutoresizingMaskIntoConstraints = NO;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(self.view).with.offset(135+74+15+20);
        make.height.equalTo(@45);
    }];
}

//点击确定按钮后触发的事件
- (void)buttonPressed:(id)sender{

    [self createPwd];
}



#pragma mark -<UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = TITLEColor;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.frame = CGRectMake(20, 0, 75, cell.frame.size.height);
    }else{
        cell.textLabel.frame = CGRectMake(20, 0, 50, cell.frame.size.height);
    }
    cell.accessoryType = UITableViewCellStyleDefault;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *whiteView1 = [[UIView alloc] initWithFrame:CGRectMake(cell.textLabel.frame.origin.x+cell.textLabel.frame.size.width+20, 0, ScreenWidth-(cell.textLabel.frame.origin.x*5.6)-cell.textLabel.frame.size.width, cell.frame.size.height)];
    [cell addSubview:whiteView1];
    if (indexPath.section==0 && indexPath.row==0) {
        self.formerTextField = [[UITextField alloc] initWithFrame:whiteView1.bounds];
        _formerTextField.placeholder = @"请输入旧密码";
        _formerTextField.font = [UIFont systemFontOfSize:15];
        _formerTextField.secureTextEntry = YES;
        _formerTextField.delegate = self;

        [whiteView1 addSubview:_formerTextField];
    }
    if (indexPath.section==0 && indexPath.row==1){
        self.nowTextField = [[UITextField alloc] initWithFrame:whiteView1.bounds];
        _nowTextField.placeholder = @"请输入新密码";
        _nowTextField.font = [UIFont systemFontOfSize:15];
        _nowTextField.secureTextEntry = YES;
        _nowTextField.delegate = self;
        [whiteView1 addSubview:_nowTextField];
    }
    if (indexPath.section==0 && indexPath.row==2) {
        self.againTextField = [[UITextField alloc] initWithFrame:whiteView1.bounds];
        _againTextField.placeholder = @"再次确认";
        _againTextField.font = [UIFont systemFontOfSize:15];
        _againTextField.secureTextEntry = YES;
        _againTextField.delegate = self;
        [whiteView1 addSubview:_againTextField];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([[textField text] length] + string.length > 32) {
        return NO;
    }
    return YES;
}



@end
