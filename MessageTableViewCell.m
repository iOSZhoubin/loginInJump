//
//  MessageTableViewCell.m
//  loginIn
//
//  Created by jumpapp1 on 2018/12/21.
//  Copyright © 2018年 jumpapp1. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshWithModel:(MessageModel *)model{
    
    
    self.titleName.text = SafeString(model.title);
    self.timeL.text = SafeString(model.issue);
    self.content.text = SafeString(model.content);

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
