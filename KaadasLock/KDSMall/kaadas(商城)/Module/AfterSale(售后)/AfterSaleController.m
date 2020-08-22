//
//  AfterSaleController.m
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "AfterSaleController.h"
#import "OrderListCell.h"
#import "DetailModel.h"
#import "UIButton+NSString.h"
#import "OrderDetailController.h"
#import "HeadView.h"
#import "FootView.h"
#import "ComentController.h"
#import "AfterDetailController.h"
#import "KDSAfterSaleModel.h"
@interface AfterSaleController ()<UITableViewDelegate,UITableViewDataSource,OrderListCellDelegate>

@property(nonatomic ,strong)NSMutableArray    * detailArray;
@property (nonatomic,strong)UITableView       * tableView;
@property (nonatomic,strong)NSMutableArray    * dataArray;

@property (nonatomic,assign)NSInteger           pageSize;
@property (nonatomic,assign)NSInteger           pageNum;

@end

@implementation AfterSaleController
#pragma mark - 下拉刷新
-(void)afterSaleHeaderRefresh{
    _pageNum = 1;
    [self afterSaleRequest];
}

#pragma mark - 上拉加载更多
-(void)afterSaleFooterRefresh{
    _pageNum ++;
    [self afterSaleRequest];
}

#pragma mark - 请求列表接口
-(void)afterSaleRequest{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramDict = @{@"page": @{@"pageNum":@(_pageNum),
                                            @"pageSize":@(_pageSize)
                                            },
                                  @"token":[KDSMallTool checkISNull:userToken]
                                 };
    __weak typeof(self)weakSelf = self;
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"returnBill/page" paramsDict:paramDict success:^(NSInteger code, id  _Nullable json) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        if (code == 1) {
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSAfterSaleModel * model = [KDSAfterSaleModel mj_objectWithKeyValues:json[@"data"]];
            NSLog(@"model.list: %ld",model.list.count);
            NSArray * array = model.list;
            if (weakSelf.pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:array];
                [weakSelf.tableView.mj_footer resetNoMoreData];
                if (weakSelf.dataArray.count <= 0) {
                    weakSelf.emptyButton.hidden = NO;
                    weakSelf.tableView.mj_footer.hidden = YES;
                    [weakSelf.emptyButton setImage:[UIImage imageNamed:information_missing_pages] forState:UIControlStateNormal];
                    [weakSelf.emptyButton setTitle:@"" forState:UIControlStateNormal];
                    [weakSelf.view bringSubviewToFront:self.emptyButton];
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
            [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nullable error) {
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
    
    //初始化数据
    [self initData];
    //创建UI
    [self createUI];
    
    //刷新列表
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - 初始化数据
-(void)initData{
    _pageSize = 10;
    _pageNum  = 1;
}

#pragma mark - 创建UI
-(void)createUI{
     self.navigationBarView.backTitle = @"售后主页";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top. mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    [self.tableView addSubview:self.emptyButton];
    [self.emptyButton setImage:[UIImage imageNamed:contents_missing_pages] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"" forState:UIControlStateNormal];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    DetailModel *model = self.dataArray[section];
//    NSMutableArray *arr = model.indentInfo;
//    return arr.count;
    
    return 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DetailModel *model;
    if (self.dataArray.count  >0) {
        model = self.dataArray[section];
    }
    static NSString * identy = @"head";
    HeadView *headV =[tableView  dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!headV) {
        headV=[[HeadView alloc]initWithReuseIdentifier:identy];
    }
    headV.orderNoLab.text =[@"           " stringByAppendingString:[NSString stringWithFormat:@"%@" ,model.orderNo]];;
    headV.stateLab.text = model.indentStatusCN;
    
    if ([model.indentStatus isEqualToString:@"indent_status_refunded"]) {
        //售后已退款
         headV.stateLab.textColor =  [UIColor  hx_colorWithHexRGBAString:@"#666666"];
    }else{
        headV.stateLab.textColor =  [UIColor  hx_colorWithHexRGBAString:@"#ca2128"];
    }
    
    
    return headV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"产品列表";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (self.dataArray.count> 0) {
        DetailModel *dataModel =self.dataArray[indexPath.section];
        cell.detailModel = dataModel;
        cell.orderStatus = dataModel.status;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AfterDetailController *detailVC=[[AfterDetailController alloc]init];

    DetailModel *model = self.dataArray[indexPath.section];
    detailVC.detailmodel = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 状态按钮
-(void)btnClick:(UIButton *)sender{
    
    NSLog(@"text=%@" ,sender.titleLabel.text);
    NSLog(@"idString=%@" ,sender.idString);
    NSLog(@"indentInfoArr=%@" ,sender.indentInfoArr);
    
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
//        [self cancelOrder:sender.idString];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        ComentController *comentVC=[[ComentController alloc]init];
        comentVC.indeInfoArr = sender.indentInfoArr;
        comentVC.comentBlock = ^{
//            [self refreshTableViewData];
        };
        [self.navigationController pushViewController:comentVC animated:YES];
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(afterSaleHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(afterSaleFooterRefresh)];
        _tableView.mj_footer.hidden = YES;
        _tableView.estimatedRowHeight = 115;
        _tableView.estimatedSectionFooterHeight = 10.0f;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
-(NSMutableArray *)detailArray{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _detailArray;
}


//-(void)loadData:(LoadState)loadState{
//
//    [super loadData:loadState];
//    NSDictionary *dic1=@{@"indentType":@"",@"indentStatus":@"indent_status_wait_refund"};
//    NSDictionary *dic = @{ @"page":@{@"pageNum":[NSNumber numberWithInt:dataPage],@"pageSize":@"10"} ,@"params":dic1,@"token":ACCESSTOKEN};
//    [self loadDataWithBlock:loadState url:@"indent/myIndentSearch" partemer:dic Success:^(id responseObject) {
//        if ([self isSuccessData:responseObject]) {
//            NSMutableArray * dataArray = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
//            NSLog(@"请求成功返回数据=%@" ,responseObject);
//            NSMutableArray *modelarr = [NSMutableArray array];
//            for (NSDictionary *datadic in dataArray) {
//                DetailModel *detailModel = [[DetailModel alloc]initWithDictionary:datadic];
//
//                NSString *priceS = [NSString stringWithFormat:@"%@" ,datadic[@"realPay"]];
//                NSString *showS =[NSString stringWithFormat:@"共%@件商品,需付款:  ¥%@",@"1",priceS] ;
//                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showS];
//                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange((showS.length-priceS.length), priceS.length)];
//                detailModel.footAtribute =AttributedStr;
//
//                [modelarr addObject:detailModel];
//            }
//            if (dataPage == 1) {
//                [self.dataArray removeAllObjects];
//                [self.tableView.mj_footer resetNoMoreData];
//            }
//            [self.dataArray addObjectsFromArray:modelarr];
//            NSInteger total = [[[responseObject objectForKey:@"data"] objectForKey:@"total"] integerValue];
//            if (total<=self.dataArray.count) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            }
//            [self.tableView reloadData];
//            NSLog(@"总数量=%lu" ,(unsigned long)self.dataArray.count);
//        }
//    }];
//
//}

//#pragma mark  取消订单
//-(void)cancelOrder:(NSString *)orderID{
//
//    [KDSAlertController alertControllerWithTitle:@"提示" message:@"是否取消订单?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
//        NSDictionary *dic1=@{@"id":orderID};
//        NSDictionary *dic = @{@"params":dic1,@"token":ACCESSTOKEN};
//        [self submitDataWithBlock:@"indent/cancel" partemer:dic Success:^(id responseObject) {
//            if ([self isSuccessData:responseObject]) {
//                [KDSProgressHUD showSuccess:@"订单取消成功" toView:self.view completion:^{
//                }];
//                [self refreshTableViewData];
//            }
//        }];
//    } cancelBlock:^{
//    }];
//}


//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    DetailModel *model;
//    if (self.dataArray.count  >0) {
//        model = self.dataArray[section];
//    }
//
//    static NSString * identy = @"foot";
//    FootView * FootV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
//    if (!FootV) {
//        FootV = [[FootView alloc]initWithReuseIdentifier:identy];
//    }
//    FootV.priceLab.attributedText =model.footAtribute;
//
//    FootV.leftBtn.hidden = YES;
//    FootV.rightBtn.hidden = YES;
//    FootV.leftBtn.userInteractionEnabled = YES;
//    FootV.rightBtn.userInteractionEnabled = YES;
//
////    [FootV.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
////    FootV.leftBtn.idString = [NSString stringWithFormat:@"%@" ,model.myId];
////    FootV.leftBtn.indentInfoArr = model.indentInfo;
////
////    [FootV.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
////    FootV.rightBtn.idString = [NSString stringWithFormat:@"%@" ,model.myId];
////    FootV.rightBtn.indentInfoArr = model.indentInfo;
//
////    NSString *indentStatus = [NSString stringWithFormat:@"%@" ,model.indentStatus];
//////    if ([indentStatus isEqualToString:@"indent_status_wait_pay"]) {
//////        //待付款
//////        [FootV.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//////        [FootV.rightBtn setTitle:@"立即支付" forState:UIControlStateNormal];
//////    }
//////    if ([indentStatus isEqualToString:@"indent_status_wait_install"]) {
//////        //待安装
//////        [FootV.leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//////        [FootV.rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
//////    }
//////    if ([indentStatus isEqualToString:@"indent_status_wait_comment"]) {
//////        //待评论
//////        [FootV.leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//////        [FootV.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
//////    }
////    if ([indentStatus isEqualToString:@"indent_status_wait_refund"]) {
////        // 售后待退款
////        FootV.leftBtn.hidden = YES;
////        FootV.rightBtn.hidden = YES;
////    }
////    if ([indentStatus isEqualToString:@"indent_status_refunded"]) {
////        //售后已退款
////        FootV.leftBtn.hidden = YES;
////        FootV.rightBtn.hidden = YES;
//////        [FootV.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
////    }
//////    if ([indentStatus isEqualToString:@"indent_status_completed"]) {
//////        //已完成
//////        [FootV.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
//////        [FootV.rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
//////    }
//////    if ([indentStatus isEqualToString:@"indent_status_canceled"]) {
//////        //已取消
//////        FootV.leftBtn.hidden = YES;
//////        [FootV.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
//////    }
//    return FootV;
//}


//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    DetailModel *model;
//    if (self.dataArray.count  >0) {
//        model = self.dataArray[section];
//    }
//    NSString *indentStatus = [NSString stringWithFormat:@"%@" ,model.indentStatus];
//    if ([indentStatus isEqualToString:@"indent_status_wait_refund"]) {
//        //  售后待退款
//        return 55;
//    }
//    return 100;
//}

@end
