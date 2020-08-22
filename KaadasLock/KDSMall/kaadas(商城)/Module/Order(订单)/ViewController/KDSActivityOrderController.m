//
//  KDSActivityOrderController.m
//  kaadas
//
//  Created by 中软云 on 2019/7/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSActivityOrderController.h"
#import "OrderListCell.h"
#import "DetailModel.h"
#import "UIButton+NSString.h"
#import "TopBarView.h"
#import "OrderDetailController.h"
#import "HeadView.h"
#import "FootView.h"
#import "ComentController.h"
#import "RepairController.h"
#import "KDSPayController.h"
#import "KDSOrderNavigationBar.h"
#import "KDSProductCategoryAlert.h"
#import "KDSHomePageHttp.h"
#import "KDSAllTagModel.h"
#import "KDSApplyRefundController.h"


@interface KDSActivityOrderController ()
<UITableViewDelegate,UITableViewDataSource,TopBarViewDelegate,OrderListCellDelegate>{
    int dataPage;
//    NSArray *statusArr;
}
@property(nonatomic ,strong)NSMutableArray                   *detailArray;
@property (nonatomic, strong) UITableView                    *tableView;
@property (nonatomic, strong) NSMutableArray                 *dataArray;
//@property (nonatomic, strong) TopBarView *barView;
@property (nonatomic,strong)KDSOrderNavigationBar            * navigationBar;
@property (nonatomic,strong)NSArray                          * tagArray;
@property (nonatomic,strong)NSMutableArray                   * titleTagArray;
@end

@implementation KDSActivityOrderController

- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.estimatedRowHeight = 115;
        // 设置了底部inset
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 忽略掉底部inset
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = isIPHONE_X ? 34 : 10;
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
-(NSArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [NSArray array];
    }
    return _tagArray;
}
-(NSMutableArray *)titleTagArray{
    if (_titleTagArray == nil) {
        _titleTagArray = [NSMutableArray array];
    }
    return _titleTagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_dict) {
        self.navigationBarView.backTitle = [KDSMallTool checkISNull:_dict[@"value"]];
    }
    
    self.loadingViewFrame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH);
//    [self initTopBar];
    [self addTableView];
    
    dataPage = 1;
//    statusArr=@[@"",@"indent_status_wait_pay",@"indent_status_wait_install",@"indent_status_wait_comment"];
//    [self.barView changeTag:self.selectIndex];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableViewData) name:@"刷新列表" object:nil];
    
    if (_backPopToRoot) {
        NSArray * VCArray = self.navigationController.viewControllers;
        NSMutableArray * newVCArray = [NSMutableArray arrayWithObjects:[VCArray firstObject],[VCArray lastObject], nil];
        self.navigationController.viewControllers = (NSArray *)newVCArray;
    }
    
}
//-(void)initTopBar{
//    NSArray * array = @[@"全部",@"待付款",@"待安装",@"待评价"];
//    self.barView = [[TopBarView alloc]initWithFrame:CGRectMake(0, MnavcBarH, KSCREENWIDTH, 50)];
//    self.barView .backgroundColor = [UIColor whiteColor];
//    self.barView .delegate = self;
//    [self.barView  setUpStatusButtonWithTitle:array normalColor:[UIColor  hx_colorWithHexRGBAString:@"#666666"] selectedColor:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] lineColor:[UIColor hx_colorWithHexRGBAString:@"#ca2128"]];
//    [self.view addSubview:self.barView ];
//}
#pragma mark TopBarViewDelegate
-(void)statusViewSelectIndex:(NSInteger)index{
//    NSLog(@"index=%ld" ,(long)index);
//    self.selectIndex = index;
//    [self.barView changeTag:index];
    [self refreshTableViewData];
    
}
-(void)addTableView{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    [self setHeaderFooterRefresh];
    
}

-(void)setHeaderFooterRefresh{
    
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            dataPage = 1;
            [self loadData:refreshData];
        } completion:^(BOOL finished) {
            [self.tableView.mj_header endRefreshing];
            
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            dataPage += 1;
            [self loadData:refreshData];
        } completion:^(BOOL finished) {
            [self.tableView.mj_footer endRefreshing];
        }];
        
    }];
    
}

-(void)refreshTableViewData{
    
    if (self.dataArray.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView setContentOffset:CGPointMake(0,-50)animated:NO];//65?
    }
    
    dataPage = 1;
    [self reloadData];
    
    //    [self.tableView.mj_header beginRefreshing];
    
}

