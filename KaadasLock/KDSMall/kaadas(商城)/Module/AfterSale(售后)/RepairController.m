//
//  RepairController.m
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "RepairController.h"
#import "JHUIAlertView.h"
#import "UIButton+NSString.h"
#import "CustomBtn.h"
#import "UIViewController+ImagePicker.h"
#import "OrderListController.h"
@interface RepairController (){
    UILabel *lab;
    NSString *resonKey;
    UILabel* reasonLabR;
    UITextField* peopleField;
    UITextField* telField;
    UIView *feedImgV;
    UIButton *imgBtn;
    UIView *backv;
    
    dispatch_group_t myGroup;


}
@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) NSMutableArray *reasonArr;
@property(nonatomic,strong) NSMutableArray *imgArr;
@property(nonatomic,strong)NSMutableArray *idArr;

@property(nonatomic,strong)UIScrollView *myscrollView;
@property(nonatomic,strong)UIView *contentView;


@property (nonatomic,strong)UIImageView   * productImageView;
//商品名称
@property (nonatomic,strong)UILabel       * productNameLB;
//商品类型
@property (nonatomic,strong)UILabel       * productTypeLb;
//价格
@property (nonatomic,strong)UILabel       * priceLb;
//购买个数
@property (nonatomic,strong)UILabel       * buyCountLb;

@end

@implementation RepairController

- (NSMutableArray *)reasonArr{
    if (!_reasonArr) {
        _reasonArr  =[NSMutableArray array];
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
-(void)loadReasonData{
    [JavaNetClass JavaNetRequestWithPort:@"commonApp/getAllKeyValue" andPartemer:@{@"token":ACCESSTOKEN} Success:^(id responseObject) {
        NSLog(@"responseObject=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            NSMutableArray *serviceArr = [[responseObject objectForKey:@"data"] objectForKey:@"refund_type"];
            for (NSDictionary *sDic in serviceArr) {
                [self.reasonArr addObject:sDic];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"视图加载");
    NSLog(@"idStr=%@" ,self.idStr);
    NSLog(@"indentId=%@" ,self.indentId);

    self.navigationBarView.backTitle = @"售后";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadReasonData];
    
    UIButton *  rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(btnActon) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem =rightBtn;
    
    
    self.myscrollView = [[UIScrollView alloc] init];
    self.myscrollView.frame = CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH);
    [self.view addSubview:self.myscrollView];
    
    
    self.contentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.myscrollView addSubview:self.contentView];
    
    
    UIView *topV = [[UIView alloc]init];
    [self.contentView addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 120));
    }];
    
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = KViewBackGroundColor;
    [topV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    //图片
    _productImageView = [[UIImageView alloc]init];
    _productImageView.image = [UIImage imageNamed:placeholder_wh];
    [topV addSubview:_productImageView];
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.bottom.mas_equalTo(topV.mas_bottom).mas_offset(-15).priorityLow();
    }];
    
    //商品名称
    _productNameLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
    [topV addSubview:_productNameLB];
    [_productNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productImageView.mas_right).mas_offset(20);
        make.top.mas_equalTo(self.productImageView.mas_top).mas_offset(0);
        make.right.mas_equalTo(topV.mas_right).mas_offset(-15);
    }];
    
    _productTypeLb = [KDSMallTool createLabelString:@"" textColorString:@"666666" font:12];
    [topV addSubview:_productTypeLb];
    [_productTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLB.mas_left);
        make.centerY.mas_equalTo(topV.mas_centerY);
    }];
    
    //价格
    _priceLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
    [topV addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.productNameLB.mas_left);
        make.bottom.mas_equalTo(self.productImageView.mas_bottom).mas_offset(-0);
    }];
    
    //购买个数
    _buyCountLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
    [topV addSubview:_buyCountLb];
    [_buyCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.productNameLB.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(self.priceLb.mas_bottom);
    }];
    
    
    //图片
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:self.dataDic[@"logo"]]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    //商品名称
    _productNameLB.text = [KDSMallTool checkISNull:self.dataDic[@"productName"]];
    
    _productTypeLb.text = [KDSMallTool checkISNull:self.dataDic[@"productLabels"]];
    
    //价格
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:self.dataDic[@"price"]]];
    _priceLb.attributedText = [KDSMallTool attributedString:priceStr dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
    
    //购买个数
    _buyCountLb.text = [NSString stringWithFormat:@"x%@",[KDSMallTool checkISNull:self.dataDic[@"qty"]]];

    
    UILabel* reasonLabL = [[UILabel alloc]init];
    reasonLabL.text = @"售后原因";
    reasonLabL.userInteractionEnabled = YES;
    reasonLabL.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    reasonLabL.textAlignment = NSTextAlignmentLeft;
    reasonLabL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:reasonLabL];
    [reasonLabL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(topV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-30, 50));
    }];

    UIImageView *imgv = [[UIImageView alloc]init];
    [self.contentView addSubview:imgv];
    imgv.image = [UIImage imageNamed:@"icon_list_more"];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(reasonLabL.mas_top).mas_offset(19);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
    reasonLabR = [[UILabel alloc]init];
    reasonLabR.text =@"请选择";
    reasonLabR.textAlignment = NSTextAlignmentRight;
    reasonLabR.userInteractionEnabled = YES;
    reasonLabR.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
    reasonLabR.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:reasonLabR];
    [reasonLabR addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseReason)]];
    
    [reasonLabR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgv.mas_left).mas_offset(-10);
        make.top.mas_equalTo(reasonLabL.mas_top);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-30, 50));
    }];

    UILabel *topL = [[UILabel alloc]init];
    topL.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:topL];
    [topL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(reasonLabL.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel* descLab = [[UILabel alloc]init];
    descLab.text = @"问题描述";
    descLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    descLab.textAlignment = NSTextAlignmentLeft;
    descLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(topL.mas_bottom).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    
    backv= [[UIView alloc]init];
    backv.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:backv];
    [backv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(descLab.mas_bottom).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-30, 210));
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = KViewBackGroundColor;
    self.textView.font = [UIFont systemFontOfSize:15];
    [backv addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(backv);
        make.height.mas_equalTo(210-85);
    }];
    
