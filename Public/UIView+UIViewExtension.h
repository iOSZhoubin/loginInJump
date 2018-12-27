//
//  UIView+UIViewExtension.h
//  L2Cplat
//
//  Created by zhukaiqi on 16/8/16.
//  Copyright © 2016年 feaonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExtension)

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat maxX;
@property (nonatomic,assign) CGFloat maxY;

/**
 *  加载xib视图
 *
 *  @return view
 */
+ (instancetype )loadViewFromXib;

- (UIViewController *)parentController;
@end
