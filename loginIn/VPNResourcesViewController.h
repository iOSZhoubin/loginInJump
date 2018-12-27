//
//  VPNResourcesViewController.h
//  loginIn
//
//  Created by jumpapp1 on 16/3/4.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPNIpSourceViewController.h"
#import "VPNWebSourceViewController.h"
#import "VPNOtherSourceViewController.h"

@interface VPNResourcesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@end
