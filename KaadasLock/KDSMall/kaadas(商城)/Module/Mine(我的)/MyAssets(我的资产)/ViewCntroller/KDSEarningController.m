//
//  KDSEarningController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningController.h"

#import "KDSEarningHeaderView.h"
#import "KDSEarningTableCell.h"
#import "KDSMineHttp.h"
#import "KDSEarningDetailModel.h"

@interface KDSEarningController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView     * tableView;
@property (nonatomic,assign)NSInteger          pageNum;
@property (nonatomic,assign)NSInteger          pageSize;
@property (nonatomic,strong)NSMutableArray   * dataArray;
@property (nonatomic,assign)NSInteger          total;
@end

@implementation KDSEarningController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
    [self initData];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 下拉刷新
-(void)earningHeaderRefresh{
    _pageNum = 1;
    [self requestEarningData];
}
#pragma mark - 上拉加载更多
-(void)earningFooterRefresh{
    _pageNum ++ ;
    [self requestEarningData];
}
-(void)emptyDataButtonClick{
    [self.tableView.mj_header beginRefreshing];
}
-(void)totalArray:(NSArray *)array isHeaderRefresh:(BOOL)isHeaderRefresh{
    if (isHeaderRefresh) {
        _total = 0;
    }
    
    for (KDSEarningMonthModel * monthModel in array) {
        for (int i = 0; i< monthModel.list.count ;i++) {
            _total +=1;
        }
    }
    
    NSLog(@"_total:%ld",_total);
}
-(void)requestEarningData{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramsDict = @ {@"token":token,
                                    @"page":@{@"pageNum":@(_pageNum),
                                              @"pageSize":@(_pageSize)
                                    }
                                };
    
    __weak typeof(self)weakSelf = self;
    
    [KDSMineHttp earnDetailsWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) {[weakSelf.tableView.mj_header endRefreshing];}
        if ([weakSelf.tableView.mj_footer isRefreshing]) {[weakSelf.tableView.mj_footer endRefreshing];}
        
        if (isSuccess) {
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSEarningDetailModel  * model = (KDSEarningDetailModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (weakSelf.dataArray.count <= 0) {
                    weakSelf.emptyButton.hidden = NO;
                    weakSelf.tableView.mj_footer.hidden = YES;
                    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
                }else{
                    weakSelf.emptyButton.hidden = YES;
                    weakSelf.tableView.mj_footer.hidden = NO;
                }
                [self totalArray:array isHeaderRefresh:YES];
            }else{
                if (array.count > 0) {
                    if (weakSelf.dataArray.count > 0) {
                        KDSEarningMonthModel * lastMonthModel = [self.dataArray lastObject];
                        for (KDSEarningMonthModel * monthModel in array) {
                            if ([lastMonthModel.date isEqualToString:monthModel.date]) {
                                [lastMonthModel.list addObjectsFromArray:monthModel.list];
                                [self.dataArray replaceObjectAtIndex:self.dataArray.count - 1 withObject:lastMonthModel];
                            }else{
                                [self.dataArray addObject:monthModel];
                            }
                        }
                    }
                }
                [self totalArray:array isHeaderRefresh:NO];
            }
            
            if (model.total <= weakSelf.total) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.tableView reloadData];
        }else{
            if (weakSelf.pageNum == 1) {
                if (weakSelf.dataArray.count <= 0) {
//                    weakSelf.emptyButton.hidden = NO;
                    weakSelf.tableView.mj_footer.hidden = YES;
                }else{
//                    weakSelf.emptyButton.hidden = YES;
                    weakSelf.tableView.mj_footer.hidden = NO;
                }
            }
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if ([weakSelf.tableView.mj_header isRefreshing]) {[weakSelf.tableView.mj_header endRefreshing];}
        if ([weakSelf.tableView.mj_footer isRefreshing]) {[weakSelf.tableView.mj_footer endRefreshing];}
    
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

-(void)initData{
    _pageNum  = 1;
    _pageSize = 10;
}
#pragma mark -  创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"收益明细";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
    
    
  
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    KDSEarningMonthModel * monthModel = self.dataArray[section];
    return monthModel.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    KDSEarningTableCell * cell = [KDSEarningTableCell earningCellWithTableView:tableView];
    KDSEarningMonthModel * monthModel = self.dataArray[indexPath.section];
    cell.dayModel = monthModel.list[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KDSEarningHeaderView * headerView = [KDSEarningHeaderView earningHeaderWithTableView:tableView];
    KDSEarningMonthModel * monthModel = self.dataArray[section];
    headerView.monthModel = monthModel;
    return  headerView;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50.0f;
        _tableView.estimatedSectionHeaderHeight = 20.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(earningHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(earningFooterRefresh)];
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
