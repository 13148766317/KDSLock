//
//  KDSCategoryDetailController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCategoryDetailController.h"
#import "KDSSearchResultCell.h"
//#import "KDSProductCategoryHeaderView.h"
#import "KDSHomePageHttp.h"
#import "KDSProductCategoryAlert.h"
#import "KDSProductListModel.h"
#import "KDSCategoryChildModel.h"
#import "KDSCategoryHeaderView.h"
#import "KDSProductDetailNormalController.h"


@interface KDSCategoryDetailController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSProductCategoryHeaderViewDelegate
>
@property (nonatomic,strong)UITableView          *  tableView;
@property (nonatomic,assign)NSInteger               pageNum;
@property (nonatomic,assign)NSInteger               pageSize;
@property (nonatomic,strong)NSMutableArray        * dataArray;
@property (nonatomic,strong)NSMutableArray        * categotyArray;
@property (nonatomic,strong)KDSCategoryChildModel * childModel;
@property (nonatomic,strong)KDSCategoryHeaderView   * headerView;
@end

@implementation KDSCategoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNum = 1;
    _pageSize = 10;
    [self createUI];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 下拉刷新
-(void)procudtCategoryHeaderRefresh{
    _pageNum = 1;
    [self requestData];
}
#pragma mark - 上拉加载更多
-(void)procudtCategoryFooterRefresh{
    _pageNum ++;
    [self requestData];
}
-(void)emptyDataButtonClick{
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)requestData{
    
//    NSString *  IDStr = @"";
//    if (_ID > 0) {
//        IDStr = _childModel.ID;
//    }
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{@"params": @{@"categoryId":@(_ID),@"keyword":@""},
                                  @"page":@{ @"pageNum": @(_pageNum),@"pageSize":@(_pageSize)},
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    
    __weak typeof(self)weakSelf  = self;
    
    [KDSHomePageHttp getProductListWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSProductListModel * model = (KDSProductListModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (weakSelf.dataArray.count <= 0) {
                    weakSelf.emptyButton.hidden = NO;
                    weakSelf.tableView.mj_footer.hidden = YES;
                    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                    //    [self.emptyButton setTitle:@"暂无数据" forState:UIControlStateNormal];
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
    KDSSearchResultCell * cell = [KDSSearchResultCell searchResultCellWithTableView:tableView];
    cell.listRowModel = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSProductListRowModel * model = self.dataArray[indexPath.row];
    KDSSecondPartRowModel * rowModel = [[KDSSecondPartRowModel alloc]init];
    rowModel.ID = model.ID;
    
    KDSProductDetailNormalController * detailNorVC = [[KDSProductDetailNormalController alloc]init];
    detailNorVC.rowModel = model;
    [self.navigationController pushViewController:detailNorVC animated:YES];
}


//#pragma mark - 筛选button点击事件
-(void)productCategiryButtonClick:(NSInteger)index{
    _childModel = self.categotyArray[index];
    [self procudtCategoryHeaderRefresh];
    
    //    KDSProductCategoryHeaderView * header = (KDSProductCategoryHeaderView *)[self.tableView headerViewForSection:0];
    //    //将rect由header所在视图转换到目标视图view中，返回在目标视图self.view中的rect
    //    CGRect rect = [header convertRect:button.frame toView:self.view];
    //
    //    NSLog(@"%@",NSStringFromCGRect(rect));
    //    KDSProductCategoryAlert * alert = [KDSProductCategoryAlert productCategoryShowRect:rect button:button];
    
}

#pragma mark - 创建UI
-(void)createUI{
    
//    self.navigationBarView.backTitle = _titleStr;
    self.navigationBarView.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
//    [self.emptyButton setTitle:@"暂无数据" forState:UIControlStateNormal];
    
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor =  [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(procudtCategoryHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(procudtCategoryFooterRefresh)];
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
-(NSMutableArray *)categotyArray{
    if (_categotyArray == nil) {
        _categotyArray  = [NSMutableArray array];
    }
    return _categotyArray;
}
@end
