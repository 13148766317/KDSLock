//
//  KDSMyFootPrintController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyFootPrintController.h"
#import "KDSMyFootprintHeaderView.h"
#import "KDSMyFootPrintCell.h"
#import "KDSMyFootPrintBottomView.h"
#import "KDSMineHttp.h"
#import "KDSFootPrintListModel.h"
#import "KDSProdutDetailHttp.h"
#import "KDSProductDetailNormalController.h"

@interface KDSMyFootPrintController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSMyFootPrintBottomViewDelegate,
KDSMyFootPrintCellDelegate
>
@property (nonatomic,strong)UIButton                   * rightItem;
@property (nonatomic,strong)UITableView                * tableView;
@property (nonatomic,strong)KDSMyFootPrintBottomView   * bottomView;
@property (nonatomic,assign)NSInteger                    pageNum;
@property (nonatomic,assign)NSInteger                    pageSize;
@property (nonatomic,strong)NSMutableArray             * dataArray;
@property (nonatomic,strong)NSMutableDictionary        * selectProductDict;
@property (nonatomic,assign)NSInteger                    totalCount;
@end

@implementation KDSMyFootPrintController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    //创建UI
    [self createUI];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 下拉刷新
-(void)footPrintHeaderRefresh{
    _pageNum = 1;
    [self footPrintRequestData];
}

