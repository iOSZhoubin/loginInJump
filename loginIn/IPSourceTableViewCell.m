//
//  IPSourceTableViewCell.m
//  loginIn
//
//  Created by jumpapp1 on 2018/12/21.
//  Copyright © 2018年 jumpapp1. All rights reserved.
//

#import "IPSourceTableViewCell.h"

@interface IPSourceTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *portL;
@property (weak, nonatomic) IBOutlet UIImageView *pushArrow;

@end

@implementation IPSourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)refreshWithDict:(NSDictionary *)dict{
    
    self.nameL.text = [NSString stringWithFormat:@"资源名称:%@",SafeString(dict[@"resource_name"])];
    self.addressL.text = [NSString stringWithFormat:@"资源地址:%@",SafeString(dict[@"ip"])];
    self.portL.text = [NSString stringWithFormat:@"访问端口:%@",SafeString(dict[@"port"])];
    
    NSString *type = SafeString(dict[@"ip_type"]);
    
    if([type isEqualToString:@"http"] || [type isEqualToString:@"https"]){
        
        self.pushArrow.hidden = NO;
        
    }else{
       
        self.pushArrow.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
