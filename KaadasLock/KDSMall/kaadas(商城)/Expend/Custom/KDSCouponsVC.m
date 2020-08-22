//
//  KDSCouponsVC.m
//  kaadas
//
//  Created by 中软云 on 2019/7/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCouponsVC.h"
#import "KDSCouponsCell.h"
#import "KDSNoCouponView.h"

static KDSCouponsVC * __couponsVC = nil;
static UIWindow     * __window    = nil;

@interface KDSCouponsVC ()
<UITableViewDelegate,
UITableViewDataSource,
KDSCouponsCellDelegate
>
//创建底部半透明的view
@property (nonatomic,strong)UIView                    * backgroundView;
@property (nonatomic,strong)UITableView               * tableView;
@property (nonatomic,strong)UIView                    * bgView;
@property (nonatomic,copy)KDSCouponsSelectBlock         selectBlock;
@property (nonatomic,strong)NSMutableArray            * dataArray;
@property (nonatomic,strong)UILabel                   * titleLb;
@property (nonatomic,assign)NSInteger                   bgViewHeight;
@property (nonatomic,assign)NSInteger                   selectIndex;//记录选中的优惠券
@property (nonatomic,copy)NSString                   * couponID;
@property (nonatomic,strong)KDSNoCouponView          * noCouponView ;
@end

@implementation KDSCouponsVC

+(instancetype)showWithcouponID:(NSString *)couponID  data:(NSMutableArray *)dataArray selectBlock:(KDSCouponsSelectBlock)selectBlock{
    
    __couponsVC = [[KDSCouponsVC alloc]init];
    __couponsVC.selectBlock = selectBlock;
    __couponsVC.dataArray   = dataArray;
    __couponsVC.couponID    = couponID;
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __couponsVC;
    __window = window;
    
    return __couponsVC;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSCouponsCell * cell = [KDSCouponsCell couponsCellWithTableView:tableView];
    cell.couponID = _couponID;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    KDSCoupon1Model * model = self.dataArray[indexPath.row];
    for (int i = 0; i < self.dataArray.count; i++) {
        KDSCoupon1Model * model1 = self.dataArray[i];
        if ([model.ID isEqualToString:model1.ID]) {
            model1.select = !model.select;
        }else{
            model1.select = NO;
        }
    }

    [self.tableView reloadData];
}

#pragma mark - KDSCouponsCellDelegate
-(void)couponsCellDelegate:(NSIndexPath *)indexPath model:(KDSCoupon1Model * _Nullable)model{
    
    for (int i = 0; i < self.dataArray.count; i++) {
        KDSCoupon1Model * model1 = self.dataArray[i];
        if ([model.ID isEqualToString:model1.ID]) {
            model1.select = model.select;
        }else{
            model1.select = NO;
        }
    }

    [self.tableView reloadData];
}

#pragma mark - 取消点击事件
-(void)cancelButtonClick{
    [self closeWindow];
}

#pragma mark - 确定点击事件
-(void)okButtonClick{

    NSString * couponID = @"";
    KDSCoupon1Model * selectModel = nil;
    for (int i = 0; i < self.dataArray.count; i++) {
        KDSCoupon1Model  * model = self.dataArray[i];
        if (model.select) {
            couponID = model.ID;
            selectModel = model;
        }
    }

    //回调
    if (self.selectBlock) {
        self.selectBlock(couponID,selectModel);
    }
    [self closeWindow];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.frame =  CGRectMake(0,  KSCREENHEIGHT - weakSelf.bgViewHeight, KSCREENWIDTH, weakSelf.bgViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [self.tableView reloadData];
}
#pragma mark - 关闭弹框
-(void)closeWindow{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, weakSelf.bgViewHeight);
    } completion:^(BOOL finished) {
        __couponsVC = nil;
        __window.hidden = YES;
        __window = nil;
    }];
}

#pragma mark - 创建UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (KDSCoupon1Model * model in self.dataArray) {
        if ([model.ID isEqualToString:_couponID]) {
            model.select = YES;
            _couponID = [KDSMallTool checkISNull:model.ID];
        }
    }
    
    _bgViewHeight = KSCREENHEIGHT / 1.5;
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
    [self.view addSubview:_bgView];
    _bgView.frame =  CGRectMake(0,  KSCREENHEIGHT, KSCREENWIDTH, _bgViewHeight);
    
    //选择优惠券title
    _titleLb = [KDSMallTool createLabelString:@"选择优惠券" textColorString:@"333333" font:15];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLb];
    _titleLb.frame  = CGRectMake(0, 0, CGRectGetWidth(_bgView.frame), 60);
    
    UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
    [_titleLb addSubview:dividing];
    dividing.frame = CGRectMake(0, CGRectGetHeight(_titleLb.frame) - dividinghHeight, CGRectGetWidth(_titleLb.frame), dividinghHeight);
    
    //取消button
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:cancelButton];
    cancelButton.frame = CGRectMake(0, 0, 50, CGRectGetHeight(_titleLb.frame));
    
    //确定button
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:okButton];
    okButton.frame = CGRectMake(CGRectGetWidth(_bgView.frame) - CGRectGetWidth(cancelButton.frame), CGRectGetMinY(cancelButton.frame), CGRectGetWidth(cancelButton.frame), CGRectGetHeight(cancelButton.frame));
    
    [_bgView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(_titleLb.frame), CGRectGetWidth(_bgView.frame), CGRectGetHeight(_bgView.frame) - CGRectGetHeight(_titleLb.frame));
    
    _noCouponView = [[KDSNoCouponView alloc]init];
    _noCouponView.hidden = YES;
    [self.tableView addSubview:_noCouponView];
    _noCouponView.frame = CGRectMake(30, 30, CGRectGetWidth(self.tableView.frame) - 60, CGRectGetHeight(self.tableView.frame) - 60);
    
    
    if (self.dataArray.count <= 0) {
        _noCouponView.hidden = NO;
    }else{
        _noCouponView.hidden = YES;
    }
    
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 60.0f;
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



