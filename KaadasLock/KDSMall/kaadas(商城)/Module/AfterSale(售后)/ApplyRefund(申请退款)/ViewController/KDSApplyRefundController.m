//
//  KDSApplyRefundController.m
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSApplyRefundController.h"
#import "KDSRefundProductCell.h"
#import "KDSRefundMoneyCell.h"
#import "KDSRefundReasonCell.h"
#import "KDSRefundFooterView.h"
#import "KDSHomePageHttp.h"
#import "KDSAllTagModel.h"
#import "JHUIAlertView.h"
#import "UIButton+NSString.h"

@interface KDSApplyRefundController ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
     NSString         * resonKey;
     dispatch_group_t    myGroup;
}
@property (nonatomic,strong)UITableView           * tableView;
@property (nonatomic,strong)KDSRefundFooterView   * refundDetailView;
@property (nonatomic,strong)NSMutableArray        * reasonArr;
@property (nonatomic,strong)KDSAllTagModel        * tagModel;
@property (nonatomic,strong)UIScrollView          * myscrollView;
@property (nonatomic,strong)NSMutableArray        * btnArr;
@property (nonatomic,strong)NSMutableArray        * imgArr;
@property (nonatomic,strong)NSMutableArray        * idArr;
@end

@implementation KDSApplyRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
    
    [self loadReasonData];
}
-(void)loadReasonData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"token":[KDSMallTool checkISNull:userToken]};
    __weak typeof(self)weakSelf = self;
    [KDSHomePageHttp getAllAllKeyValueWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.tagModel = (KDSAllTagModel *)obj;
            self.reasonArr  = (NSMutableArray *)weakSelf.tagModel.after_sales_service;
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];

}

#pragma mark - 提交事件
-(void)submitButtonClick{
    NSLog(@"提交");
    if (resonKey.length <= 0) {
        [KDSProgressHUD showFailure:@"请选择退款原因" toView:self.view completion:^{}];
        return;
    }
    //获取需要上传的图片
    self.imgArr = (NSMutableArray *)self.refundDetailView.imageArray;
    
    if (self.imgArr.count > 0) {
        [KDSProgressHUD showHUDTitle:@"图片上传中..." toView:self.view];
        self.idArr = [NSMutableArray array];
        myGroup = dispatch_group_create();
        for (int i = 0; i < self.imgArr.count; i++) {
            UIImage * aimage = self.imgArr[i];
            dispatch_group_enter(myGroup);
            dispatch_group_async(myGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [KDSNetworkManager POSTUploadDatawithPics:aimage progress:^(NSProgress * _Nullable uploadProgress) {
                    
                } success:^(NSInteger code, id  _Nullable json) {
                    dispatch_group_leave(myGroup);
                    if (![[json objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                        NSString *imgID =[NSString stringWithFormat:@"%@",[[json objectForKey:@"data"] objectForKey:@"fileRewriteFullyQualifiedPath"]];
                        [self.idArr addObject:imgID];
                    }
                } failure:^(NSError * _Nullable error) {
                     NSLog(@"错误信息error=%@" ,error);
                }];
            });
        }
        
        dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
            NSLog(@"图片上传成功");
            NSLog(@"idArr=%@" ,self.idArr);
            [KDSProgressHUD hideHUDtoView:self.view animated:YES];
            [self sumitFeedData];
        });
    }else{
        [self sumitFeedData];
    }
    
}


#pragma mark - 提交数据
-(void)sumitFeedData{
    NSLog(@"提交请求");
    
    NSString *imgStr = [KDSMallTool checkISNull:[self.idArr componentsJoinedByString:@","]];
    NSDictionary *dic = @{@"indentId":[KDSMallTool checkISNull:self.idStr],
                          @"indentDetailId":[KDSMallTool checkISNull:self.indentId],
                          @"reasonType":[KDSMallTool checkISNull:resonKey],
                          @"reason":[KDSMallTool checkISNull:self.refundDetailView.text],
                          @"contactName":@"",
                          @"contactTel":@"",
                          @"imgs":imgStr,
                          @"type":@"returnbill_type_stauts_refund"
                          };
 
    NSDictionary * dictParam = @{@"params":dic,@"token":ACCESSTOKEN};

    __weak typeof(self)weakSelf = self;
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"returnBill/save" paramsDict:dictParam success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            if (weakSelf.applyRefundSuccessBlock) {
                weakSelf.applyRefundSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nullable error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        KDSRefundProductCell * cell = [KDSRefundProductCell refundProductCellWithTableView:tableView];
        cell.infoDict = _infoDict;
        return cell;
    }else if(indexPath.row == 1){
        KDSRefundMoneyCell * cell = [KDSRefundMoneyCell refundMoneyCellWithTableView:tableView];
        cell.priceLb.text = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_infoDict[@"price"]]];
        return cell;
    }else{
        KDSRefundReasonCell * cell = [KDSRefundReasonCell refundReasonCellWithTableView:tableView];
        return cell;
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        [self chooseReason];
    }
    
}