- (void)wxpayResult:(NSNotification *)noti{
    NSString *areslut = [NSString stringWithFormat:@"%@" ,noti.object];
    NSLog(@"areslut=%@" ,areslut);
    if ([areslut isEqualToString:@"成功"]) {
        [self showToastSuccess:@"支付成功"];
        [self refreshTableViewData];
    }if ([areslut isEqualToString:@"失败"]) {
        [self showToastError:@"支付失败"];
    }if ([areslut isEqualToString:@"取消"]) {
        [self showToastError:@"支付取消"];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    DetailModel *model = self.dataArray[section];
    NSMutableArray *arr = model.indentInfo;
    return arr.count;
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
    
    if ( [model.indentStatus isEqualToString:@"indent_status_refunded"]||[model.indentStatus isEqualToString:@"indent_status_completed"]||[model.indentStatus isEqualToString:@"indent_status_canceled"]) {
        headV.stateLab.textColor = [UIColor  hx_colorWithHexRGBAString:@"#666666"];
    }else{
        headV.stateLab.textColor = [UIColor  hx_colorWithHexRGBAString:@"#ca2128"];
    }
    
    return headV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    DetailModel *model;
    if (self.dataArray.count  >0) {
        model = self.dataArray[section];
    }
    
    static NSString * identy = @"foot";
    FootView * FootV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!FootV) {
        FootV = [[FootView alloc]initWithReuseIdentifier:identy];
    }
    FootV.priceLab.attributedText =model.footAtribute;
    
    FootV.leftBtn.hidden = NO;
    FootV.rightBtn.hidden = NO;
    FootV.leftBtn.userInteractionEnabled = YES;
    FootV.rightBtn.userInteractionEnabled = YES;
    
    FootV.leftBtn.tag = section;
    FootV.rightBtn.tag = section;
    
    [FootV.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootV.leftBtn.idString = [NSString stringWithFormat:@"%@" ,model.myId];
    FootV.leftBtn.indentInfoArr = model.indentInfo;
    
    [FootV.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootV.rightBtn.idString = [NSString stringWithFormat:@"%@" ,model.myId];
    FootV.rightBtn.indentInfoArr = model.indentInfo;
    FootV.leftBtn.hidden = YES;
    FootV.rightBtn.hidden = YES;
    
    NSString *indentStatus = [NSString stringWithFormat:@"%@" ,model.indentStatus];
    NSString * indentType = [NSString stringWithFormat:@"%@",model.indentType];
    
    if ([indentType isEqualToString:@"product_type_group"]) {//团购
        if ([indentStatus isEqualToString:@"indent_status_in_group"]) {//拼团中
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = YES;
        }else if ([indentStatus isEqualToString:@"group_type_completed"]){//拼团成功
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"确认安装" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"group_type_completed"]){//拼团结束
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = YES;
        }else if ([indentStatus isEqualToString:@"indent_status_wait_comment"]){//待评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//已评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = YES;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
//            [FootV.rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_wait_install"]){//待安装
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"确认安装" forState:UIControlStateNormal];
        }
    }else if ([indentType isEqualToString:@"product_type_seckill"]){//秒杀
        
        if ([indentStatus isEqualToString:@"indent_status_wait_install"]) {//待安装
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"确认安装" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_wait_comment"]){//待评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
//            [FootV.leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//已评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = YES;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"" forState:UIControlStateNormal];
        }
    }else if ([indentType isEqualToString:@"product_type_bargain"]){//砍价
        if ([indentStatus isEqualToString:@"indent_status_wait_install"]) {//待安装
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"确认安装" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_wait_comment"]){//待评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = NO;
            //            [FootV.leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//已评价
            FootV.leftBtn.hidden = YES;
            FootV.rightBtn.hidden = YES;
            [FootV.leftBtn setTitle:@"" forState:UIControlStateNormal];
            [FootV.rightBtn setTitle:@"" forState:UIControlStateNormal];
        }
    }
    
    return FootV;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    DetailModel *model;
    if (self.dataArray.count  >0) {
        model = self.dataArray[section];
    }
    NSString *indentStatus = [NSString stringWithFormat:@"%@" ,model.indentStatus];
     if ([indentStatus isEqualToString:@"indent_status_wait_refund"] || [indentStatus isEqualToString:@"indent_status_refunded"] || [indentStatus isEqualToString:@"indent_status_completed"] || [indentStatus isEqualToString:@"indent_status_canceled"] || [indentStatus isEqualToString:@"indent_status_in_group"]) {
        //  售后待退款
        return 55;
    }
    return 100;
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
        cell.indentStatus = dataModel.indentStatus;
        NSMutableArray *indentInfoArr =dataModel.indentInfo;
        
        DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:indentInfoArr[indexPath.row]];
        //        NSString *priceS=[NSString stringWithFormat:@"¥%@" ,detailModel.price];
        //        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
        //        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        //        detailModel.priceAtribute = AttributedStr;
        
        cell.detailModel = detailModel;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailController *detailVC=[[OrderDetailController alloc]init];
    detailVC.detailBlock = ^{
        [self refreshTableViewData];
    };
    
    detailVC.detailBlockResult = ^(KDSOrderDetailType type, KDSProductType productType, NSInteger indx) {
        switch (type) {
            case KDSOrderDetail_pay:{//支付完成
                dataPage = 1;
                [self loadData:refreshData];
            }
                break;
                
            case KDSOrderDetail_waitInstall:{//确认安装
                dataPage = 1;
                [self loadData:refreshData];
            }
                break;
            default:
                break;
        }
    };
    
    DetailModel *model = self.dataArray[indexPath.section];
    detailVC.detailmodel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


