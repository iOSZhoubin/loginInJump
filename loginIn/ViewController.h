//
//  ViewController.h
//  loginIn
//
//  Created by jumpapp1 on 16/2/27.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSDictionary *params;
@property(nonatomic,strong)NSString *responseStr;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)NSDictionary *dataDict;
@property(nonatomic,strong)NSString *url;
@property(nonatomic)NSString *messageStr;
@property(nonatomic)NSString *pridStr;
@property(nonatomic)NSMutableArray *msgArr;
@end

