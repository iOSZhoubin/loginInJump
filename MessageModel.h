//
//  MessageModel.h
//  loginIn
//
//  Created by 马朝阳 on 16/4/18.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) UIImage *icon;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *issue;


@end