-(void)loadData:(LoadState)loadState{
    [super loadData:loadState];
    
//    NSDictionary *dic1=@{@"indentType":@"",@"indentStatus":statusArr[self.selectIndex]};
     NSDictionary *dic1=@{@"indentType":[KDSMallTool checkISNull:_dict[@"key"]],@"indentStatus":@""};
    NSDictionary *dic = @{ @"page":@{@"pageNum":[NSNumber numberWithInt:dataPage],@"pageSize":@"10"} ,@"params":dic1,@"token":ACCESSTOKEN};
    [self loadDataWithBlock:loadState url:@"indent/myIndentSearch" partemer:dic Success:^(id responseObject) {
        if ([self isSuccessData:responseObject]) {
            NSLog(@"请求成功返回数据=%@" ,responseObject);
            NSMutableArray * dataArray = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *modelarr = [NSMutableArray array];
            for (NSDictionary *datadic in dataArray) {
                
                DetailModel *detailModel = [[DetailModel alloc]initWithDictionary:datadic];
                
                NSString *priceS = [NSString stringWithFormat:@"%@" ,[KDSMallTool checkISNull:datadic[@"realPay"]]];
                NSString *showS =[NSString stringWithFormat:@"共%@件商品,需付款:  ¥%@",@"1",priceS] ;
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showS];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange((showS.length-priceS.length), priceS.length)];
                detailModel.footAtribute =AttributedStr;
                
                [modelarr addObject:detailModel];
            }
            if (dataPage == 1) {
                [self.dataArray removeAllObjects];
                [self.tableView.mj_footer resetNoMoreData];
            }
            [self.dataArray addObjectsFromArray:modelarr];
            NSInteger total = [[[responseObject objectForKey:@"data"] objectForKey:@"total"] integerValue];
            NSLog(@"totaltotal=%ld" ,(long)total);
            NSLog(@"count=%lu" ,(unsigned long)self.dataArray.count);
            if (total<=self.dataArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
            NSLog(@"总数量=%lu" ,(unsigned long)self.dataArray.count);
        }
        
    }];
    
}


