//
//  SVPShow.h
//  L2CSmartMotor
//
//  Created by feaonline on 2018/9/25.
//  Copyright © 2018年 feaonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVPShow : NSObject

+ (void)show;

+ (void)disMiss;

+ (void)showSuccessWithMessage:(NSString *)messgae;

+ (void)showFailureWithMessage:(NSString *)message;

+ (void)showInfoWithMessage:(NSString *)message;

@end

