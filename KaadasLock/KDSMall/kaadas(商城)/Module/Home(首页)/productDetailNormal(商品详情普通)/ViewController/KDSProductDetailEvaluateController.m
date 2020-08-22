//
//  KDSProductDetailEvaluateController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailEvaluateController.h"
#import "KDSProductEvaluteCell.h"
#import "KDSProdutDetailHttp.h"
#import "KDSProductEvaluateModel.h"
#import "KDSEvaluateTagHeaderView.h"
#import "KDSHomePageHttp.h"
#import "KDSAllTagModel.h"
#import "KDSEvaluateTagTopView.h"

@interface KDSProductDetailEvaluateController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSProductEvaluteCellDelagete,
KDSEvaluateTagTopViewDelegate
>
@property (nonatomic,strong)UITableView          * tableView;
@property (nonatomic,assign)NSInteger              pageNum;
@property (nonatomic,assign)NSInteger              pageSize;
@property (nonatomic,strong)NSMutableArray       * dataArray;
@property (nonatomic,strong)NSMutableArray       * tagArray;
@property (nonatomic,strong)NSMutableArray       * titleArray;
@property (nonatomic,assign)NSInteger               selectIndex;
@property (nonatomic,strong) KDSEvaluateTagTopView * topView;
@property (nonatomic,copy)NSString               * commentType;

@end

@implementation KDSProductDetailEvaluateController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    //创建UI
    [self createUI];
    //标签请求
    [self tagRequest];
    [self evaluateRequest];
    
}
#pragma mark - 初始化数据
-(void)initData{
    _commentType = @"";
    _selectIndex = 0;
    _pageNum = 1;
    _pageSize = 10;
    NSDictionary * dict = @{@"value":@"全部",@"key":@""};
    [self.tagArray addObject:dict];
}

#pragma mark - 上拉加载跟多
-(void)evalauateFooterRefresh{
    _pageNum ++;
    [self evaluateRequest];
}

//-(void)setID:(NSInteger)ID{
//    _ID = ID;
//    if (_productModel == nil) {
//        _productModel = [[KDSSecondPartRowModel alloc]init];
//        _productModel.ID = _ID;
//    }
//}

