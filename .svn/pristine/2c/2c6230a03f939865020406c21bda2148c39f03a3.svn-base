//
//  VPNLabelAndTextFieldView.m
//  loginIn
//
//  Created by jumpapp1 on 16/2/27.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNLabelAndTextFieldView.h"
#import "UIView+Category.h"
@implementation VPNLabelAndTextFieldView
//单例
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setInterface];
        self.clipsToBounds      = YES;
        self.backgroundColor    = [UIColor clearColor];
    }
    return self;
}

//初始化UILabel、UITextfield
-(void)setInterface{
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
    _nameLabel.textColor        = TITLEColor;
    _nameLabel.font             = [UIFont systemFontOfSize:15];
    _nameLabel.backgroundColor  = [UIColor clearColor];
    _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:_nameLabel];
    
    
    _valueField = [[UITextField alloc]initWithFrame:CGRectMake(_nameLabel.xjright, 0, self.xjwidth - _nameLabel.xjwidth, self.xjheight)];
    _valueField.backgroundColor  = [UIColor clearColor];
    _valueField.delegate         = self;
    _valueField.font             = [UIFont systemFontOfSize:15];
    _valueField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _valueField.returnKeyType    = UIReturnKeyNext;
    
    [self addSubview:_valueField];
}
//线
-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, RGB(213, 214, 214).CGColor);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}

#pragma mark UITextFieldDelegate
//UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.textColor == [UIColor redColor]) {
        textField.text = @"";
    }
    textField.textColor = [UIColor blackColor];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.nextTapped) {
        self.nextTapped();
    }
    return YES;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