//
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = 1000+i;
//        [backv addSubview:btn];
//        [arr addObject:btn];
//        if (i == 0) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"icon_camera_add"] forState:UIControlStateNormal];
//        }
//    }
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:25 tailSpacing:KSCREENWIDTH-65-180-30];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(0);
//        make.height.mas_equalTo(60);
//    }];
//
    feedImgV = [[UIView alloc]init];
    [backv addSubview:feedImgV];
    [feedImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(70);
        make.left.right.mas_equalTo(0);
    }];
    
    imgBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backv addSubview:imgBtn];
    [imgBtn setBackgroundImage:[UIImage imageNamed:@"icon_camera_add"] forState:UIControlStateNormal];
    [feedImgV addSubview:imgBtn];
    imgBtn.frame = CGRectMake(15, 10, 60, 60);
    
    UILabel* peopleLabL = [[UILabel alloc]init];
    peopleLabL.text = @"联系人";
    peopleLabL.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    peopleLabL.textAlignment = NSTextAlignmentLeft;
    peopleLabL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:peopleLabL];
    [peopleLabL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(backv.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    peopleField = [[UITextField alloc]init];
    peopleField.placeholder = @"填写联系人";
    peopleField.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    peopleField.textAlignment = NSTextAlignmentLeft;
    peopleField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:peopleField];
    [peopleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(125);
        make.top.mas_equalTo(backv.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    
    UILabel *midL = [[UILabel alloc]init];
    midL.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:midL];
    [midL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(peopleLabL.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    UILabel * telLabL = [[UILabel alloc]init];
    telLabL.text = @"联系电话";
    telLabL.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    telLabL.textAlignment = NSTextAlignmentLeft;
    telLabL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:telLabL];
    [telLabL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(midL.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    
    telField = [[UITextField alloc]init];
    telField.placeholder = @"填写联系电话";
    telField.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    telField.textAlignment = NSTextAlignmentLeft;
    telField.font = [UIFont systemFontOfSize:15];
    telField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:telField];
    [telField setMaxLen:11];
    
    [telField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(125);
        make.top.mas_equalTo(midL.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    
    UILabel *botL = [[UILabel alloc]init];
    botL.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:botL];
    [botL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(telLabL.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    NSLog(@"yyy++%f" ,botL.frame.origin.y);
    [self.contentView layoutIfNeeded];
    NSLog(@"yyy===%f" ,botL.frame.origin.y);
    CGFloat totalH = botL.frame.origin.y;


    self.contentView.frame = CGRectMake(0, 0, KSCREENWIDTH, totalH);
    self.myscrollView .contentSize = CGSizeMake(KSCREENWIDTH, totalH);
    
}

//这里三个按钮进来都能点击  需要做处理
-(void)btnClick:(UIButton *)sender{
    
    [self pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
        NSLog(@"image=%@" ,image);
        [self.imgArr addObject:image];
//        [sender setBackgroundImage:image forState:UIControlStateNormal];
//        sender.userInteractionEnabled = NO;
//        if (sender.tag <1002) {
//            UIButton *btn = [self.view viewWithTag:sender.tag +1];
//            [btn setBackgroundImage:[UIImage imageNamed:@"icon_camera_add"] forState:UIControlStateNormal];
//        }
//
        [self setImgv];
        
    }];
}

-(void)setImgv{
    
    UIButton *find1 = [self.view viewWithTag:1000];
    UIButton *find2 = [self.view viewWithTag:1001];
    UIButton *find3 = [self.view viewWithTag:1002];
    [find1 removeFromSuperview];
    [find2 removeFromSuperview];
    [find3 removeFromSuperview];

    for (int i = 0; i < self.imgArr.count; i ++) {
        UIImageView *aimgv= [[UIImageView alloc]init];
        aimgv.contentMode = UIViewContentModeScaleAspectFill;
        aimgv.clipsToBounds = YES;
        aimgv.userInteractionEnabled = YES;
        aimgv.frame = CGRectMake(15+85*i, 10, 60, 60);
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        aimgv.tag = 1000+i;
        aimgv.image =self.imgArr[i];
        [feedImgV addSubview:aimgv];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(42, 0, 18, 18);
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_del_pic"] forState:UIControlStateNormal];
        btn.tag =i;
        [btn addTarget:self action:@selector(removeImg:) forControlEvents:UIControlEventTouchUpInside];
        [aimgv addSubview:btn];
    }
    
    CGFloat axx = 15+self.imgArr.count *85;;
    if (self.imgArr.count ==3) {
        axx = KSCREENWIDTH;
    }
    CGRect frame = imgBtn.frame;
    frame.origin.x= axx;
    imgBtn.frame = frame;
   
}

-(void)removeImg:(UIButton *)sender{
    [self.imgArr removeObjectAtIndex:sender.tag];
    [self setImgv];
}

-(void)chooseReason{

    JHUIAlertConfig *config = [[JHUIAlertConfig alloc] init];
    config.title.text = @"售后原因";
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
        
        
//        NSArray *arr = @[@"7天无理由退货",@"尺寸大了",@"尺寸小了",@"产品故障",@"颜色不对",@"型号不对",@"大小不对",@"质量问题",@"不想要了"];
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
            reasonLabR.text=btn.titleLabel.text;
        }
    }
    NSLog(@"resonKey=%@" ,resonKey);
    
}


-(void)btnActon{
    
    if (resonKey.length < 1) {
        [self showToastError:@"请选择售后原因"];
        return;
    }if (self.textView.text.length < 1) {
        [self showToastError:@"请填写问题描述"];
        return;
    }if (peopleField.text.length < 1) {
        [self showToastError:@"请填写联系人"];
        return;
    } if (telField.text.length < 1) {
        [self showToastError:@"请填写联系电话"];
        return;
    }if (![RegexUitl checkTelNumber:[KDSMallTool checkISNull:telField.text]]) {
        [KDSProgressHUD showFailure:phoneWrong toView:self.view completion:^{}];
        return;
    }
    
    if (self.imgArr.count > 0) {
        [KDSProgressHUD showHUDTitle:@"加载中..." toView:self.view];
        self.idArr = [NSMutableArray array];
        myGroup = dispatch_group_create();
        for (int i = 0; i <self.imgArr.count; i ++) {
            UIImage *aimage = self.imgArr[i];
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
                    
                }];
            });
//            NSData * data = UIImageJPEGRepresentation(aimage, 1.0);
//            [self uploadImage:data];
        }
        
        dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
            [self allLoadComplete];
        });
        
    }else{
        [self sumitFeedData];
    }
    
}


