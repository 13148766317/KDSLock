//
//  OrderDetailController.m
//  kaadas
//
//  Created by Apple on 2019/5/17.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderListCell.h"
#import "DefaultAdrCell.h"
#import "UIButton+NSString.h"
#import "CustomBtn.h"
#import "RepairController.h"
#import "RepairController.h"
#import "AddressController.h"
#import "RepairController.h"
#import "ComentController.h"
#import "KDSPayController.h"
#import "KDSApplyRefundController.h"

@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource,OrderListCellDelegate>{
    
    NSString * totalPrice ;
    NSString * realPay ;
    NSString * indentStatusCN;
    NSString * indentType;
    NSString * orderNo;
    NSString * indentStatus;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *dataArrR;
@property (nonatomic, strong) NSMutableArray *priceArr;

@end

@implementation OrderDetailController
-(NSMutableArray *)addressArray{
    if (_addressArray == nil) {
        _addressArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backTitle = @"订单详情";
    [self addTableView];
    [self addTableHead];
    self.loadingViewFrame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH);
    
}


- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.estimatedRowHeight = 115;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    NSMutableArray *indentInfoArr =self.detailmodel.indentInfo;
    return indentInfoArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        static NSString * identy0 = @"head0";
        UITableViewHeaderFooterView * headV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy0];
        if (!headV) {
            headV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy0];
            UIView *view =[[UIView alloc]initWithFrame:CGRectZero];
            view.backgroundColor =KViewBackGroundColor;
            [headV addSubview:view];
        }
        return headV;
    }
    
    static NSString * identy = @"head";
    UITableViewHeaderFooterView * headV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!headV) {
        NSLog(@"section=%li",section);
        headV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        [headV addSubview:view];
        
        UIButton *btn = [[CustomBtn alloc]initWithBtnFrame:CGRectMake(0,0, 140, 50) btnType:ButtonImageLeft titleAndImageSpace:10 imageSizeWidth:15 imageSizeHeight:17];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setImage:[UIImage imageNamed:@"icon_order"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitle:@"凯迪仕商城" forState:UIControlStateNormal];
        [view addSubview: btn];
    }
    
    return headV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        static NSString * identy0 = @"foot0";
        UITableViewHeaderFooterView * FootV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy0];
        if (!FootV) {
            FootV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy0];
            UIView *view =[[UIView alloc]initWithFrame:CGRectZero];
            view.backgroundColor =KViewBackGroundColor;
            [FootV addSubview:view];
        }
        return FootV;
    }
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 180+15+190+15-35)];
    view.tag = 5000+section;
    view.backgroundColor =[UIColor whiteColor];
    NSArray *arrl = nil;
    if (self.priceArr.count > 1) {
        arrl=@[@"商品金额",@"现金券"];
    }else{
        arrl=@[@"商品金额"];
    }
    for (int i = 0; i < arrl.count; i ++) {
        UILabel *lal =[[UILabel alloc]init];
        lal.frame = CGRectMake(15, 28+15*i+20*i, 180, 15);
        lal.textAlignment = NSTextAlignmentLeft;
        lal.font = [UIFont systemFontOfSize:15];
        lal.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        lal.text = arrl[i];
        [view addSubview:lal];
        
        UILabel *lar =[[UILabel alloc]init];
        lar.frame = CGRectMake(KSCREENWIDTH-180-15, 28+15*i+20*i, 180, 15);
        lar.textAlignment = NSTextAlignmentRight;
        lar.font = [UIFont systemFontOfSize:15];
        lar.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        [view addSubview:lar];
        if (self.priceArr.count > 0) {
            NSString *priceS = [NSString stringWithFormat:@"%@" ,self.priceArr[i]];
            NSString *showS =[NSString stringWithFormat:@"¥%@",priceS] ;
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showS];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
            lar.attributedText =AttributedStr;
        }
        if ( i == 1) {
            NSString * couponPrice = [NSString stringWithFormat:@"￥%@", self.priceArr[i]];
            NSMutableAttributedString * couponAtt = [[NSMutableAttributedString alloc]initWithString:couponPrice];
            [couponAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
            lar.attributedText = couponAtt;
        }
    }
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 130-35, KSCREENWIDTH, 0.6)];
    line.backgroundColor = KseparatorColor;
    [view addSubview:line];
    
    UILabel *labm =[[UILabel alloc]init];
    labm.frame = CGRectMake(15, 130+18-35, 180, 15);
    labm.textAlignment = NSTextAlignmentLeft;
    labm.font = [UIFont systemFontOfSize:15];
    labm.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    labm.text = @"实付款";
    [view addSubview:labm];
    
    UILabel *labM =[[UILabel alloc]init];
    labM.frame = CGRectMake(KSCREENWIDTH-180-15, 130+18-35, 180, 15);
    labM.textAlignment = NSTextAlignmentRight;
    labM.font = [UIFont systemFontOfSize:15];
    labM.textColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
    [view addSubview:labM];
    NSString *realShow=[NSString stringWithFormat:@"¥%@",realPay] ;
    NSMutableAttributedString *AttributedStrM= [[NSMutableAttributedString alloc]initWithString:realShow];
    [AttributedStrM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    labM.attributedText =AttributedStrM;
    
    NSArray *dataArrL = nil;
    if ([indentStatus isEqualToString:@"indent_status_wait_pay"] || [indentStatus isEqualToString:@"indent_status_canceled"] ) {
        if (self.dataArrR.count >=5 ) {
            dataArrL=@[@"订单编号",@"下单时间",@"支付方式",@"期待安装时间"];
        }else{
            dataArrL=@[@"订单编号",@"下单时间",@"期待安装时间"];
        }
    }else{
        if (self.dataArrR.count >=5 ) {
            dataArrL=@[@"订单编号",@"下单时间",@"支付方式",@"付款时间",@"期待安装时间"];
        }else{
            dataArrL=@[@"订单编号",@"下单时间",@"付款时间",@"期待安装时间"];
        }
    }
    
    
    
    //        NSArray *dataArrR=@[@"123321123321",@"2019-09-09 13:21:33",@"在线支付",@"2019-09-09 13:21:33",@"2019-09-09 13:21:33"];//详情数据
    for (int i = 0; i < dataArrL.count; i ++) {
        UILabel *lal =[[UILabel alloc]init];
        lal.frame = CGRectMake(15, 195+28+12*i+20*i-35, 220, 12);
        lal.textAlignment = NSTextAlignmentLeft;
        lal.font = [UIFont systemFontOfSize:15];
        lal.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        lal.text = dataArrL[i];
        [view addSubview:lal];
        
        UILabel *lar =[[UILabel alloc]init];
        lar.frame = CGRectMake(112, 195+28+12*i+20*i-35, 300, 12);
        lar.textAlignment = NSTextAlignmentLeft;
        lar.font = [UIFont systemFontOfSize:12];
        lar.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        if (self.dataArrR.count > 0) {
            lar.text = self.dataArrR[i];
        }
        [view addSubview:lar];
    }
    
    UILabel *linet = [[UILabel alloc]initWithFrame:CGRectMake(0, 180-35, KSCREENWIDTH, 15)];
    linet.backgroundColor = KViewBackGroundColor;
    [view addSubview:linet];
    UILabel *lineb = [[UILabel alloc]initWithFrame:CGRectMake(0, 180+15+190-35, KSCREENWIDTH, 15)];
    lineb.backgroundColor = KViewBackGroundColor;
    [view addSubview:lineb];
    
    return view;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 180+15+190+15-35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"地址";
        DefaultAdrCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell == nil) {
            cell = [[DefaultAdrCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imgvR.hidden = YES;
        if (self.addressArray.count > 0) {
            cell.detailModel = self.addressArray[indexPath.row];
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"产品列表";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell == nil) {
        cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    NSMutableArray *indentInfoArr =self.detailmodel.indentInfo;
    DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:indentInfoArr[indexPath.row]];
    cell.indentStatus = self.detailmodel.indentStatus;
    cell.indentType   = self.detailmodel.indentType;
    
    //    NSString *priceS=[NSString stringWithFormat:@"¥%@" ,detailModel.price];
    //    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
    //    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    //    detailModel.priceAtribute = AttributedStr;
    
    cell.detailModel = detailModel;
    return cell;
    
}


-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top. mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view).mas_offset(-(50+MhomeBarH));
    }];
}
-(void)addTableHead{
    
    UIView *ahead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
    ahead.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
    self.tableView.tableHeaderView = ahead;
    
    UILabel *dealIngLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
    dealIngLab.textColor = [UIColor whiteColor];
    dealIngLab.textAlignment = NSTextAlignmentCenter;
    dealIngLab.font = [UIFont systemFontOfSize:21];
    dealIngLab.tag = 1000;
    [ahead addSubview:dealIngLab];
    
}


