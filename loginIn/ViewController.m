//
//  ViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/2/27.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "ViewController.h"
#import "VPNLabelAndTextFieldView.h"
#import "UIView+Category.h"
#import "RootTabBarController.h"
#import "VPNCheckoutTextField.h"
#import "VPNStatus.h"
#import "AppDelegate.h"
//#import "AFHTTPSessionManager.h"

#import "FileManager.h"
//#import "AFNetworkReachabilityManager.h"

#import "Reachability.h"

@interface ViewController ()<NSXMLParserDelegate>
{
@private Reachability *hostReach;
}
@property (nonatomic, strong) VPNLabelAndTextFieldView *nameView;
@property (nonatomic, strong) VPNLabelAndTextFieldView *passView;
@property (nonatomic, strong) VPNLabelAndTextFieldView *serverView;
@property (nonatomic, strong) VPNLabelAndTextFieldView *portView;

@property (nonatomic, strong) NSTimer *connectTimer;
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) NSDictionary *mobileconfigFileDict;
@property (nonatomic) NSMutableArray *array;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIView *view1;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChanged) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityForInternetConnection];
    [hostReach startNotifier];
    
    
    _mobileconfigFileDict = [[NSUserDefaults standardUserDefaults]objectForKey:USER_USERMOBILECONFIGFILE];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStop) name:@"loginOut" object:nil];
    
    
    _dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME_PASS_SERVER];
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollerView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = [UIImage imageNamed:@"background"];
    [_scrollerView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self setLoginView];
    

    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)networkStateChanged{
    [self changeNetwork];
}

-(void)changeNetwork{
    Reachability *networkSttus = [Reachability reachabilityForInternetConnection];
    NSInteger status = [networkSttus currentReachabilityStatus];
    if (status != 0) {
        [_connectTimer invalidate];
    }
}

//移除Cookies
-(void)removeCookies{
    NSHTTPCookieStorage *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *removeCookies = [NSArray arrayWithArray:[cookies cookies]];
    for (NSHTTPCookie *cookie in removeCookies){
        if ([[cookie name] isEqualToString:@"alreadyLogin"]) {
            [cookies deleteCookie:cookie];
        }else if ([[cookie name] isEqualToString:@"clientip"]){
            [cookies deleteCookie:cookie];
        }else if ([[cookie name] isEqualToString:@"password"]){
            [cookies deleteCookie:cookie];
        }else if ([[cookie name] isEqualToString:@"username"]){
            [cookies deleteCookie:cookie];
        }else if ([[cookie name] isEqualToString:@"clientip"]){
            [cookies deleteCookie:cookie];
        }
        
    }
    //    NSArray *cookiesL = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/mobile_login.php?login",_serverView.valueField.text]]];
    //    NSDictionary *cookieDict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookiesL];
    //    NSLog(@"%@",cookieDict[@"Cookie"]);
}

