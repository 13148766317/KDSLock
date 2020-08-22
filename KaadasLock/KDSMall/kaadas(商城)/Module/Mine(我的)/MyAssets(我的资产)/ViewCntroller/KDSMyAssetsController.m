//
//  KDSMyAssetsController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyAssetsController.h"
#import "KDSMyAssetsCell.h"
#import "KDSMyTeamCell.h"
#import "KDSEarningOverviewCell.h"

#import "KDSEarningController.h"
#import "KDSMyTeamController.h"
#import "KDSGetMoneyController.h"

#import "KDSMineHttp.h"
#import "KDSMyAssetsModel.h"
#import "KDSMyAssetsDetailModel.h"

@interface KDSMyAssetsController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSMyAssetsCellDelegate,
KDSMyTeamCellDelegate,
KDSEarningOverviewCellDelegate
>
@property (nonatomic,strong)UITableView              * tableView;
@property (nonatomic,strong)KDSMyAssetsModel         * myAssetsModel;
@property (nonatomic,strong)NSDictionary             * myteamCountDict;
@property (nonatomic,strong)KDSMyAssetsDetailModel   * assertDetailModel;
@end

@implementation KDSMyAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
    
    //我的资产
    [self myassetsRequest];
    //我的团队人数
    [self myTeamCount];
    //我的资产详情
    [self myAssetsDetail:@"earn_today"];
}


#pragma mark - 我的资产 请求
-(void)myassetsRequest{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramsDict = @{
                                   @"token":token   //token;
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp myAssetsWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.myAssetsModel = (KDSMyAssetsModel *)obj;
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}


#pragma mark - 我的团队人数
-(void)myTeamCount{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramsDict = @{
                                  @"token":token   //token;
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp myTeamCountWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.myteamCountDict = obj;
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
         [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 我的资产详情
-(void)myAssetsDetail:(NSString *)earnTimeZone{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramsDict = @{
                                  @"token":token ,  //token;
                                  @"params":@{
                                      @"earnTimeZone":earnTimeZone  //4个按钮的key值  earn_today：今日 earn_yesterday：昨天  earn_month：本月 earn_year：今年;
                                  }
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp myAssetsDetailWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.assertDetailModel = (KDSMyAssetsDetailModel *)obj;
            KDSEarningOverviewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.assetsDetail = weakSelf.assertDetailModel;
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
          [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
    
}

#pragma mark - KDSEarningOverviewCellDelegate
-(void)earningOverViewCellSegmentButtonClick:(NSInteger)index{
    switch (index) {
        case 0:{
            [self myAssetsDetail:@"earn_today"];
        }
            break;
        case 1:{
            [self myAssetsDetail:@"earn_yesterday"];
        }
            break;
        case 2:{
            [self myAssetsDetail:@"earn_month"];
        }
            break;
        case 3:{
            [self myAssetsDetail:@"earn_year"];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        KDSMyAssetsCell * cell = [KDSMyAssetsCell myAssetsCellWithTableView:tableView];
        cell.delegate = self;
        cell.assetsModel = self.myAssetsModel;
        return cell;
    }else if(indexPath.row == 1){
        KDSMyTeamCell * cell = [KDSMyTeamCell myTeamCellWithTableView:tableView];
        cell.dict = self.myteamCountDict;
        cell.delegate = self;
        return cell;
    }else{
        KDSEarningOverviewCell * cell = [KDSEarningOverviewCell earningOverViewWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    
}


#pragma mark - KDSMyTeamCellDelegate  我的团队
-(void)myTeamCellEvent{
    //进入我的团队界面
    KDSMyTeamController * myTeamVC = [[KDSMyTeamController alloc]init];
    myTeamVC.teamlevelType = @"";
    [self.navigationController pushViewController:myTeamVC animated:YES];
}

-(void)myTeamCellTapClick:(NSInteger)index{
    //进入我的团队界面
    KDSMyTeamController * myTeamVC = [[KDSMyTeamController alloc]init];
    
    switch (index) {
        case 0:{
             myTeamVC.teamlevelType = @"directOne";
        }
            break;
        case 1:{
             myTeamVC.teamlevelType = @"directTwo";
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:myTeamVC animated:YES];
}

#pragma mark - KDSMyAssetsCellDelegate
-(void)myAssetsCellEvent:(KDSMyAssetsEventType)type{
    switch (type) {
        case KDSMyAssetsEvent_earning:{//明细
            KDSEarningController * earningVC = [[KDSEarningController alloc]init];
            [self.navigationController pushViewController:earningVC animated:YES];
        }
            break;
        case KDSMyAssetsEvent_getMoney:{//提现
            KDSGetMoneyController * getMoneyVC = [[KDSGetMoneyController alloc]init];
            [self.navigationController pushViewController:getMoneyVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"我的资产";
     //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100.0f;
    }
    return _tableView;
}

@end