-(void)addBottomBtn:(NSArray *)typeArr{
    
    CGFloat aw = KSCREENWIDTH/typeArr.count;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < typeArr.count; i ++) {
        UIButton *Btn= [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame = CGRectMake(aw*i, CGRectGetMaxY(self.view.frame)-50-MhomeBarH, aw, 50);
        [Btn setTitle:typeArr[i] forState:UIControlStateNormal];
        Btn.backgroundColor = [UIColor whiteColor];
        [Btn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [Btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Btn];
        [arr addObject:Btn];
        
        if (i == typeArr.count -1) {
            Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
            [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

-(void)loadData:(LoadState)loadState{
    [super loadData:loadState];
    self.dataArrR = [NSMutableArray array];
    NSDictionary *dic1=@{@"id":[NSString stringWithFormat:@"%@" ,self.detailmodel.myId]};
    NSDictionary *dic = @{@"params":dic1,@"token":ACCESSTOKEN};
    [self loadDataWithBlock:loadState url:@"indent/details" partemer:dic Success:^(id responseObject) {
        if ([self isSuccessData:responseObject]) {
            NSLog(@"订单详情数据=%@" ,responseObject);
            totalPrice = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"totalPrice"]];//商品总金额
            realPay = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"realPay"]];//实付款
            indentStatus = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"indentStatus"]];//订单状态
            indentStatusCN = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"indentStatusCN"]];//订单状态显示
            
            indentType = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:[[responseObject objectForKey:@"data"] objectForKey:@"indentType"]]];
            NSString *couponPrice = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"couponPrice"]];//优惠券
            
            orderNo = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"orderNo"]];
            NSString *createDate = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"createDate"]];
            NSString *payType =  [KDSMallTool checkISNull:[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"payType"]]];
            NSString *payTime = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"payDate"]];;
            NSString *installationDate = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"installationDate"]];
            
            if ([indentStatus isEqualToString:@"indent_status_wait_pay"] || [indentStatus isEqualToString:@"indent_status_canceled"]) {//待支付 已取消去掉
                if ([payType isEqualToString:@"(null)"]) {
                    self.dataArrR = [NSMutableArray arrayWithObjects:orderNo,createDate,installationDate, nil];
                }else{
                    self.dataArrR = [NSMutableArray arrayWithObjects:orderNo,createDate,payType,installationDate, nil];
                }
            }else{
                if ([payType isEqualToString:@"(null)"]) {
                    self.dataArrR = [NSMutableArray arrayWithObjects:orderNo,createDate,payTime,installationDate, nil];
                }else{
                    self.dataArrR = [NSMutableArray arrayWithObjects:orderNo,createDate,payType,payTime,installationDate, nil];
                }
            }
            
            
            
            self.priceArr = [NSMutableArray arrayWithObjects:totalPrice, nil];
            
            if (![couponPrice isEqualToString:@"(null)"]) {
                [self.priceArr addObject:couponPrice];
            }
            //            NSLog(@"self.priceArr:%@",self.priceArr);
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            DetailModel *addressModel =[[DetailModel alloc]initWithDictionary:dataDic];
            [self.addressArray addObject:addressModel];
            
            [self dealOrderStatus:indentStatus];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}