//绘制登录界面
-(void)setLoginView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - ScreenWidth/ 375 * 250)/2, ScreenHeight*0.3+20, ScreenWidth/ 375 * 250, 240)];
    backView.clipsToBounds = YES;
    [_scrollerView addSubview:backView];
    
    _nameView = [[VPNLabelAndTextFieldView alloc]initWithFrame:CGRectMake(-1, 0, backView.frame.size.width + 2, 40)];
    _nameView.nameLabel.text = @"用户名:";
    _nameView.nameLabel.textColor = [UIColor whiteColor];
    //    _nameView.valueField.backgroundColor = [UIColor whiteColor];
    //    _nameView.valueField.layer.cornerRadius = 10;
    _nameView.valueField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nameView.valueField.delegate = self;
    _nameView.valueField.placeholder = @"请输入用户名";
    [_nameView.valueField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    __block typeof(_passView) blockPassV = _passView;
    _nameView.nextTapped = ^{
        [blockPassV.valueField becomeFirstResponder];
    };
    _nameView.valueField.text = _dataDict[@"userName"];
    //    _nameView.valueField.textColor = TEXTColor;
    [backView addSubview:_nameView];
    
    _passView = [[VPNLabelAndTextFieldView alloc]initWithFrame:CGRectMake(-1, 50, backView.frame.size.width + 2, 40)];
    _passView.nameLabel.text = @"密   码:";
    _passView.nameLabel.textColor = [UIColor whiteColor];
    _passView.valueField.secureTextEntry = YES;
    _passView.valueField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passView.valueField.placeholder = @"请输入密码";
    _passView.valueField.delegate = self;
    [_passView.valueField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passView.valueField.text = _dataDict[@"passWord"];
    //    _passView.valueField.textColor = TEXTColor;
    [backView addSubview:_passView];
    //    [self.view addSubview:backView];
    
    _serverView = [[VPNLabelAndTextFieldView alloc]initWithFrame:CGRectMake(-1, 100, backView.frame.size.width+2, 40)];
    _serverView.nameLabel.text = @"服务器";
    _serverView.nameLabel.textColor = [UIColor whiteColor];
    _serverView.valueField.placeholder = @"请输入服务器或域名";
    _serverView.valueField.delegate = self;
    [_serverView.valueField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _serverView.valueField.text = _dataDict[@"server"];
    _serverView.valueField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //    _serverView.valueField.textColor = TEXTColor;
    [backView addSubview:_serverView];
    
    _portView = [[VPNLabelAndTextFieldView alloc]initWithFrame:CGRectMake(-1, 150, backView.frame.size.width+2, 40)];
    _portView.nameLabel.text = @"端口";
    _portView.nameLabel.textColor = [UIColor whiteColor];
    _portView.valueField.placeholder = @"请输入端口号";
    _portView.valueField.delegate = self;
    [_portView.valueField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _portView.valueField.text = _dataDict[@"port"];
    _portView.valueField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [backView addSubview:_portView];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 200)/2, backView.frame.origin.y+backView.frame.size.height - 20, 200, 50)];
    //    loginBtn.centerX = self.view.centerX;
    //    loginBtn.top = backView.bottom + 43.5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius  = 10;
    //    _loginBtn.backgroundColor = RGB(81, 177, 248);
    _loginBtn.backgroundColor = [UIColor clearColor];
    [_loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _loginBtn.layer.borderWidth = 1;
    _loginBtn.layer.borderColor = RGB(213, 214, 214).CGColor;
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollerView addSubview:_loginBtn];
}

-(void)closeKeyboard{
    
    [self setContentOffsetAnimayion:0];
    [self.view endEditing:YES];
    _scrollerView.scrollEnabled = NO;
}

-(void)setContentOffsetAnimayion:(CGFloat)offsetY{
    [UIView animateWithDuration:0.25 animations:^{
        _scrollerView.contentOffset = CGPointMake(0, offsetY);
    }];
}

//登录点击事件
- (void)login:(UIButton *)sender
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setContentOffsetAnimayion:0];
        [self.view endEditing:YES];
    });
    //    [self removeCookies];
    [_loginBtn setEnabled:NO];
    
    if ([VPNCheckoutTextField checkTextFieldWithNumberOrGrapheme:_nameView.valueField.text]) {
        if ([VPNCheckoutTextField checkServerWithRule:_serverView.valueField.text] || [VPNCheckoutTextField checkTextFieldWithRealmName:_serverView.valueField.text]) {
            [self loginConnect];
        }else{
            [self createAlertView:nil:@"服务器错误"];
        }
    }else{
        [self createAlertView:nil:@"用户名或密码错误"];
    }
}

-(void)createAlertView:(NSString *)title :(NSString *)str{
   
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
    [_loginBtn setEnabled:YES];
}
//请求时蒙版、风火轮
- (void)activityIndicator1{
    self.view1 = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _view1.backgroundColor = [UIColor blackColor];
    _view1.alpha = 0.4;
    [self.view addSubview:_view1];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 0, 0);
    _activityIndicator.color = [UIColor whiteColor];
    [_activityIndicator setHidesWhenStopped:YES];
    [_activityIndicator startAnimating];
    [_view1 addSubview:_activityIndicator];
}

