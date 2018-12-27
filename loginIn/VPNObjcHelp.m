//
//  VPNObjcHelp.m
//  loginIn
//
//  Created by jumpapp1 on 16/2/29.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNObjcHelp.h"
#import <sys/sysctl.h>

NSString *const JZ_DEVICE_IPHONE       = @"IPONE";
NSString *const JZ_DEVICE_IPHONE_3G    = @"IPONE 3G";
NSString *const JZ_DEVICE_IPHONE_3GS   = @"IPONE 3GS";
NSString *const JZ_DEVICE_IPHONE_4     = @"IPONE 4";
NSString *const JZ_DEVICE_IPHONE_4S    = @"IPONE 4S";
NSString *const JZ_DEVICE_IPHONE_5     = @"IPONE 5";
NSString *const JZ_DEVICE_IPHONE_5C    = @"IPONE 5C";
NSString *const JZ_DEVICE_IPHONE_5S    = @"IPONE 5S";
NSString *const JZ_DEVICE_IPHONE_6     = @"IPONE 6";
NSString *const JZ_DEVICE_IPHONE_6PLUS = @"IPONE 6PLUS";
NSString *const JZ_DEVICE_IPOD_TOUCH_4 = @"IPOD TOUCH 4";
NSString *const JZ_DEVICE_IPOD_TOUCH_5 = @"IPOD TOUCH 5";
NSString *const JZ_DEVICE_IPOD_TOUCH_3 = @"IPOD TOUCH 3";
NSString *const JZ_DEVICE_IPOD_TOUCH_2 = @"IPOD TOUCH 2";
NSString *const JZ_DEVICE_IPOD_TOUCH   = @"IPOD TOUCH";
NSString *const JZ_DEVICE_IPAD_3       = @"IPAD 3";
NSString *const JZ_DEVICE_IPAD_2       = @"IPAD 2";
NSString *const JZ_DEVICE_IPAD_1       = @"IPAD 1";
NSString *const JZ_DEVICE_IPAD_MINI    = @"IPAD MINI";
NSString *const JZ_DEVICE_IPAD_AIR     = @"IPAD AIR";

NSString *const JZ_DEVICE_IOS_MODEL_IPAD       = @"JZ_DEVICE_IOS_MODEL_IPAD";
NSString *const JZ_DEVICE_IOS_MODEL_IPHONE     = @"JZ_DEVICE_IOS_MODEL_IPHONE";
NSString *const JZ_DEVICE_IOS_MODEL_IPOD_TOUCH = @"JZ_DEVICE_IOS_MODEL_IPOD_TOUCH";

@implementation VPNObjcHelp

NSString *currentDeviceModl() {
    
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        platform = JZ_DEVICE_IPHONE;
    }
    else if ([platform isEqualToString:@"iPhone1,2"]) {
        platform = JZ_DEVICE_IPHONE_3G;
    }
    else if ([platform isEqualToString:@"iPhone2,1"]) {
        platform = JZ_DEVICE_IPHONE_3GS;
    }
    else if ([platform isEqualToString:@"iPhone3,1"]
             || [platform isEqualToString:@"iPhone3,2"]
             || [platform isEqualToString:@"iPhone3,3"]) {
        platform = JZ_DEVICE_IPHONE_4;
    }
    else if ([platform isEqualToString:@"iPhone4,1"]) {
        platform = JZ_DEVICE_IPHONE_4S;
    }
    else if ([platform isEqualToString:@"iPhone5,1"]
             || [platform isEqualToString:@"iPhone5,2"]) {
        platform = JZ_DEVICE_IPHONE_5;
    }
    else if ([platform isEqualToString:@"iPhone5,3"]
             || [platform isEqualToString:@"iPhone5,4"]) {
        platform = JZ_DEVICE_IPHONE_5C;
    }
    else if ([platform isEqualToString:@"iPhone6,2"]
             || [platform isEqualToString:@"iPhone6,1"]) {
        platform = JZ_DEVICE_IPHONE_5S;
    }
    else if ([platform isEqualToString:@"iPhone7,2"]) {
        platform = JZ_DEVICE_IPHONE_6;
    }
    else if ([platform isEqualToString:@"iPhone7,1"]) {
        platform = JZ_DEVICE_IPHONE_6PLUS;
    }
    else if ([platform isEqualToString:@"iPod4,1"]) {
        platform = JZ_DEVICE_IPOD_TOUCH_4;
    }
    else if ([platform isEqualToString:@"iPod5,1"]) {
        platform = JZ_DEVICE_IPOD_TOUCH_5;
    }
    else if ([platform isEqualToString:@"iPod3,1"]) {
        platform = JZ_DEVICE_IPOD_TOUCH_3;
    }
    else if ([platform isEqualToString:@"iPod2,1"]) {
        platform = JZ_DEVICE_IPOD_TOUCH_2;
    }
    else if ([platform isEqualToString:@"iPod1,1"]) {
        platform = JZ_DEVICE_IPOD_TOUCH;
    }
    else if ([platform isEqualToString:@"iPad3,2"]
             || [platform isEqualToString:@"iPad3,1"]) {
        platform = JZ_DEVICE_IPAD_3;
    }
    else if ([platform isEqualToString:@"iPad2,2"]
             ||[platform isEqualToString:@"iPad2,1"]
             ||[platform isEqualToString:@"iPad2,3"]
             ||[platform isEqualToString:@"iPad2,4"]) {
        platform = JZ_DEVICE_IPAD_2;
    }
    else if ([platform isEqualToString:@"iPad1,1"]) {
        platform = JZ_DEVICE_IPAD_1;
    }
    else if ([platform isEqualToString:@"iPad5,3"]) {
        platform = JZ_DEVICE_IPAD_AIR;
    }
    else if ([platform isEqualToString:@"iPad2,5"]
             ||[platform isEqualToString:@"iPad2,6"]
             ||[platform isEqualToString:@"iPad2,7"]) {
        platform = JZ_DEVICE_IPAD_MINI;
    }
    else if ([platform isEqualToString:@"iPad3,3"]
             ||[platform isEqualToString:@"iPad3,4"]
             ||[platform isEqualToString:@"iPad3,5"]
             ||[platform isEqualToString:@"iPad3,6"]) {
        platform = JZ_DEVICE_IPAD_3;
    }
    return platform;
}

NSString * currentDeviceIOSModel() {
    
    if ([currentDeviceModl() rangeOfString:@"IPAD"].location != NSNotFound) {
        return JZ_DEVICE_IOS_MODEL_IPAD;
    }
    if ([currentDeviceModl() rangeOfString:@"IPHONE"].location != NSNotFound) {
        return JZ_DEVICE_IOS_MODEL_IPHONE;
    }
    if ([currentDeviceModl() rangeOfString:@"IPOD TOUCH"].location != NSNotFound) {
        return JZ_DEVICE_IOS_MODEL_IPOD_TOUCH;
    }
    return @"JZIOSModelNotFound";
}

NSString * NSStringFromFloat(float floatV) {
    NSString *string = [NSString stringWithFormat:@"%f", floatV];
    return string;
}

NSString * NSStringFromInt(int intV) {
    NSString *string = [NSString stringWithFormat:@"%d", intV];
    return string;
}
@end
