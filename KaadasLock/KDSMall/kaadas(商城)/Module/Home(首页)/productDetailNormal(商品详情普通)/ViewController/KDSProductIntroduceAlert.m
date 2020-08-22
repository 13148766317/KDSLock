//
//  KDSProductIntroduceAlert.m
//  kaadas
//
//  Created by 中软云 on 2019/6/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductIntroduceAlert.h"
#import "KDSProductParamCell.h"
#import "KDSProductServeCell.h"
static KDSProductIntroduceAlert * __introduceVC = nil;
static UIWindow                 * __window = nil;

@interface KDSProductIntroduceAlert ()
<
UITableViewDelegate,
UITableViewDataSource
>
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
@property (nonatomic,assign)KDSProductIntroduceAlertType    type;

@property (nonatomic,strong)UITableView        * tableView;
//分割线
@property (nonatomic,strong)UIView            * lineView;
//白色背景
@property (nonatomic,strong)UIView            * whitebgView;
//确定
@property (nonatomic,strong)UIButton          * bottomOkButton;
//title
@property (nonatomic,strong)UILabel           * titleLb;

@property (nonatomic,strong)NSMutableArray   * paramArray;
@property (nonatomic,strong)NSMutableArray   * serveArray;

@property (nonatomic,strong)NSMutableArray   * dataArray;
//确定按钮的告诉
@property (nonatomic,assign)CGFloat            bottomOkButtonHeight ;
//白色背景的高度
@property (nonatomic,assign)CGFloat            whiteBgHeight;
@end

@implementation KDSProductIntroduceAlert

-(NSMutableArray *)serveArray{
    if (_serveArray == nil) {
        _serveArray = [NSMutableArray arrayWithObjects:@{@"image":@"icon_install_service",@"title":@"预约安装",@"detail":@"服务费包含旧锁拆除、装新锁及调试费用"},
                       @{@"image":@"icon_years_service",@"title":@"三年质保",@"detail":@"您购买的此商品带有“三年质保”服务，若该商品在指定三年内出现质量问题，则商家将根据商品的实际故障情况，在规定时间内向消费者提供维修或补寄零配件或更换全新商品，以确保消费者可再正常使用该商品的附加服务，或向消费者补偿一定质保基金的附加服务。服务费用由商家与消费者协商确定，且须达成一致。"},
                       @{@"image":@"icon_brand_service",@"title":@"正品保证",@"detail":@"商品支持正品保障服务"},
                       @{@"image":@"icon_time_service",@"title":@"七天无理由退换",@"detail":@"消费者在满足七天无理由退换货申请条件的前提下，可以提出“七天无理由退换货”的申请"},
                       @{@"image":@"icon_give_service",@"title":@"赠运费险",@"detail":@"卖家为您购买的商品投保退货运费险(保单生效以下单显示为标准)"},
                       @{@"image":@"icon_compensation_service",@"title":@"破损包赔",@"detail":@"该商品由商家承诺在服务有效期内提供配件破损补寄服务"},
                       nil];
        
    }
    return _serveArray;
}

-(NSMutableArray *)paramArray{
    if (_paramArray == nil) {
        _paramArray = [NSMutableArray arrayWithObjects:
                    @{@"name":@"品牌",@"value":@"kaadas/凯迪仕"},
                       @{@"name":@"型号",@"value":@"TK2"},
                       @{@"name":@"电源类型",@"value":@"直流电"},
                       @{@"name":@"面板及执手材质",@"value":@"锌合金"},
                       @{@"name":@"电子类型",@"value":@"磁卡锁  感应锁  其它  密码锁 IC卡锁  指纹锁"},
                       @{@"name":@"数据存储类型",@"value":@"离线"},
                       @{@"name":@"饰面颜色",@"value":@"流光银+全国包安装+三年质保 曜石黑+全国包安装+三年质保"},
                       nil];
    }
    return _paramArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == KDSProductIntroduceAlert_parameter) {
        if (_dataArray == nil || _dataArray.count == 0) {
            self.dataArray = self.paramArray;
        }
    }
    //创建UI
    [self createUI];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      if (_type == KDSProductIntroduceAlert_parameter) {
          return self.dataArray.count;
      }else{
          return self.serveArray.count;
      }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == KDSProductIntroduceAlert_parameter) {
        KDSProductParamCell * cell = [KDSProductParamCell productParamCellWithTableView:tableView];
        cell.dict = self.dataArray[indexPath.row];
        return cell;
    }else{
        KDSProductServeCell * cell = [KDSProductServeCell productServeCellWithTableView:tableView];
        cell.dict = self.serveArray[indexPath.row];
        return cell;
    }

}

