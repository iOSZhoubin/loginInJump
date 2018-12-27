//
//  VPNWebSourceViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/10.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNWebSourceViewController.h"
#import "VPNStatus.h"

@interface VPNWebSourceViewController()<UIWebViewDelegate>


@end

@implementation VPNWebSourceViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Web资源";
    self.view.backgroundColor = BACKGROUNDColor;
    _dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME_PASS_SERVER];
    [self getWebSourceDate];
    
}
//获取WebSource
-(void)getWebSourceDate{
    
    NSString *server = [NSString stringWithFormat:@"https://%@/jumpvpn/pda_resource_list.php",_dataDict[@"server"]];
    
    [SVPShow show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:server parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
        NSString *str1 = [data mj_JSONString];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        _WebSource = str;
        [self createWebSourceView];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [SVPShow disMiss];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"Web资源加载错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }];
}

//WebView
-(void)createWebSourceView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    webView.delegate = self;

    [webView loadHTMLString:_WebSource baseURL:[NSURL URLWithString:[NSString  stringWithFormat:@"https://%@",_dataDict[@"server"]]]];

    [self.view addSubview:webView];

}


/* 页面加载完成 */

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVPShow disMiss];

}



@end
