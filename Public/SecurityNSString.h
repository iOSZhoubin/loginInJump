//
//  SecurityNSString.h
//  L2CSmartMotor
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018 feaonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityNSString : NSObject

/**
 若字符串为 nil 则返回 @""
 避免 字符串 为空
 */
+ (NSString *)safeStr:(NSString *)string;

@end
