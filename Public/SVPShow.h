//
//  SVPShow.h
//  L2CSmartMotor
//
//  Created by feaonline on 2018/9/25.
//  Copyright © 2018年 feaonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPShow : NSObject

//开始
+ (void)show;
//结束
+ (void)disMiss;
//成功展示
+ (void)showSuccessWithMessage:(NSString *)messgae;
//失败展示
+ (void)showFailureWithMessage:(NSString *)message;
//提示信息
+ (void)showInfoWithMessage:(NSString *)message;

@end

