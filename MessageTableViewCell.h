//
//  MessageTableViewCell.h
//  loginIn
//
//  Created by jumpapp1 on 2018/12/21.
//  Copyright © 2018年 jumpapp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell

-(void)refreshWithModel:(MessageModel *)model;

@end
