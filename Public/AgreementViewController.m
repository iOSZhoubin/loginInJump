//
//  AgreementViewController.m
//  L2CSmartMotor
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 feaonline. All rights reserved.
//

#import "AgreementViewController.h"
#import "myWkWebView.h"

@interface AgreementViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (strong,nonatomic) WKWebView *webView;

@property (nonatomic,strong) UIView *progressLine;

@property (copy,nonatomic) NSString *htmlStr;

@property (copy,nonatomic) NSString *ipAddress;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";

    self.view.backgroundColor = BACKGROUNDColor;
//    NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME_PASS_SERVER];
//    self.ipAddress = dataDict[@"server"];
//
//    [self getWebSourceDate];
    
}

-(void)creatWebView{

    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    self.webView = [[WKWebView alloc]init];
    
    self.webView.frame = CGRectMake(0, 0, kWidth, kHeight-L2C_StatusBarAndNavigationBarHeight);
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];
    
//    [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL URLWithString:[NSString  stringWithFormat:@"https://%@",self.ipAddress]]];

    
    NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];

    [self.webView loadRequest:requ];
    

    
    //加载进度
    self.progressLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    
    self.progressLine.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.progressLine];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.progressLine.width = kWidth-20;
    }];
    
}



/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.progressLine.width = kWidth;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [self.progressLine removeFromSuperview];
        }
    }];
}
//
////获取WebSource
//-(void)getWebSourceDate{
//
//    NSString *server = [NSString stringWithFormat:@"https://%@/jumpvpn/pda_resource_list.php",self.ipAddress];
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager GET:server parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *data = responseObject;
//        NSString *str1 = [data mj_JSONString];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        self.htmlStr = str;
//
//        [self creatWebView];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"Web资源加载错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//    }];
//}

@end