#pragma mark - 商品评价列表 请求
-(void)evaluateRequest{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params": @{@"id":@(_productModel.ID),@"commentType":_commentType},
                            @"page":@{
                                    @"pageNum": @(_pageNum),
                                    @"pageSize": @(_pageSize)
                                    },
                            
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProdutDetailHttp productEvaluateDetailWithParams:dict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            
            if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
            if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                weakSelf.tableView.mj_footer.hidden = NO;
                KDSProductEvaluateModel * model = (KDSProductEvaluateModel *)obj;
                NSArray * array = model.list;
                if (weakSelf.pageNum == 1) {
                    [weakSelf.dataArray removeAllObjects];
                    [weakSelf.dataArray addObjectsFromArray:array];
                    [weakSelf.tableView.mj_footer resetNoMoreData];
                    if (self.dataArray.count <= 0) {
                        self.emptyButton.hidden = NO;
                        self.tableView.mj_footer.hidden = YES;
                        [weakSelf.emptyButton setImage:[UIImage imageNamed:discuss_missing_pages] forState:UIControlStateNormal];
//                        [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
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
                //            [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }else if (error.code == NetWorkService_serviceError){
                [weakSelf.emptyButton setImage:[UIImage imageNamed:loading_missing_pages] forState:UIControlStateNormal];
                //       [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
            }
        }

    }];
}
#pragma mark - 标签请求
-(void)tagRequest{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"token":[KDSMallTool checkISNull:userToken]};
    [KDSHomePageHttp getAllAllKeyValueWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            KDSAllTagModel * tagModel = (KDSAllTagModel *)obj;
            [self.tagArray removeAllObjects];
            NSDictionary * dict = @{@"value":@"全部",@"key":@""};
            [self.tagArray addObject:dict];
            [self.tagArray addObjectsFromArray:tagModel.comment_type];
            

            [self getEvaluateNum];
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)getEvaluateNum{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params":@{@"id":@(_productModel.ID)},
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"front/product/getCommentListByProductIdToNum" paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
       
        if (code == 1) {
            for (int i = 0; i < self.tagArray.count; i++) {
                NSDictionary * dict = self.tagArray[i];
                NSString * value = [KDSMallTool checkISNull:dict[@"value"]];
                
                switch (i) {
                    case 0:{
                        value = [NSString stringWithFormat:@"%@(%@)",value,[KDSMallTool checkISNull:json[@"data"][@"comment_type_all"]]];
                    }
                        break;
                    case 1:{
                        value = [NSString stringWithFormat:@"%@(%@)",value,[KDSMallTool checkISNull:json[@"data"][@"comment_type_good"]]];
                    }
                        break;
                    case 2:{
                        value = [NSString stringWithFormat:@"%@(%@)",value,[KDSMallTool checkISNull:json[@"data"][@"comment_type_middle"]]];
                    }
                        break;
                    case 3:{
                        value = [NSString stringWithFormat:@"%@(%@)",value,[KDSMallTool checkISNull:json[@"data"][@"comment_type_bad"]]];
                    }
                        break;
                        
                    default:
                        break;
                }
                [self.titleArray addObject:value];
                
            }
            _topView.titleArray = self.titleArray;
        }else{
            
        }
    
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

-(void)emptyDataButtonClick{
    [self evaluateRequest];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDSProductEvaluteCell * cell = [KDSProductEvaluteCell productEvaluteCellWithTableView:tableView];
    cell.count = 0;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.rowModel = self.dataArray[indexPath.row];
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    KDSEvaluateTagHeaderView *  headerView = [KDSEvaluateTagHeaderView evaluateTagHeaderViewWithTableView:tableView];
//     headerView.selectIndex = _selectIndex;
//    headerView.titleArray = self.titleArray;
//    headerView.delegate = self;
//    return headerView;
//
//}
#pragma mark - KDSEvaluateTagHeaderViewDelegate  评论标签点击 代理
-(void)evaluateTagHeaderViewButtonClick:(NSInteger)buttonTag{
    
    NSLog(@"%ld",(long)buttonTag);
    _selectIndex = buttonTag;
    NSDictionary * dict = self.tagArray[_selectIndex];
    
    _commentType = [KDSMallTool checkISNull:dict[@"key"]];
    _pageNum = 1;
   [self evaluateRequest];
}


#pragma mark - KDSProductEvaluteCellDelagete 点击评价图片查看大图
-(void)evaluateCellImageViewClick:(NSIndexPath *)cellIndexPath imageIndex:(NSInteger)imageIndex imageViewArray:(NSArray *)iamgeViewArray{
    NSMutableArray * imageUrlArray = [NSMutableArray array];
    KDSProductEvaluateRowModel * model = self.dataArray[cellIndexPath.row];
    
    NSArray * array = model.urls;
    
    for (NSString * imageStr in array) {
        [imageUrlArray addObject:[KDSMallTool checkISNull:imageStr]];
    }
    
    NSMutableArray * dataSourceArray = [NSMutableArray array];
    [imageUrlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:obj];
        data.allowSaveToPhotoAlbum = NO;
        data.sourceObject = iamgeViewArray[idx];
        [dataSourceArray addObject:data];
    }];
    
    YBImageBrowser * browser = [YBImageBrowser new];
    browser.dataSourceArray = dataSourceArray;
    browser.currentIndex = imageIndex;
    
    [browser show];
}
#pragma mark - 创建UI
-(void)createUI{
    
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    
    //标签控件
    _topView = [[KDSEvaluateTagTopView alloc]init];
    _topView.delegate = self;
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(isIPHONE_X ? 88 + 55 : 64 + 55);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    //空数据显示控件
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:@"discuss_missing_pages"] forState:UIControlStateNormal];
//    [self.emptyButton setTitle:@"暂无评价内容" forState:UIControlStateNormal];
}



#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(evalauateFooterRefresh)];
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

-(NSMutableArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}
-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
@end
