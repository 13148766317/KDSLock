//
//  KDSMessageCenterController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMessageCenterController.h"
#import "KDSSystemMessageController.h"
#import "KDSOrderMessageController.h"
#import "KDSActivityMessageController.h"

#import "KDSMessageCenterCell.h"

#import "KDSSystemMsgHttp.h"


@interface KDSMessageCenterController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)NSArray          * titleArray;
@property (nonatomic,strong)NSArray          * imageArray;
@property (nonatomic,strong)NSMutableArray   * dataArray;
@end

@implementation KDSMessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
    
    [self getData];
    
}
-(void)emptyDataButtonClick{
    [self getData];
    
}


-(void)getData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * dict = @{@"params":@{},
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    
    __weak typeof(self)weakSelf = self;
    [KDSSystemMsgHttp getSysMessageNumberWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:obj];
            [weakSelf.tableView reloadData];
            
            if (self.dataArray.count <= 0) {
                self.emptyButton.hidden = NO;
                self.tableView.mj_footer.hidden = YES;
                [self.emptyButton setImage:[UIImage imageNamed:news_missing_pages] forState:UIControlStateNormal];
//                [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }else{
                self.emptyButton.hidden = YES;
                self.tableView.mj_footer.hidden = NO;
            }
           
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
        if (weakSelf.dataArray.count <= 0) {
            if (error.code == NetWorkService_NoNetWork ) {
                [weakSelf.emptyButton setImage:[UIImage imageNamed:network_missing_pages] forState:UIControlStateNormal];
                // [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }else if (error.code == NetWorkService_serviceError){
                [weakSelf.emptyButton setImage:[UIImage imageNamed:loading_missing_pages] forState:UIControlStateNormal];
                //  [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }
        }
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    KDSMessageCenterCell * cell = [KDSMessageCenterCell messageCenterCellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDSSytemMsgNumModel * model = self.dataArray[indexPath.row];
    
    if ([model.messageType isEqualToString:@"message_type_system"]) {//系统消息
        KDSSystemMessageController * systemMessageVC = [[KDSSystemMessageController alloc]init];
        systemMessageVC.backBlock = ^(BOOL success) {
            model.number = 0;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:systemMessageVC animated:YES];
    }else if ([model.messageType isEqualToString:@"message_type_indent"]){//订单消息
        KDSOrderMessageController * orderMessageVC = [[KDSOrderMessageController alloc]init];
        orderMessageVC.backBlock = ^(BOOL success) {
            model.number = 0;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:orderMessageVC animated:YES];
    }else if ([model.messageType isEqualToString:@"message_type_activity"]){//活动消息
        KDSActivityMessageController * activityMessageVC = [[KDSActivityMessageController alloc]init];
        activityMessageVC.backBlock = ^(BOOL success) {
            model.number = 0;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:activityMessageVC animated:YES];
    }
    
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle =@"消息中心";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:news_missing_pages] forState:UIControlStateNormal];
//    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
    

}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 80;
    }
    
    return _tableView;
}



-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



//-(NSArray *)titleArray{
//    if (_titleArray == nil) {
//        _titleArray = [NSArray arrayWithObjects:@"系统消息",@"订单消息",@"活动消息", nil];
//    }
//    return _titleArray;
//}

//-(NSArray *)imageArray{
//    if (_imageArray == nil) {
//        _imageArray = [NSArray arrayWithObjects:@"icon_system_mine_message",@"icon_goods_mine_message",@"icon_activity_mine_message", nil];
//    }
//    return _imageArray;
//}

@end
