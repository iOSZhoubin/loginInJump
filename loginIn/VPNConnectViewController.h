//
//  VPNConnectViewController.h
//  loginIn
//
//  Created by jumpapp1 on 16/2/29.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VPNConnectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITextField *mobileconfigField;
    UITextField *serField;
    UITextField *userField;
    UITextField *passField;
    UITextField *key;
}
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)UIScrollView *imageScrollView;
@property(nonatomic,strong)UIImageView *imageViewCourse;

@property(nonatomic,strong)UIView *mobileconfigView;
@property(nonatomic,strong)UITableView *mobTableVew;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIView *cellView;
@property(nonatomic,strong)UIButton *getMobileconfigBtn;
@property(nonatomic,strong)UIButton *ipsecConnectBtn;

@property(nonatomic,strong)UIView *subView;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)NSDictionary *dataDict;

@end