-(void)uploadImage:(NSData *)imageDatas{
    
    dispatch_group_enter(myGroup);
    NSString *loadUrl =[NSString stringWithFormat:@"%@commonApp/imgUpload" ,baseuUrl];
    NSDictionary *dic = @{};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager POST:loadUrl parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageDatas
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传成功进度=%@" ,uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功responseObject=%@" ,responseObject);
        dispatch_group_leave(myGroup);
        if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
            NSString *imgID =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"fileRewriteFullyQualifiedPath"]];
            [self.idArr addObject:imgID];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息error=%@" ,error);
                dispatch_group_leave(myGroup);
        //        [self.failLodaArr addObject:imageDatas];
        //        NSLog(@"失败的请求个数=%lu" ,(unsigned long)self.failLodaArr.count);
    }];
    
}
-(void)allLoadComplete{
    NSLog(@"等待全部完成");
    dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"图片上传成功");
        NSLog(@"idArr=%@" ,self.idArr);
        [KDSProgressHUD hideHUDtoView:self.view animated:YES];
        [self sumitFeedData];
    });
}

-(void)sumitFeedData{
    NSLog(@"提交请求");
    NSString *imgStr = [KDSMallTool checkISNull:[self.idArr componentsJoinedByString:@","]];
    NSDictionary *dic = @{@"indentId":self.idStr,
                          @"indentDetailId":self.indentId,
                          @"reasonType":resonKey,
                          @"reason":self.textView.text,
                          @"contactName":peopleField.text,
                          @"contactTel":telField.text,
                          @"imgs":imgStr,
                          @"type":@"returnbill_type_stauts_maintain"
                          };
    NSLog(@"申请售后参数:%@",dic);
    
    [self submitDataWithBlock:@"returnBill/save" partemer:@{@"params":dic,@"token":ACCESSTOKEN} Success:^(id responseObject) {
        NSLog(@"responseObject=%@" ,responseObject);
        if ([self isSuccessData:responseObject]) {
            [KDSProgressHUD showSuccess:@"售后申请成功" toView:self.view completion:^{
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[OrderListController class]]) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新列表" object:nil];
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }

            }];
        }
    }];
    
}


@end
