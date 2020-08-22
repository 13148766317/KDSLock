//
//  KDSMyTeamController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyTeamController.h"
#import "KDSMyTeamDetailCell.h"
#import "KDSMineHttp.h"
#import "KDSMyTeamModel.h"

@interface KDSMyTeamController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)NSMutableArray   * dataArray;
@property (nonatomic,assign)NSInteger          pageNum;
@property (nonatomic,assign)NSInteger          pageSize;
@end

@implementation KDSMyTeamController
#pragma mark - 下拉刷新
-(void)teamHeaderRefresh{
    _pageNum = 1;
    [self requestMyTeam];
}
#pragma mark - 上拉加载更多
-(void)teamFooterRefresh{
    _pageNum ++;
    [self requestMyTeam];
}
-(void)emptyDataButtonClick{
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)requestMyTeam{
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    
    NSDictionary * paramDict = @{@"token":token,   //token
                                 @"params":@{
                                     @"teamType":@"team_type_vip" ,  //我的团队  我的粉丝 的key值   team_type_vip：我的团队 team_type_no_vip：我的粉丝;
                                     @"teamlevelType":[KDSMallTool checkISNull:_teamlevelType]   //一度vip，二度vip   directOne：一度vip    directTwo：二度vip;
                                 },
                                 @"page":@{
                                     @"pageNum":@(_pageNum),
                                     @"pageSize":@(_pageSize)
                                 }
                                 };
    
    __weak typeof(self)weakSelf = self;
    
    [KDSMineHttp  myTeamWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSMyTeamModel * model = (KDSMyTeamModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (self.dataArray.count <= 0) {
                    self.emptyButton.hidden = NO;
                    self.tableView.mj_footer.hidden = YES;
                    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
                }else{
                    self.emptyButton.hidden = YES;
                    self.tableView.mj_footer.hidden = NO;
                }
            }else{
                [weakSelf.dataArray addObjectsFromArray:array];
            }
            [weakSelf.tableView reloadData];

            if (model.total <= weakSelf.dataArray.count) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
       
    } failure:^(NSError * _Nonnull error) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
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

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    //创建UI
    [self createUI];
}

-(void)initData{
    _pageNum  = 1;
    _pageSize = 10;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    KDSMyTeamDetailCell  * cell = [KDSMyTeamDetailCell myTeamDetailCellWithTableView:tableView];
    cell.rowModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"我的团队";
    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(teamHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(teamFooterRefresh)];
        _tableView.mj_footer.hidden = YES;
        // 设置了底部inset
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 忽略掉底部inset
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = isIPHONE_X ? 34 : 10;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
