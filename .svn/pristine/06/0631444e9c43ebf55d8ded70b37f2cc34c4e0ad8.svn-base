//
//  UIView+Category.m
//  loginIn
//
//  Created by jumpapp1 on 16/2/27.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "UIView+Category.h"

//尺寸左边封装
@implementation UIView (frame)
- (CGFloat)xjleft
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)xjleft
{
    CGRect frame = self.frame;
    frame.origin.x = xjleft;
    self.frame = frame;
}

- (CGFloat)xjtop
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)xjtop
{
    CGRect frame = self.frame;
    frame.origin.y = xjtop;
    self.frame = frame;
}

- (CGFloat)xjright
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)xjright
{
    CGRect frame = self.frame;
    frame.origin.x = xjright - frame.size.width;
    self.frame = frame;
}

- (CGFloat)xjbottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)xjbottom
{
    CGRect frame = self.frame;
    frame.origin.y = xjbottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)xjcenterX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)xjcenterX
{
    self.center = CGPointMake(xjcenterX, self.center.y);
}

- (CGFloat)xjcenterY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)xjcenterY
{
    self.center = CGPointMake(self.center.x, xjcenterY);
}

- (CGFloat)xjwidth
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)xjwidth
{
    CGRect frame = self.frame;
    frame.size.width = xjwidth;
    self.frame = frame;
}

- (CGFloat)xjheight
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)xjheight
{
    CGRect frame = self.frame;
    frame.size.height = xjheight;
    self.frame = frame;
}

- (CGPoint)xjorigin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)xjorigin
{
    CGRect frame = self.frame;
    frame.origin = xjorigin;
    self.frame = frame;
}

- (CGSize)xjsize
{
    return self.frame.size;
}

- (void)setSize:(CGSize)xjsize
{
    CGRect frame = self.frame;
    frame.size = xjsize;
    self.frame = frame;
}


@end