+(instancetype)productIntroduceShow:(KDSProductIntroduceAlertType)type dataArray:(NSMutableArray * _Nullable)dataArray;{
    __introduceVC = [[KDSProductIntroduceAlert alloc]init];
    __introduceVC.type = type;
    __introduceVC.dataArray = dataArray;
    
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __introduceVC;
    __window = window;
    
    return __introduceVC;
}

-(void)createUI{
       _bottomOkButtonHeight = 50;
       _whiteBgHeight        = 200;
    
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.7;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    UITapGestureRecognizer * backBGTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomOkButtonClick)];
    [_backgroundView addGestureRecognizer:backBGTap];
    
    _whitebgView = [[UIView alloc]init];
    _whitebgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [self.view addSubview:_whitebgView];
    
    
    //顶部title
    _titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
    
    [_whitebgView addSubview:_titleLb];
    if (_type == KDSProductIntroduceAlert_parameter) {
        _titleLb.text = @"产品参数";
        _titleLb.frame = CGRectMake(15, 15, 100, 30);
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }else{
        _titleLb.text = @"基础保障";
        _titleLb.frame = CGRectMake(0, 15, KSCREENWIDTH, 30);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    
    //分割线
    _lineView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
    [_whitebgView addSubview:_lineView];
   
    
    //确定
    _bottomOkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomOkButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [_bottomOkButton setTitle:@"确定" forState:UIControlStateNormal];
    [_bottomOkButton addTarget:self action:@selector(bottomOkButtonClick) forControlEvents:UIControlEventTouchUpInside];
   
    [_whitebgView addSubview:_bottomOkButton];
    
    //tableview
    [_whitebgView addSubview:self.tableView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_type == KDSProductIntroduceAlert_serveice) {//服务
        _whiteBgHeight = KSCREENHEIGHT - 150;
    }else {//参数
//        if (self.dataArray.count > 7) {
//            _whiteBgHeight = KSCREENHEIGHT - 200;
//        }else if (self.dataArray.count <= 3){
//            _whiteBgHeight = 250.0f;
//        }else{
//            _whiteBgHeight = self.dataArray.count * 90;
//        }
        _whiteBgHeight = 450;
    }
    
    //白色背景
    _whitebgView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, _whiteBgHeight);
    
    //分割线
     _lineView.frame = CGRectMake(0, CGRectGetMaxY(_titleLb.frame) + 15, KSCREENWIDTH, dividinghHeight);
    
     //确定
    CGFloat bottomOKButtonX = 88;
    CGFloat bottomOKButtonW = (KSCREENWIDTH - 2 * bottomOKButtonX);
    CGFloat bottomOKButtonY = CGRectGetHeight(_whitebgView.frame) - _bottomOkButtonHeight - (isIPHONE_X ? 34 : 0);
    CGFloat bottomOkButtonH = 44;
     _bottomOkButton.frame = CGRectMake(bottomOKButtonX,bottomOKButtonY, bottomOKButtonW, bottomOkButtonH);
    //确定button的圆角
    _bottomOkButton.layer.cornerRadius = bottomOkButtonH / 2;
    _bottomOkButton.layer.masksToBounds = YES;
    
    //tableview
     self.tableView.frame = CGRectMake(0, CGRectGetMaxY(_lineView.frame), KSCREENWIDTH, CGRectGetMinY(_bottomOkButton.frame) - CGRectGetMaxY(_lineView.frame));
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_type == KDSProductIntroduceAlert_serveice) {
        
    }else{
        
    }
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.whitebgView.frame= CGRectMake(0, KSCREENHEIGHT - weakSelf.whiteBgHeight, KSCREENWIDTH, weakSelf.whiteBgHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [self.tableView reloadData];
}

#pragma mark - 确定点击事件
-(void)bottomOkButtonClick{
    if (_type == KDSProductIntroduceAlert_serveice) {
        
    }else{
        
    }
     __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.whitebgView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, weakSelf.whiteBgHeight);;
    } completion:^(BOOL finished) {
        [self closeVC];
    }];
}

-(void)closeVC{
    __introduceVC = nil;
    __window.hidden = YES;
    __window = nil;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 150.0f;
    }
    return _tableView;
}

//#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