#pragma mark - 上拉加载更多
-(void)ootPrintFooterRefresh{
    _pageNum ++;
    [self footPrintRequestData];
}
-(void)emptyDataButtonClick{
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)footPrintRequestData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{@"page":@{@"pageNum"   : @(_pageNum),
                                            @"pageSize"  : @(_pageSize)
                                            },
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp myFootPrintListWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSFootPrintListModel * model = (KDSFootPrintListModel *)obj;
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (weakSelf.dataArray.count <= 0) {
                    
                    weakSelf.tableView.mj_footer.hidden = YES;
                    weakSelf.navigationBarView.rightItem.hidden = YES;
                    weakSelf.bottomView.hidden = YES;
                    weakSelf.emptyButton.hidden = NO;
                    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
                }else{
                    weakSelf.emptyButton.hidden = YES;
                    weakSelf.tableView.mj_footer.hidden = NO;
                    weakSelf.navigationBarView.rightItem.hidden = NO;
                }

            }else{
                [weakSelf.dataArray addObjectsFromArray:array];
            }
            
            for (KDSFootPrintRowModel * rowModel in model.list) {
                weakSelf.totalCount += rowModel.list.count;
            }
            
            [weakSelf.tableView reloadData];

            if (model.total <= weakSelf.totalCount) {
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    KDSFootPrintRowModel * model = self.dataArray[section];
    return model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSMyFootPrintCell * cell = [KDSMyFootPrintCell myFootPrintCellWithTableView:tableView];
    cell.editState = _rightItem.selected;
    cell.indexPath = indexPath;
    cell.delegate = self;
    KDSFootPrintRowModel * model = self.dataArray[indexPath.section];
    cell.rowFootModel = model.list[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KDSMyFootprintHeaderView * headerView = [KDSMyFootprintHeaderView myFootPrintHeaderViewWithTableView:tableView];
    KDSFootPrintRowModel * model = self.dataArray[section];
    headerView.dataString = model.date;
    return headerView;
}

#pragma mark - 点击进入商品详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSFootPrintRowModel * model = self.dataArray[indexPath.section];
    KDSMyCollectRowModel * rowModel = model.list[indexPath.row];

    KDSProductDetailNormalController * normalDetailVC = [[KDSProductDetailNormalController alloc]init];
    KDSSecondPartRowModel * partRowModel = [[KDSSecondPartRowModel alloc]init];
    partRowModel.ID = rowModel.productId;
    normalDetailVC.rowModel = partRowModel;
    [self.navigationController pushViewController:normalDetailVC animated:YES];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - KDSMyFootPrintBottomViewDelegate
-(void)myfootPrintBottomViewEvent:(KDSMyFootPrintBottomViewEvent)type isAllSelect:(BOOL)isAllSelect{
    switch (type) {
        case KDSMyFootPrintBottomViewEvent_allSelect:{//全选
            [self.selectProductDict removeAllObjects];
            for (KDSFootPrintRowModel * rowModel in self.dataArray) {
                for (KDSMyCollectRowModel * model in rowModel.list) {
                    model.select = isAllSelect;
                    if (isAllSelect) {
                        NSString * ID = [NSString stringWithFormat:@"%ld",model.ID];
                        [self.selectProductDict setValue:model forKey:ID];
                    }
                }
            }
             [self.tableView reloadData];
        }
            break;
        case KDSMyFootPrintBottomViewEvent_delete:{//删除
            [self deleteFootPrint];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 添加购物车
-(void)myFootPrictCellshopCaetButtonClick:(NSIndexPath *)indexPath{
    KDSFootPrintRowModel * model = self.dataArray[indexPath.section];
    KDSMyCollectRowModel * rowModel = model.list[indexPath.row];
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params": @{@"agentProductId":@(rowModel.productId),@"qty":@"1"},
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    //添加购物车
    [KDSProdutDetailHttp addShopCartProductWithParams:dict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            
            [KDSProgressHUD showSuccess:@"购物车添加成功" toView:weakSelf.view completion:^{}];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
            
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
    
}

#pragma mark - 删除足迹
-(void)deleteFootPrint{
    if (self.selectProductDict.allKeys.count <= 0) {
        return;
    }
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * dict = @{@"params":@{
                                    @"id":self.selectProductDict.allKeys                        //渠道商品Ids
                                    },
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSMineHttp deleteFootPrintWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            [KDSProgressHUD showTextOnly:@"删除成功" toView:weakSelf.view completion:^{ }];
//            [weakSelf.tableView.mj_header beginRefreshing];
            //判断是否全删商品
            if (weakSelf.selectProductDict.allKeys.count == weakSelf.totalCount) {
                weakSelf.navigationBarView.rightItem.hidden = YES;
                weakSelf.bottomView.hidden = YES;
                weakSelf.rightItem.selected = NO;
                weakSelf.bottomView.allSelectButtonState = NO;
                [self.dataArray removeAllObjects];
                weakSelf.emptyButton.hidden = NO;
                [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
                [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }else{
                weakSelf.navigationBarView.rightItem.hidden = NO;
                
                NSMutableArray * newDataArray = [NSMutableArray array];
                for (KDSFootPrintRowModel * rowModel in self.dataArray) {
                    KDSFootPrintRowModel  * newRowModel = [[KDSFootPrintRowModel alloc]init];
                    newRowModel.date = rowModel.date;
                    newRowModel.list = [NSMutableArray array];
                    for (KDSMyCollectRowModel * model in rowModel.list) {
                        NSString * ID = [NSString stringWithFormat:@"%ld",model.ID];
                        KDSMyCollectRowModel  * newModel = [weakSelf.selectProductDict objectForKey:ID];
                        if (![weakSelf.selectProductDict objectForKey:ID]) {
                            [newRowModel.list addObject:model];
                        }
                    }
                    if (newRowModel.list.count > 0) {
                        [newDataArray addObject:newRowModel];
                    }
                }

                self.dataArray = newDataArray;

            }
            [weakSelf.selectProductDict removeAllObjects];
            
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - KDSMyFootPrintCellDelegate 选中button 点击事件
-(void)myFootPrictCellSelectButtonClick:(NSIndexPath *)indexPath isSelect:(BOOL)isSelect{
    KDSFootPrintRowModel * rowModel = self.dataArray[indexPath.section];
    KDSMyCollectRowModel * model = rowModel.list[indexPath.row];
    NSString * ID = [NSString stringWithFormat:@"%ld",model.ID];
    model.select = isSelect;
    if (isSelect) {//选中
        [self.selectProductDict setValue:model forKey:ID];
    }else{//取消选中
        [self.selectProductDict removeObjectForKey:ID];
    }


    //根据用户手动选中商品的个数 判断是否选中底部的全选button
    if (self.selectProductDict.allKeys.count >= self.totalCount) {
        self.bottomView.allSelectButtonState = YES;
    }else{
        self.bottomView.allSelectButtonState = NO;
    }
    
    NSLog(@"selectProductDict:%@",self.selectProductDict);
    
}
#pragma mark - 管理button点击事件
-(void)rightItemClick{
    _rightItem.selected = !_rightItem.selected;
    [self.tableView reloadData];
    
    if (_rightItem.selected) {
        self.bottomView.hidden = NO;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
            make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        }];
    }else{
        self.bottomView.hidden = YES;;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? - 34 : 0);
            make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        }];
    }
}
#pragma mark - 初始化数据
-(void)initData{
    _pageNum = 1;
    _pageSize = 10;
    _totalCount = 0;
}
#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"我的足迹";
    
    _rightItem  = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightItem.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightItem setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
    [_rightItem setTitle:@"完成" forState:UIControlStateSelected];
    [_rightItem setTitle:@"管理" forState:UIControlStateNormal];
    [_rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = _rightItem;
    _rightItem.hidden = YES;
    
    //底部删除button
    [self.view addSubview:self.bottomView];
    self.bottomView.hidden = YES;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(isIPHONE_X ? -34:0);
        make.height.mas_equalTo(49);
    }];
    
    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
    
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 130.0f;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(footPrintHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(ootPrintFooterRefresh)];
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
-(NSMutableDictionary *)selectProductDict{
    if (_selectProductDict == nil) {
        _selectProductDict = [NSMutableDictionary dictionary];
    }
    return _selectProductDict;
}
-(KDSMyFootPrintBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[KDSMyFootPrintBottomView alloc]init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
@end
