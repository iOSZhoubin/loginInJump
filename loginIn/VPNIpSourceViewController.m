//
//  VPNIpSourceViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/10.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNIpSourceViewController.h"
#import "IPSourceTableViewCell.h"

@interface VPNIpSourceViewController()

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation VPNIpSourceViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.title =@"IP资源";
    self.view.backgroundColor = BACKGROUNDColor;

    [self.tableView registerNib:[UINib nibWithNibName:@"IPSourceTableViewCell" bundle:nil] forCellReuseIdentifier:@"IPSourceTableViewCell"];

    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self getIPSourceData];
    
}

//获取IPSuorces
-(void)getIPSourceData{
    
    [SVPShow show];
    
    _dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME_PASS_SERVER];

    
    NSString *url = [NSString stringWithFormat:@"https://%@/service/?service=loadIpSource",SafeString(_dataDict[@"server"])];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSData *data = responseObject;
        NSString *str = [data mj_JSONString];
        NSArray *array = [str mj_JSONObject];
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [SVPShow showSuccessWithMessage:@"数据加载成功"];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"IP资源获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        [SVPShow disMiss];

    }];
    
}


#define mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    IPSourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IPSourceTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    [cell refreshWithDict:dict];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSString *resourcetype = SafeString(self.dataArray[indexPath.row][@"ip_type"]);

    if([resourcetype isEqualToString:@"http"] || [resourcetype isEqualToString:@"https"]){
    
        NSString *ip = SafeString(self.dataArray[indexPath.row][@"ip"]);
        NSString *port = SafeString(self.dataArray[indexPath.row][@"port"]);
        
        NSString *url = [NSString stringWithFormat:@"%@://%@:%@",resourcetype,ip,port];
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    }
   
}

@end