-(void)dealOrderStatus:(NSString *)indentStatus{
    UILabel *find = [self.view viewWithTag:1000];
    find.text = [indentStatusCN  stringByAppendingString:@""];
    
    if ([indentType isEqualToString:@"product_type_group"]) {
        if ([indentStatus isEqualToString:@"indent_status_in_group"]) {//拼团中
            
        }else if ([indentStatus isEqualToString:@"indent_status_wait_install"]){//拼团成功
            [self addBottomBtn:@[@"确认安装"]];
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//拼团结束
            
        }else if ([indentStatus isEqualToString:@"indent_status_wait_comment"]){//待评价
            [self addBottomBtn:@[@"评价"]];
            
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//已评价
            //            [self addBottomBtn:@[@"申请售后"]];
        }
        if ([indentStatus isEqualToString:@"indent_status_refunded"] || [indentStatus isEqualToString:@"indent_status_completed"] || [indentStatus isEqualToString:@"indent_status_canceled"] || [indentStatus isEqualToString:@"indent_status_wait_refund"] || [indentStatus isEqualToString:@"indent_status_in_group"]) {
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view).mas_offset(-(MhomeBarH));
            }];
        }
        
    }else if ([indentType isEqualToString:@"product_type_seckill"]){
        if ([indentStatus isEqualToString:@"indent_status_wait_install"]) {//待安装
            [self addBottomBtn:@[@"确认安装"]];
        }else if ([indentStatus isEqualToString:@"indent_status_wait_comment"]){//待评价
            [self addBottomBtn:@[@"评价"]];
        }else if ([indentStatus isEqualToString:@"indent_status_completed"]){//已评价
            //            [self addBottomBtn:@[@"申请售后"]];
        }
        
        if ([indentStatus isEqualToString:@"indent_status_refunded"] || [indentStatus isEqualToString:@"indent_status_completed"] || [indentStatus isEqualToString:@"indent_status_canceled"] || [indentStatus isEqualToString:@"indent_status_wait_refund"]) {
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view).mas_offset(-(MhomeBarH));
            }];
        }
        
    }else{
        if ([indentStatus isEqualToString:@"indent_status_wait_pay"]) {
            //待付款
            [self addBottomBtn:@[@"取消订单",@"立即支付"]];
        }
        if ([indentStatus isEqualToString:@"indent_status_wait_install"]) {
            //待安装
            [self addBottomBtn:@[@"确认安装"]];
        }
        if ([indentStatus isEqualToString:@"indent_status_wait_comment"]) {
            //待评论
            [self addBottomBtn:@[@"评价"]];
        }
        
        if ([indentStatus isEqualToString:@"indent_status_refunded"]) {
            //售后已退款
            //            [self addBottomBtn:@[@"删除订单"]];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view).mas_offset(-(MhomeBarH));
            }];
        }
        if ([indentStatus isEqualToString:@"indent_status_completed"]) {
            //已完成
            //            [self addBottomBtn:@[@"删除订单",@"再次购买"]];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view).mas_offset(-(MhomeBarH));
            }];
        }
        if ([indentStatus isEqualToString:@"indent_status_canceled"]) {
            //已取消
            //            [self addBottomBtn:@[@"删除订单"]];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view).mas_offset(-(MhomeBarH));
            }];
        }
        
        if ([indentStatus isEqualToString:@"indent_status_wait_refund"]) {
            // 售后待退款
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.view);
                make.top. mas_equalTo(self.navigationBarView.mas_bottom);
                make.bottom.mas_equalTo(self.view);
            }];
        }
    }
    
    if ( [indentStatus isEqualToString:@"indent_status_refunded"]||[indentStatus isEqualToString:@"indent_status_completed"]||[indentStatus isEqualToString:@"indent_status_canceled"]) {
        self.tableView.tableHeaderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
    }
    
}

