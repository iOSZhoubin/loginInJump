//
//  VPNMessageViewController.m
//  loginIn
//
//  Created by jumpapp1 on 16/3/4.
//  Copyright © 2016年 jumpapp1. All rights reserved.
//

#import "VPNMessageViewController.h"
#import "ViewController.h"
#import "VPNStatus.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MessageTableViewCell.h"

@interface VPNMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIAlertView *alertView;
@property (nonatomic) NSMutableArray *dataArray;


@end

@implementation VPNMessageViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
    self.view.backgroundColor = BACKGROUNDColor;
    [self createTableView];

}


- (void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGB(247, 247, 247);
    _tableView.tableFooterView = [[UIView alloc] init];//去掉多余分割线

    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageTableViewCell"];
    
    
    [self.view addSubview:_tableView];


    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{

    NSDictionary *dataDict = [[NSUserDefaults standardUserDefaults] objectForKey:USER_USERNAME_PASS_SERVER];
    
    NSString *url = [NSString stringWithFormat:@"https://%@/service/?service=getMeassages",dataDict[@"server"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = responseObject;
        NSString *str = [data mj_JSONString];
        NSArray *array = [str mj_JSONObject];
        self.dataArray  = [MessageModel mj_objectArrayWithKeyValuesArray:array];

        if(self.dataArray.count > 0){
            
            [SVPShow showSuccessWithMessage:@"加载数据成功"];

        }else{
           
            [SVPShow showInfoWithMessage:@"暂未查询到数据"];
        }
        
        [self.tableView.mj_header endRefreshing];

        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];

        [SVPShow showInfoWithMessage:@"请求服务器失败"];

    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    MessageModel *model = self.dataArray[indexPath.row];
    [cell refreshWithModel:model];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当点击时，会出现弹框，显示短消息的详细内容
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageModel *model = self.dataArray[indexPath.row];
    NSString *str = model.msg;
    NSString *str1 = model.time;
    self.alertView = [[UIAlertView alloc] initWithTitle:str1 message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [_alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
