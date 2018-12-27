//
//  VPNStatus.h
//  loginIn
//
//  Created by jumpapp1 on 16/3/10.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPNStatus : NSObject
{
    NSString *_contextStr;
    NSString *_contextStr1;
    NSMutableArray *_contextArr;
}
@property(nonatomic,retain)NSString *contextStr;
@property(nonatomic,retain)NSString *contextStr1;
@property(nonatomic,retain)NSMutableArray *contextArr;
+(VPNStatus *)shareInstance;

@end