#pragma mark - 退款原因弹框
-(void)chooseReason{
    JHUIAlertConfig *config = [[JHUIAlertConfig alloc] init];
    config.title.text = @"退款原因";
    config.content.font = [UIFont systemFontOfSize:18];
    config.content.color =[UIColor hx_colorWithHexRGBAString:@"#333333"];
    config.title.bottomPadding = 240;
    config.dismissWhenTapOut   = NO;
    JHUIAlertButtonConfig *btnconfig1= [JHUIAlertButtonConfig configWithTitle:@"确定"color:[UIColor hx_colorWithHexRGBAString:@"#333333"] font:nil image:nil handle:^{
        NSLog(@"确定");
        [self sureAction];
    }];
    config.buttons = @[btnconfig1];
    JHUIAlertView *alertView = [[JHUIAlertView alloc] initWithConfig:config];
    [alertView addCustomView:^(JHUIAlertView *alertView, CGRect contentViewRect, CGRect titleLabelRect, CGRect contentLabelRect) {
        
        UILabel *topL= [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabelRect)+8, contentViewRect.size.width, 0.3)];
        topL.backgroundColor = [[UIColor hx_colorWithHexRGBAString:@"#666666"] colorWithAlphaComponent:0.8];
        [alertView.contentView addSubview:topL];
        
        self.myscrollView = [[UIScrollView alloc] init];
        self.myscrollView.frame = CGRectMake(0, CGRectGetMaxY(titleLabelRect)+10, contentViewRect.size.width, contentViewRect.size.height-85);
        self.myscrollView.showsVerticalScrollIndicator = NO;
        self.myscrollView.showsHorizontalScrollIndicator = NO;
        [alertView.contentView  addSubview:self.myscrollView ];
        
        for (int i =0; i <self.reasonArr.count; i ++) {
            NSString *text = [self.reasonArr[i] objectForKey:@"value"];
            NSString *idstr = [self.reasonArr[i] objectForKey:@"key"];
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(15, 1+49*i, self.myscrollView.frame.size.width-65, 49);
            label.text =text;
            label.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentLeft;
            [self.myscrollView addSubview:label];
            
            UILabel *line= [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame), self.myscrollView.frame.size.width-30, 1)];
            line.backgroundColor = KViewBackGroundColor;
            [self.myscrollView addSubview:line];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"产品选中"] forState:UIControlStateSelected];
            button.frame = CGRectMake(self.myscrollView.frame.size.width-50, 49*i, 50, 49);
            [button addTarget:self action:@selector(reasonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.idString = idstr;
            [button setTitle:text forState:UIControlStateNormal];
            [self.myscrollView addSubview:button];
            [self.btnArr addObject:button];
            
            if (resonKey) {
                if ([button.idString isEqualToString:resonKey]) {
                    button.selected = YES;
                }
            }
        }
        self.myscrollView .contentSize = CGSizeMake(contentViewRect.size.width-20 , 50*self.reasonArr.count);
        
    }];
    UIWindow *KeyWindow = [[UIApplication sharedApplication] keyWindow];
    [KeyWindow addSubview:alertView];
}

-(void)reasonAction:(UIButton *)sender{
    for (UIButton *btn in self.btnArr) {
        if ([btn isEqual:sender]) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    resonKey = sender.idString;
}
-(void)sureAction{

    for (UIButton *btn in self.btnArr) {
        if (btn.selected) {
            NSLog(@"text=%@" ,btn.titleLabel.text);
            KDSRefundReasonCell * cell = (KDSRefundReasonCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.desString = btn.titleLabel.text;
        }
    }
    NSLog(@"resonKey=%@" ,resonKey);
    
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"申请退款";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
    
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
    self.navigationBarView.rightItem = submitButton;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F7F7F7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.refundDetailView;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return _tableView;
}

-(KDSRefundFooterView *)refundDetailView{
    if (_refundDetailView == nil) {
        _refundDetailView = [[KDSRefundFooterView alloc]init];
        _refundDetailView.frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH / 4 * 3);
        
    }
    return _refundDetailView;
}

-(NSMutableArray *)reasonArr{
    if (_reasonArr == nil) {
        _reasonArr = [NSMutableArray array];
    }
    
    return _reasonArr;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr  =[NSMutableArray array];
    }
    return _btnArr;
}
- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr  =[NSMutableArray array];
    }
    return _imgArr;
}
@end
