//
//  SecurityNSString.m
//  L2CSmartMotor
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018 feaonline. All rights reserved.
//

#import "SecurityNSString.h"

@implementation SecurityNSString


+ (NSString *)safeStr:(NSString *)string{
    
    if (!string) {
        return @"";
    }else{
        return string;
    }
    
}

@end