#pragma mark 状态按钮
-(void)btnClick:(UIButton *)sender{
    NSLog(@"text=%@" ,sender.titleLabel.text);
    
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        ComentController *comentVC=[[ComentController alloc]init];
        comentVC.indeInfoArr = self.detailmodel.indentInfo;
        comentVC.comentBlock = ^{
            //            [self refreshTableViewData];
        };
        [self.navigationController pushViewController:comentVC animated:YES];
    }else if([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        [self cancelOrder:[NSString stringWithFormat:@"%@" ,self.detailmodel.myId]];
    }else if ([sender.titleLabel.text isEqualToString:@"申请售后"]){
        [self afterSale];
    }else if ([sender.titleLabel.text isEqualToString:@"立即支付"]){
        [self payWithRealPay:realPay orderNo:orderNo];
    }else if ([sender.titleLabel.text isEqualToString:@"确认安装"]){
        if (self.detailmodel.indentInfo.count > 0) {
            NSDictionary * dict = [self.detailmodel.indentInfo firstObject];
            NSString * indentID = [KDSMallTool checkISNull:dict[@"indentId"]];
            [self waitInstall:indentID];
        }
    }
}

#pragma mark - 确认安装
-(void)waitInstall:(NSString *)indentId{
    
    __weak typeof(self)weakSelf = self;
    [KDSMallAC alertControllerWithTitle:@"提示" message:@"您已经确认安装成功？" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            NSDictionary * dictParams = @{@"params": @{ @"id": indentId},  //（必填）（int）订单Id
                                          @"token": [KDSMallTool checkISNull:userToken]             //（必填）（str）
                                          };
            
            [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
            [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"indent/affirm" paramsDict:dictParams success:^(NSInteger code, id  _Nullable json) {
                [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
                if (code == 1) {
                    [KDSProgressHUD showSuccess:@"确认安装成功" toView:self.view completion:^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        if (weakSelf.detailBlockResult) {
                            KDSProductType  productType = -1;
                            if ([indentType isEqualToString:@"indent_type_base"]) {//普通
                                productType = KDSProduct_noraml;
                            }else if([indentType isEqualToString:@"product_type_group"]){//团购
                                productType = KDSProduct_group;
                            }else if ([indentType isEqualToString:@"product_type_bargain"]){//砍价
                                productType = KDSProduct_bargain;
                            }else if ([indentType isEqualToString:@"product_type_seckill"]){//秒杀
                                productType = KDSProduct_seckill;
                            }
                            weakSelf.detailBlockResult(KDSOrderDetail_waitInstall,productType,_index);
                        }
                    }];
                    
                }else{
                    [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
                }
            } failure:^(NSError * _Nullable error) {
                [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
                [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
            }];
        });
    } cancelBlock:^{
        
    }];
    
}

#pragma mark - 立即支付
-(void)payWithRealPay:(NSString *)realPay orderNo:(NSString *)orderNo{
    __weak typeof(self)weakSelf = self;
    
    [KDSPayController showPay:realPay orderNo:orderNo payResult:^(PayResultCodeType recustCode) {
        switch (recustCode) {
            case PayResultCodeType_success:{
                [weakSelf.navigationController popViewControllerAnimated:YES];
                if (weakSelf.detailBlockResult) {
                    KDSProductType  productType = -1;
                    if ([indentType isEqualToString:@"indent_type_base"]) {//普通
                        productType = KDSProduct_noraml;
                    }else if([indentType isEqualToString:@"product_type_group"]){//团购
                        productType = KDSProduct_group;
                    }else if ([indentType isEqualToString:@"product_type_bargain"]){//砍价
                        productType = KDSProduct_bargain;
                    }else if ([indentType isEqualToString:@"product_type_seckill"]){//秒杀
                        productType = KDSProduct_seckill;
                    }
                    weakSelf.detailBlockResult(KDSOrderDetail_pay,productType,_index);
                }
            }
                
                break;
            case PayResultCodeType_fail:{
                
            }
                break;
                
            default:
                break;
        }
    } cancelButtonClick:^{
        
    }];
    
}

#pragma mark  取消订单
-(void)cancelOrder:(NSString *)orderID{
    
    __weak typeof(self)weakSelf = self;
    [KDSMallAC alertControllerWithTitle:@"提示" message:@"是否取消订单?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
        NSDictionary *dic1=@{@"id":[NSString stringWithFormat:@"%@" ,self.detailmodel.myId]};
        NSDictionary *dic = @{@"params":dic1,@"token":ACCESSTOKEN};
        [weakSelf submitDataWithBlock:@"indent/cancel" partemer:dic Success:^(id responseObject) {
            if ([weakSelf isSuccessData:responseObject]) {
                if (weakSelf.detailBlock) {
                    weakSelf.detailBlock();
                }
                if (weakSelf.detailBlockResult) {
                    KDSProductType  productType = -1;
                    if ([indentType isEqualToString:@"indent_type_base"]) {//普通
                        productType = KDSProduct_noraml;
                    }else if([indentType isEqualToString:@"product_type_group"]){//团购
                        productType = KDSProduct_group;
                    }else if ([indentType isEqualToString:@"product_type_bargain"]){//砍价
                        productType = KDSProduct_bargain;
                    }else if ([indentType isEqualToString:@"product_type_seckill"]){//秒杀
                        productType = KDSProduct_seckill;
                    }
                    weakSelf.detailBlockResult(KDSOrderDetail_cancel,productType,_index);
                }
                [KDSProgressHUD showSuccess:@"订单取消成功" toView:weakSelf.view completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    } cancelBlock:^{
    }];
    
}
#pragma mark  申请售后
-(void)afterSale{
    RepairController *repairVc= [[RepairController alloc]init];
    repairVc.idStr =[NSString stringWithFormat:@"%@" ,self.detailmodel.myId];
    NSMutableArray *InfoArr = self.detailmodel.indentInfo;
    NSDictionary *adic=InfoArr[0];
    repairVc.indentId =[NSString stringWithFormat:@"%@" ,adic[@"id"]];
    [self.navigationController pushViewController:repairVc animated:YES];
    
}


-(void)orderListRightButtonClick:(NSIndexPath *)indexPath buttonType:(OrderListButtonType)buttonType{
    
    __weak typeof(self)weakSelf = self;
    NSMutableArray *InfoArr = self.detailmodel.indentInfo;
    switch (buttonType) {
        case OrderListButton_afterSales:{//申请售后
            RepairController *repairVc= [[RepairController alloc]init];
            repairVc.idStr =[NSString stringWithFormat:@"%@" ,weakSelf.detailmodel.myId];
            
            NSDictionary *adic=InfoArr[indexPath.row];
            repairVc.indentId =[NSString stringWithFormat:@"%@" ,adic[@"id"]];
            repairVc.dataDic = adic;
            [self.navigationController pushViewController:repairVc animated:YES];
        }
            break;
            
        case OrderListButton_refund:{//申请退款
            if ([weakSelf.detailmodel.installStatus isEqualToString:@"indent_install_status_confirm"] || [weakSelf.detailmodel.installStatus isEqualToString:@"indent_install_status_shop"]) {
                [KDSProgressHUD showFailure:@"商家已经与您预约安装好时间，如需退款请联系客服！" toView:weakSelf.view completion:^{}];
                return;
            }
            
            KDSApplyRefundController * applyRefundVC = [[KDSApplyRefundController alloc]init];
            applyRefundVC.idStr = weakSelf.detailmodel.myId;
            NSDictionary * adic = InfoArr[indexPath.row];
            applyRefundVC.infoDict = adic;
            applyRefundVC.indentId = [NSString stringWithFormat:@"%@",adic[@"id"]];
            
            [self.navigationController pushViewController:applyRefundVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}

@end
