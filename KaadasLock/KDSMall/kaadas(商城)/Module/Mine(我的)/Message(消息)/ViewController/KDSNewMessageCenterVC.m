//
//  KDSNewMessageCenterVC.m
//  kaadas
//
//  Created by 中软云 on 2019/8/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNewMessageCenterVC.h"
#import "KDSOrderMessageCell.h"
#import "KDSSystemMsgHttp.h"

@interface KDSNewMessageCenterVC ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSOrderMessageCellDelegate
>
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)NSMutableArray   * dataArray;
@property (nonatomic,assign)NSInteger          pageNum;
@property (nonatomic,assign)NSInteger          pageSize;
@end

@implementation KDSNewMessageCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    //创建UI
    [self createUI];
    //请求列表
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 下拉刷新
-(void)messageHeaderRefresh{
    _pageNum = 1;
    [self messageRequest];
}

#pragma mark - 上拉加载
-(void)messageFooterRefresh{
    _pageNum ++;
    [self messageRequest];
}

-(void)messageRequest{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramDict = @{@"page":@{@"pageSize":@(_pageSize),@"pageNum":@(_pageNum)},
                                 @"params":@{},
                                 @"token":[KDSMallTool checkISNull:userToken]
                                 };
    
    __weak typeof(self)weakSelf = self;
    [KDSSystemMsgHttp getSysMessageListWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSMessageModel * model = (KDSMessageModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (self.dataArray.count <= 0) {
                    self.emptyButton.hidden = NO;
                    self.tableView.mj_footer.hidden = YES;
                    [self.emptyButton setImage:[UIImage imageNamed:news_missing_pages] forState:UIControlStateNormal];
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

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSOrderMessageCell * cell = [KDSOrderMessageCell orderMessageCellWithTableView:tableView];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.rowModel = self.dataArray[indexPath.row];
    return cell;
}
-(void)initData{
    _pageNum = 1;
    _pageSize = 10;
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"消息中心";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(isIPHONE_X ? -34 : 0);
    }];

    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:news_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];

}

#pragma mark - KDSOrderMessageCellDelegate   订单点击
-(void)orderMessageCellCheckDetailButtonClick:(NSIndexPath *)indexPath{
    
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
         _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(messageHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(messageFooterRefresh)];
        _tableView.mj_footer.hidden = YES;
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
