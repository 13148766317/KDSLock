//
//  KDSHomeSearchController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeSearchController.h"
#import "KDSSearchNavigation.h"
#import "KDSSearchResultCell.h"
#import "KDSHomeSearchTagHeaderView.h"
#import "KDSHomePageHttp.h"
#import "KDSSearchModel.h"
#import "KDSAllTagModel.h"
#import "KDSProductDetailNormalController.h"

@interface KDSHomeSearchController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSSearchNavigationDelegate,
KDSHomeSearchTagHeaderViewDelegate
>
@property (nonatomic,strong)KDSSearchNavigation          * searchNavigation;
@property (nonatomic,strong)UITableView                  *  tableView;
@property (nonatomic,strong)KDSHomeSearchTagHeaderView   *  tagHeaderView;
@property (nonatomic,assign)BOOL                            hiddenTableViewHeader;
@property (nonatomic,assign)NSInteger                       pageNum;
@property (nonatomic,assign)NSInteger                       pageSize;
@property (nonatomic,strong)NSMutableArray               * dataArray;
@property (nonatomic,strong)NSString                     * searchText;
@property (nonatomic,strong)NSMutableArray               * tagArray;
@end

@implementation KDSHomeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    _hiddenTableViewHeader = NO;
    _pageNum = 1;
    _pageSize = 10;
    _searchText = @"";
    //创建UI
    [self createUI];
    
//    [self getData];
    [self getAllTag];
}

#pragma mark - 获取标签
-(void)getAllTag{
     NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    __weak typeof(self)weakSelf = self;
    [KDSHomePageHttp getAllAllKeyValueWithParams:@{@"token":[KDSMallTool checkISNull:userToken]} success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            KDSAllTagModel * allTagModel  = (KDSAllTagModel *)obj;
            [self.tagArray removeAllObjects];
            for (NSDictionary * dict in allTagModel.hot_key) {
                [self.tagArray addObject:dict[@"value"]];
            }
             [weakSelf.tagHeaderView tagHeaderViewWithTableView:self.tableView tagArray:self.tagArray];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
                
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    } ];
}

#pragma mark - 调用搜索接口
-(void)getData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramsDict = @ {@"params": @{@"key":_searchText}, // string  非必填 不填查询所有
                                    @"page":@{@"pageNum": @(_pageNum),@"pageSize": @(_pageSize)},
                                    @"token":[KDSMallTool checkISNull:userToken]
                                };
    __weak typeof(self)weakSelf = self;
    
    if (_pageNum == 1) {
        [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    }
    [KDSHomePageHttp getFirstSearchWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.pageNum == 1) {
            [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        }
        if (isSuccess) {
            weakSelf.hiddenTableViewHeader = YES;
            weakSelf.tableView.tableHeaderView = nil;
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSSearchModel * model = (KDSSearchModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (self.dataArray.count <= 0) {
                    self.emptyButton.hidden = NO;
                    self.tableView.mj_footer.hidden = YES;
                    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                    //    [self.emptyButton setTitle:@"暂无数据" forState:UIControlStateNormal];
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
        if (weakSelf.pageNum == 1) {
           [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        }
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
#pragma mark - 下拉刷新
-(void)searchHeaderRefresh{
    _pageNum = 1;
    [self getData];
}

#pragma mark - 上拉加载更多
-(void)searchFooterRefresh{
    _pageNum ++;
    [self getData];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hiddenTableViewHeader ? self.dataArray.count: 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSSearchResultCell * cell = [KDSSearchResultCell searchResultCellWithTableView:tableView];
    cell.rowModel = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSSearchRowModel * model = self.dataArray[indexPath.row];
    KDSSecondPartRowModel * rowModel = [[KDSSecondPartRowModel alloc]init];
    rowModel.ID = model.ID;
    KDSProductDetailNormalController * detailNorVC = [[KDSProductDetailNormalController alloc]init];
    detailNorVC.rowModel = rowModel;
    [self.navigationController pushViewController:detailNorVC animated:YES];
}

#pragma mark - KDSSearchNavigationDelegate  搜索点击
-(void)searchNavigationSearchClick:(NSString *)searchStr{
    NSLog(@"搜索:%@",searchStr);
    [self searchEvent:searchStr];
   
}
#pragma mark - 点击输入框的清除代理
-(void)searchTextFieldShouldClear{
    [self.tagHeaderView tagHeaderViewWithTableView:self.tableView tagArray:self.tagArray];
    _hiddenTableViewHeader = NO;
    self.emptyButton.hidden = YES;
    [self.tableView reloadData];
  
}
#pragma mark - 输入框内容改变代理
-(void)textFieldChange:(NSString *)text{
    if (text.length<=0) {
        [self.tagHeaderView tagHeaderViewWithTableView:self.tableView tagArray:self.tagArray];
        _hiddenTableViewHeader = NO;
        self.emptyButton.hidden = YES;
        [self.tableView reloadData];
    }
}

#pragma mark - 点击键盘搜索代理
-(void)textFieldReturn:(NSString *)text{
    NSLog(@"return :搜索");
    [self searchEvent:text];
}

-(void)searchEvent:(NSString *)str{
     [self.view endEditing:NO];
    if (str.length <= 0) {
        [KDSProgressHUD showTextOnly:@"请输入搜索内容" toView:self.view completion:^{
            
        }];
        return;
    }
    _pageNum = 1;
    _searchText = str;
    //请求接口
    [self searchHeaderRefresh];
}

#pragma mark - KDSHomeSearchTagHeaderViewDelegate  点击标签 事件
-(void)honeSearchTagClick:(NSString *_Nullable)searchStr{
    if ([KDSMallTool checkISNull:searchStr].length <=0 ) {
        return;
    }
    _searchNavigation.text = searchStr;
//    _hiddenTableViewHeader = YES;
//    self.tableView.tableHeaderView = nil;
//    [self.tableView reloadData];
    
}
#pragma mark - 创建UI
-(void)createUI{
    
    _searchNavigation = [[KDSSearchNavigation alloc]init];
    _searchNavigation.delegate = self;
    [_searchNavigation.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchNavigation];
    [_searchNavigation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MnavcBarH);
    }];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchNavigation.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
    //    [self.emptyButton setTitle:@"暂无数据" forState:UIControlStateNormal];
    self.emptyButton.hidden = YES;
    
}

-(void)backButtonClick{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(searchHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(searchFooterRefresh)];
        _tableView.mj_footer.hidden = YES;
        // 设置了底部inset
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 忽略掉底部inset
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = isIPHONE_X ? 34 : 10;
    }
    return _tableView;
}
#pragma mark - 懒加载标签控件
-(KDSHomeSearchTagHeaderView *)tagHeaderView{
    if (_tagHeaderView == nil) {
        _tagHeaderView =[[KDSHomeSearchTagHeaderView alloc]init];
        _tagHeaderView.frame = CGRectMake(0, 0, KSCREENWIDTH, 60);
        _tagHeaderView.delegate = self;
    }
    return _tagHeaderView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [[NSMutableArray alloc]init];
    }
    return _tagArray;
}
@end
