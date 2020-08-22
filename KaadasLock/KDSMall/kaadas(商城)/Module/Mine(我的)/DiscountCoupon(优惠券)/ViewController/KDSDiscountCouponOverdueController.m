//
//  KDSDiscountCouponOverdueController.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSDiscountCouponOverdueController.h"
#import "KDSDiscountCouponCell.h"
#import "KDSMyCouponModel.h"
#import "KDSMineHttp.h"

@interface KDSDiscountCouponOverdueController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView   * tableView;
@property (nonatomic,assign)NSInteger               pageNum;
@property (nonatomic,assign)NSInteger               pageSize;
@property (nonatomic,strong)NSMutableArray        * dataArray;



@end

@implementation KDSDiscountCouponOverdueController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    //创建UI
    [self createUI];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 下拉刷新
-(void)myPastCouponHeaderRefresh{
    _pageNum = 1;
    [self myPastCouponRequest];
}
#pragma mark - 上拉加载更多
-(void)myPastCouponFooterRefresh{
    _pageNum ++;
    [self myPastCouponRequest];
}
-(void)emptyDataButtonClick{
    [self.tableView.mj_header beginRefreshing];
}
-(void)myPastCouponRequest{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{@"params":@{ },
                                  @"page":@{ @"pageNum": @(_pageNum),
                                             @"pageSize":@(_pageSize)
                                          },
                                  @"token": [KDSMallTool checkISNull:token]
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp getMyPastDueCouponWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSMyCouponModel * model = (KDSMyCouponModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (weakSelf.dataArray.count <= 0) {
                    weakSelf.emptyButton.hidden = NO;
                    weakSelf.tableView.mj_footer.hidden = YES;
                    [weakSelf.emptyButton setImage:[UIImage imageNamed:coupon_missing_pages] forState:UIControlStateNormal];
                    [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
                }else{
                    weakSelf.emptyButton.hidden = YES;
                    weakSelf.tableView.mj_footer.hidden = NO;
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
    
    KDSDiscountCouponCell * cell = [KDSDiscountCouponCell discountCouponCellWithTableView:tableView];
    cell.overdue = YES;
    cell.rowModel = self.dataArray[indexPath.row];
    return cell;
}

-(void)createUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //空数据显示控件
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:coupon_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
}
#pragma mark - 初始化数据
-(void)initData{
    _pageNum = 1;
    _pageSize = 10;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight  = 100.0f;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(myPastCouponHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(myPastCouponFooterRefresh)];
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
