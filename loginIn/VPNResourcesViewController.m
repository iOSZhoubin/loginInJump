//
//  VPNResourcesViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/4.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNResourcesViewController.h"

//资源展示页面
@implementation VPNResourcesViewController

-(void)viewDidLoad{
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"资源列表";
    self.view.backgroundColor = BACKGROUNDColor;
    [self createTableView];
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
}

#pragma mark UITabelViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
           //IP资源
            VPNIpSourceViewController *ipSource = [[VPNIpSourceViewController alloc]init];
            ipSource.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ipSource animated:YES];
        }
            break;
        case 1:{
            VPNWebSourceViewController *webSource = [[VPNWebSourceViewController alloc]init];            
            webSource.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webSource animated:YES];
            //Web资源
        }
            break;
//        case 2:{
//            VPNOtherSourceViewController *otherSource = [[VPNOtherSourceViewController alloc]init];
//            otherSource.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:otherSource animated:YES];
//            NSLog(@"其他资源");
//        }
//            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:{
            cell.imageView.image = [UIImage imageNamed:@"sblb"];
            cell.textLabel.text = @"IP资源";
//            cell.detailTextLabel.text = @"尾部信息";
            CGSize itemSzie = CGSizeMake (30, 30);
            UIGraphicsBeginImageContextWithOptions(itemSzie, NO, 0);
            CGRect image = CGRectMake(0, 0, itemSzie.width, itemSzie.height);
            [cell.imageView.image drawInRect:image];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();        }
            break;
        case 1:{
            cell.imageView.image = [UIImage imageNamed:@"wdsc"];
            cell.textLabel.text = @"Web资源";
            CGSize itemSzie = CGSizeMake (30, 30);
            UIGraphicsBeginImageContextWithOptions(itemSzie, NO, 0);
            CGRect image = CGRectMake(0, 0, itemSzie.width, itemSzie.height);
            [cell.imageView.image drawInRect:image];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
            break;
//        case 2:{
//            cell.imageView.image = [UIImage imageNamed:@"yjfk"];
//            cell.textLabel.text = @"其他资源";
//            CGSize itemSzie = CGSizeMake (30, 30);
//            UIGraphicsBeginImageContextWithOptions(itemSzie, NO, 0);
//            CGRect image = CGRectMake(0, 0, itemSzie.width, itemSzie.height);
//            [cell.imageView.image drawInRect:image];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();        }
//            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
            
        default:
            break;
    }
    return cell;
}



@end