-(void)orderListRightButtonClick:(NSIndexPath *)indexPath buttonType:(OrderListButtonType)buttonType{
    DetailModel *dataModel =self.dataArray[indexPath.section];
    NSMutableArray *indentInfoArr =dataModel.indentInfo;
    __weak typeof(self)weakSelf = self;
    switch (buttonType) {
        case OrderListButton_afterSales:{//申请售后
            RepairController *repairVc= [[RepairController alloc]init];
            repairVc.idStr =dataModel.myId;
            NSDictionary * adic = indentInfoArr[indexPath.row];
            repairVc.dataDic = adic;
            repairVc.indentId =[NSString stringWithFormat:@"%@" ,adic[@"id"]];
            [self.navigationController pushViewController:repairVc animated:YES];
        }
            break;
        case OrderListButton_refund:{//申请退款
            if ([dataModel.installStatus isEqualToString:@"indent_install_status_confirm"] || [dataModel.installStatus isEqualToString:@"indent_install_status_shop"]) {
                [KDSProgressHUD showFailure:@"商家已经与您预约安装好时间，如需退款请联系客服！" toView:weakSelf.view completion:^{}];
                return;
            }
            NSLog(@"申请退款");
            KDSApplyRefundController * applyRefundVC = [[KDSApplyRefundController alloc]init];
            applyRefundVC.idStr = dataModel.myId;
            NSDictionary * adic = indentInfoArr[indexPath.row];
            applyRefundVC.infoDict = adic;
            applyRefundVC.indentId = [NSString stringWithFormat:@"%@",adic[@"id"]];
            applyRefundVC.applyRefundSuccessBlock = ^{
                dataPage = 1;
                [weakSelf loadData:refreshData];
            };
            [self.navigationController pushViewController:applyRefundVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 状态按钮
-(void)btnClick:(UIButton *)sender{
    
    NSLog(@"text=%@" ,sender.titleLabel.text);
    NSLog(@"idString=%@" ,sender.idString);
    NSLog(@"indentInfoArr=%@" ,sender.indentInfoArr);
    
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        ComentController *comentVC=[[ComentController alloc]init];
        comentVC.indeInfoArr = sender.indentInfoArr;
        comentVC.comentBlock = ^{
            [self refreshTableViewData];
        };
        [self.navigationController pushViewController:comentVC animated:YES];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        [self cancelOrder:sender.idString];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"申请售后"]) {
        RepairController *repairVc= [[RepairController alloc]init];
        repairVc.idStr =sender.idString;
        NSDictionary *adic =sender.indentInfoArr[0];
        repairVc.indentId =[NSString stringWithFormat:@"%@" ,adic[@"id"]];
        [self.navigationController pushViewController:repairVc animated:YES];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"立即支付"]) {
        DetailModel *dataModel =self.dataArray[sender.tag];
        NSLog(@"realPay=%@" ,dataModel.realPay);
        
        [KDSPayController showPay:dataModel.realPay orderNo:dataModel.orderNo payResult:^(PayResultCodeType recustCode) {
            switch (recustCode) {
                case PayResultCodeType_success:{//成功
                    dataPage = 1;
                    [self loadData:refreshData];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                }
                    break;
                    
                case PayResultCodeType_fail:{//失败
                    
                }
                    break;
                    
                default:
                    break;
            }
        } cancelButtonClick:^{
            
        }];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"确认安装"]) {
        [KDSMallAC alertControllerWithTitle:@"提示" message:@"您已经确认安装成功？" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
            NSString *indentId = @"-1";
            if (sender.indentInfoArr.count > 0) {
                NSDictionary * dict = [sender.indentInfoArr firstObject];
                indentId  = dict[@"indentId"];
            }
            NSLog(@"%@",indentId);
            [self affirmInstallation:indentId senderTag:sender.tag];
        } cancelBlock:^{
            
        }];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"删除订单"]) {
        [KDSMallAC alertControllerWithTitle:@"提示" message:@"确定删除订单" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *indentId = @"-1";
                if (sender.indentInfoArr.count > 0) {
                    NSDictionary * dict = [sender.indentInfoArr firstObject];
                    indentId  = dict[@"indentId"];
                    
                }
                NSLog(@"%@",indentId);
                [self deleteOrder:indentId senderTag:sender.tag];
                
            });
        } cancelBlock:^{
            
        }];
    }
    
}

#pragma mark - 删除订单
-(void)deleteOrder:(NSString *)indentId senderTag:(NSInteger)tag{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictParams = @{@"params": @{ @"id": indentId},             //（必填）（int）订单Id
                                  @"token":[KDSMallTool checkISNull:userToken]    //（必填）（str）
                                  };
    [self submitDataWithBlock:@"indent/delete" partemer:dictParams Success:^(id responseObject) {
        if ([self isSuccessData:responseObject]) {
            [self.dataArray removeObjectAtIndex:tag];
            
            [self.tableView reloadData];
            
        }else{
            [KDSProgressHUD showFailure:@"未知错误" toView:self.view completion:^{}];
        }
    }];
}


#pragma mark - 确认安装
-(void)affirmInstallation:(NSString *)indentId senderTag:(NSInteger)tag{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictParams = @{@"params": @{ @"id": indentId},           //（必填）（int）订单Id
                                  @"token": [KDSMallTool checkISNull:userToken] //（必填）（str）
                                  };
    [self submitDataWithBlock:@"indent/affirm" partemer:dictParams Success:^(id responseObject) {
        NSLog(@"确认安装:%@",responseObject);
        if ([self isSuccessData:responseObject]) {
            dataPage = 1;
            [self loadData:refreshData];
        }else{
//            [KDSProgressHUD showHUDTitle:@"未知错误" toView:self.view];
            [KDSProgressHUD showFailure:@"未知错误" toView:self.view completion:^{
                
            }];
        }
    }];
}

#pragma mark  取消订单
-(void)cancelOrder:(NSString *)orderID{
    [KDSMallAC alertControllerWithTitle:@"提示" message:@"是否取消订单?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
        NSDictionary *dic1=@{@"id":orderID};
        NSDictionary *dic = @{@"params":dic1,@"token":ACCESSTOKEN};
        [self submitDataWithBlock:@"indent/cancel" partemer:dic Success:^(id responseObject) {
            if ([self isSuccessData:responseObject]) {
                [KDSProgressHUD showSuccess:@"订单取消成功" toView:self.view completion:^{
                }];
                [self refreshTableViewData];
            }
        }];
    } cancelBlock:^{
    }];
}



@end
