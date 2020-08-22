
//
//  AfterDetailController.m
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "AfterDetailController.h"
#import "OrderListCell.h"
#import "TotallCell.h"
#import "UIButton+NSString.h"
#import "CustomBtn.h"
#import "ReasonCell.h"
@interface AfterDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *reason;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArrR;
@property(nonatomic , strong) NSMutableArray *modelArr;
@property(nonatomic , strong) NSMutableArray *imgArr;


@end

@implementation AfterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBarView.backTitle = @"售后详情";
    self.loadingViewFrame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH);
    [self addTableView];
    
    
    if ([_detailmodel.status isEqualToString:@"indent_info_status_after_underway"] || [_detailmodel.status isEqualToString:@"indent_info_status_after_complete"]) {
        self.navigationBarView.backTitle = @"售后详情";
    }else if([_detailmodel.status isEqualToString:@"indent_info_status_refund_of"] || [_detailmodel.status isEqualToString:@"indent_info_status_refund_to_complete"]){
        self.navigationBarView.backTitle = @"退款详情";
    }
}

-(NSMutableArray *)modelArr{
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

-(NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}


- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _tableView.estimatedRowHeight = 115;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.modelArr.count;
    }
    if (section == 1) {
        return self.dataArrR.count;
    }
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString * identy = @"head";
    UITableViewHeaderFooterView * headV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!headV) {
        NSLog(@"section=%li",section);
        headV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 15)];
        view.backgroundColor = KViewBackGroundColor;
        [headV addSubview:view];
    }
    
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    static NSString * identy = @"foot";
    UITableViewHeaderFooterView * footV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!footV) {
        NSLog(@"section=%li",section);
        footV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 15)];
        view.backgroundColor = KViewBackGroundColor;
        [footV addSubview:view];
    }
    
    return footV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"产品列表";
        OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell == nil) {
            cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.detailModel = self.modelArr[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"原因";
        ReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell == nil) {
            cell = [[ReasonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.resonLab.text = reason;
        for (int i = 0; i < 3; i ++) {
            UIImageView *img = [cell viewWithTag:1000+i];
            if (self.imgArr.count > i) {
                img.hidden = NO;
                [img sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            }else{
                img.hidden = YES;
            }
           
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"故障描述";
    TotallCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TotallCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray * arrl= nil;
    if ([_detailmodel.status isEqualToString:@"indent_info_status_refund_of"] || [_detailmodel.status isEqualToString:@"indent_info_status_refund_to_complete"]) {
        arrl= @[@"申请时间",@"售后原因"];
    }else{
        arrl= @[@"申请时间",@"售后原因",@"联系人",@"联系电话"];
    }
    
    cell.leftLab.text = arrl[indexPath.row];
    cell.rightField.textAlignment =NSTextAlignmentLeft;
    cell.rightField.text = self.dataArrR[indexPath.row];
    
    return cell;
}


-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top. mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view).mas_offset(-MhomeBarH);
    }];
}
-(void)addTableHead:(NSString *)status timeStr:(NSString *)timeStr{
    UIView *ahead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
    ahead.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#78BEF7"];
    self.tableView.tableHeaderView = ahead;
    
    
    if ([status isEqualToString:@"indent_info_status_after_underway"]) {//售后处理中
        UILabel *dealIngLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
        dealIngLab.text = @"售后处理中";
        dealIngLab.textColor = [UIColor whiteColor];
        dealIngLab.textAlignment = NSTextAlignmentCenter;
        dealIngLab.font = [UIFont systemFontOfSize:21];
        [ahead addSubview:dealIngLab];
    }else if ([status isEqualToString:@"indent_info_status_refund_of"]){
        UILabel *dealIngLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 50)];
        dealIngLab.text = @"退款中";
        dealIngLab.textColor = [UIColor whiteColor];
        dealIngLab.textAlignment = NSTextAlignmentCenter;
        dealIngLab.font = [UIFont systemFontOfSize:21];
        [ahead addSubview:dealIngLab];
    }else{
        
        UILabel *compLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, KSCREENWIDTH, 50)];
        compLab.text = @"已完成";
        compLab.textColor = [UIColor whiteColor];
        compLab.textAlignment = NSTextAlignmentLeft;
        compLab.font = [UIFont systemFontOfSize:21];
        [ahead addSubview:compLab];
        
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH-15, 50)];
        if (![timeStr isEqualToString:@"(null)"]) {
            timeLab.text = timeStr;
        }
        
        timeLab.textColor = [UIColor whiteColor];
        timeLab.textAlignment = NSTextAlignmentRight;
        timeLab.font = [UIFont systemFontOfSize:15];
        [ahead addSubview:timeLab];
        ahead.backgroundColor =[UIColor hx_colorWithHexRGBAString:@"#999999"];
        
    }
    
}
-(void)addTableFootReason:(NSString *)resonstr atime:(NSString*)timestr{
    
//    NSString *text =@"大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发大撒打发";
//    CGFloat ah = [KDSMallTool getNSStringHeight:text textMaxWith:KSCREENWIDTH-30-15-25 font:15];
    UIView *afoot= [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 300)];
    afoot.backgroundColor =[UIColor whiteColor];
    self.tableView.tableFooterView = afoot;
    
    UILabel *labt=[[UILabel alloc]init];
    labt.font =[UIFont systemFontOfSize:15];
    labt.text = @"处理反馈";
    labt.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    labt.textAlignment =NSTextAlignmentLeft;
    [afoot addSubview:labt];
    [labt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    UILabel *feedLab=[[UILabel alloc]init];
    feedLab.font =[UIFont systemFontOfSize:15];
    feedLab.text = resonstr;
    feedLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    feedLab.textAlignment =NSTextAlignmentLeft;
    feedLab.numberOfLines = 0;
    [afoot addSubview:feedLab];
    [feedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(125);
        make.right.mas_equalTo(-22);
    }];
    
    UILabel *timelab=[[UILabel alloc]init];
    timelab.font =[UIFont systemFontOfSize:15];
    timelab.text =timestr;
    timelab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    timelab.textAlignment =NSTextAlignmentLeft;
    [afoot addSubview:timelab];
    [timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(feedLab.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(125);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    UILabel *timeL=[[UILabel alloc]init];
    timeL.font =[UIFont systemFontOfSize:15];
    timeL.text = @"处理时间";
    timeL.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    timeL.textAlignment =NSTextAlignmentLeft;
    [afoot addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(feedLab.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    NSLog(@"yyy1===%f" ,timelab.frame.origin.y);
    [afoot layoutIfNeeded];
    NSLog(@"yyy2===%f" ,timelab.frame.origin.y);
    NSLog(@"yyy3===%f" ,CGRectGetMaxY(timelab.frame));
    
    afoot.frame =CGRectMake(0, 0, KSCREENWIDTH, CGRectGetMaxY(timelab.frame)+15);
    
}

-(void)loadData:(LoadState)loadState{
    [super loadData:loadState];
//    NSDictionary *dic1=@{@"id":[NSString stringWithFormat:@"%@" ,self.detailmodel.myId]};
     NSDictionary *dic1=@{@"id":[NSString stringWithFormat:@"%@" ,self.detailmodel.indentDetailId]};
    NSDictionary *dic = @{@"params":dic1,@"token":ACCESSTOKEN};
    [self loadDataWithBlock:loadState url:@"returnBill/get" partemer:dic Success:^(id responseObject) {
        if ([self isSuccessData:responseObject]) {
            NSLog(@"请求成功返回数据=%@" ,responseObject);
            NSMutableArray * modelarr = [[responseObject objectForKey:@"data"] objectForKey:@"tbIndentInfo"];
            for (NSDictionary *datadic in modelarr) {
                DetailModel *detailModel = [[DetailModel alloc]initWithDictionary:datadic];
                [self.modelArr addObject:detailModel];
            }
            
            reason= [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"reason"]];
            
            
            //            NSString *statusCN=[NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"statusCN"]];
            NSString *status=[NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"status"]];
            
            NSString *createDate = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"createDate"]];
            NSString *reasonTypeCN = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"reasonTypeCN"]];
            NSString *contactName = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"contactName"]];
            NSString *contactTel = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"contactTel"]];
            NSString *approveDate = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"approveDate"]];//处理时间
            NSString *approveResult = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"approveResult"]];//处理结果
            
             [self.tableView reloadData];
            
            if ([_detailmodel.status isEqualToString:@"indent_info_status_refund_of"] || [_detailmodel.status isEqualToString:@"indent_info_status_refund_to_complete"]) {
                self.dataArrR = [NSMutableArray arrayWithObjects:createDate,reasonTypeCN, nil];
            }else{
                self.dataArrR = [NSMutableArray arrayWithObjects:createDate,reasonTypeCN,contactName,contactTel, nil];
            }
            
            NSString *imgs =[KDSMallTool checkISNull:[NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"imgs"]]];
            if (imgs.length >0) {
                self.imgArr =[NSMutableArray arrayWithArray:[imgs componentsSeparatedByString:@","]];
            }
            
            
            [self addTableHead:status timeStr:approveDate];
            if ([status isEqualToString:@"indent_info_status_after_complete"] || [status isEqualToString:@"indent_info_status_refund_to_complete"]) {
                [self addTableFootReason:approveResult atime:approveDate];
            }
            
            [self.tableView reloadData];
            
        }
        
    }];
}

@end