//登录请求
-(void)loginConnect{
    [self activityIndicator1];
//    RootTabBarController *rootTabBarController = [[RootTabBarController alloc]init];
//    self.view.window.rootViewController = rootTabBarController;
    
    if(_portView.valueField.text.length > 0){
    
        _url = [NSString stringWithFormat:@"https://%@:%@/mobile_login.php?login",_serverView.valueField.text,_portView.valueField.text];

    }else{

        _url = [NSString stringWithFormat:@"https://%@/mobile_login.php?login",_serverView.valueField.text];

    }

    _params = @{
                @"inputname":_nameView.valueField.text,
                @"inputpsw":_passView.valueField.text,
                @"login":@"1",
                @"enevs":@"login"
                };
    
    [_loginBtn setEnabled:YES];
    

    [AFNHelper post:_url parameters:_params success:^(id responseObject) {
        
//        NSData *data = responseObject;
//        NSString *str = [data mj_JSONString];
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:_url]];
        NSDictionary *cookieDict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        
        if ([cookieDict[@"Cookie"] rangeOfString:@"alreadyLogin=1;"].location !=NSNotFound) {
            NSLog(@"登录成功");
            [_view1 removeFromSuperview];
            [self timerStart];
            [self saveUserinformation];
            RootTabBarController *rootTabBarController = [[RootTabBarController alloc]init];
            self.view.window.rootViewController = rootTabBarController;
            self.view = nil;
            if (!(_mobileconfigFileDict.count == 0)) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"mobileconfigFileSave" object:nil userInfo:nil];
            }
            
        }else{
            NSLog(@"登录失败");
            [_view1 removeFromSuperview];
            [_loginBtn setEnabled:YES];
            [self createAlertView:@"登录失败" :@"用户名或密码错误"];
        }
        
    } faliure:^(id error) {
        
        [_view1 removeFromSuperview];
        [self createAlertView:nil:@"连接超时"];
        [_loginBtn setEnabled:YES];
    }];
}

- (NSString *)messageStr{
    if (_messageStr == nil) {
        _messageStr = [[NSString alloc] init];
    }
    return _messageStr;
}

- (NSString *)pridStr{
    if (_pridStr == nil) {
        _pridStr = [[NSString alloc] init];
    }
    return _pridStr;
}

- (NSMutableArray *)msgArr{
    if (_msgArr == nil) {
        _msgArr = [[NSMutableArray alloc] init];
    }
    return _msgArr;
}

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

-(void)timerStart{
//    _connectTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(longConnect) userInfo:nil repeats:YES];
//    [_connectTimer fire];
}

-(void)timerStop{
//    [_connectTimer invalidate];
//    _connectTimer = nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

//心跳连接
//-(void)longConnect{
//
//    NSString * str = [NSString stringWithFormat:@"https://%@/jumpvpn/pda_conn_hold.php?android_client=ture",_serverView.valueField.text];
//
//    AFHTTPRequestOperationManager *getManger = [AFHTTPRequestOperationManager manager];
//    getManger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    getManger.securityPolicy = policy;
//    [getManger GET:str parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"33");
//        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:_url]];
//        NSDictionary *cookieDict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//        //        NSLog(@"#####%@",cookieDict[@"Cookie"]);
//        //        NSLog(@"%@",operation.response);
//        if ([responseObject[@"hold_state"] intValue] == 1) {
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dict = (NSDictionary *)responseObject;
//                NSArray *arr = [dict objectForKey:@"notice"];
//                if (arr.count != 0) {
//                    for (NSInteger i = 0; i < arr.count; i++) {
//                        NSDictionary *dict = [arr objectAtIndex:i];
//                        self.messageStr = [dict objectForKey:@"msg"];
//                        self.pridStr = [dict objectForKey:@"prid"];
//                        [self.msgArr addObject:_messageStr];
//                        //                        NSLog(@"%@",self.msgArr);
//                        [VPNStatus shareInstance].contextStr = _messageStr;
//                        [VPNStatus shareInstance].contextStr1 = _pridStr;
//                        _messageStr = nil;
//                    }
//                }
//                if (_msgArr != nil) {
//                    self.array = [NSMutableArray arrayWithArray:_msgArr];
//                    //NSLog(@"%@",_array);
//                }
//                [VPNStatus shareInstance].contextArr = _array;
//                //NSLog(@"%@",_array);
//            }
//        }else{
//            NSLog(@"22222");
//            [self timerStop];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"dianji" object:@"0"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"-----------------------");
//        //        NSLog(@"++++%@",error);
//        if ([self getNetworkStatus] == 0) {
//            //NSLog(@"NetWork error");
//            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"连接超时" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertview show];
//            [self timerStop];
//        }else{
//            [_connectTimer invalidate];
//            [self loginConnect];
//        }
//    }];
//}

-(NSInteger)getNetworkStatus{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    return type;
}

//记住账号密码
-(void)saveUserinformation{
    
    if(_portView.valueField.text.length < 1){
        
        _portView.valueField.text = @"";
    }
    
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_nameView.valueField.text,@"userName",_passView.valueField.text,@"port",_portView.valueField.text,@"passWord",_serverView.valueField.text,@"server", nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:USER_USERNAME_PASS_SERVER];
    [defaults synchronize];

}

#pragma mark UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:@"loginOut"];
}







@end

