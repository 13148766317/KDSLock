//
//  KDSCouponsController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCouponsController.h"


static KDSCouponsController * __couponsVC = nil;
static UIWindow             * __window    = nil;

@interface KDSCouponsController ()
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
@end

@implementation KDSCouponsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}


#pragma mark - 创建UI
-(void)createUI{
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    UIImage * image = [UIImage imageNamed:@"coupon1"];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
//    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    CGFloat imageViewX = isIphone5sBelow ? 30.0f : 50.0f;
    CGFloat imageViewW = KSCREENWIDTH - imageViewX * 2;
    CGFloat imageViewH = imageViewW * image.size.height / image.size.width;
    CGFloat imageViewY = (KSCREENHEIGHT - imageViewH) / 2.0;
    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    //新人专享券
    UILabel * conponsTitleLb = [KDSMallTool createbBoldLabelString:@"新人专享券" textColorString:@"#7F5C3A" font:21];
    conponsTitleLb.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:conponsTitleLb];
    
    CGFloat  conponsTitleX  = 0;
    CGFloat  conponsTitleY  = CGRectGetHeight(imageView.frame) / 2 + 15;
    CGFloat  conponsTitleW  = CGRectGetWidth(imageView.frame) - 2 * conponsTitleX;
    CGFloat  conponsTitleH  =  30;
    conponsTitleLb.frame = CGRectMake(conponsTitleX, conponsTitleY, conponsTitleW, conponsTitleH);
    
//    conponsTitleLb.backgroundColor  = [UIColor purpleColor];
    
    //价格
    NSString * priceString = @"￥100";
    UILabel * priceLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#CA2128" font:36];
    [imageView addSubview:priceLb];
    priceLb.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21]} range:NSMakeRange(0, 1) lineSpacing:0 alignment:NSTextAlignmentCenter];
    CGFloat priceX =  0;
    CGFloat priceH =  30;
    CGFloat priceY =  CGRectGetHeight(imageView.frame) / 4 * 3 - priceH - 3;
    CGFloat priceW =  CGRectGetWidth(imageView.frame);
    priceLb.frame = CGRectMake(priceX, priceY, priceW, priceH);
//    priceLb.backgroundColor = [UIColor grayColor];
    
    //现金抵扣券
    UILabel * conponsDesLb = [KDSMallTool createLabelString:@"现金抵扣券" textColorString:@"#7F5C3A" font:15];
    conponsDesLb.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:conponsDesLb];
    
    CGFloat conponsDesX = 0;
    CGFloat conponsDesY = CGRectGetMaxY(priceLb.frame) + 5;
    CGFloat conponsDesW = CGRectGetWidth(imageView.frame) - conponsDesX * 2;
    CGFloat conponsDesH =  20;
    conponsDesLb.frame = CGRectMake(conponsDesX, conponsDesY, conponsDesW, conponsDesH);
//    conponsDesLb.backgroundColor = [UIColor blueColor];
    
    //领取
    UIButton * getButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    [getButton setTitle:@"领 取" forState:UIControlStateNormal];
    getButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [getButton addTarget:self action:@selector(getButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:getButton];
    
    CGFloat getButtonW = 120;
    CGFloat getButtonX = (CGRectGetWidth(imageView.frame) - getButtonW)/2;
    CGFloat getButtonH = 33;
    CGFloat getButtonY = CGRectGetHeight(imageView.frame) - getButtonH - 15;
    
    getButton.frame = CGRectMake(getButtonX, getButtonY, getButtonW, getButtonH);
    
}

#pragma mark - 领取点击事件
-(void)getButtonClick{
    NSLog(@"领取");
    [self closeWindow];
}


+(instancetype)show{
    __couponsVC = [[KDSCouponsController alloc]init];

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

#pragma mark - 关闭弹框
-(void)closeWindow{
    __couponsVC = nil;
    __window.hidden = YES;
    __window = nil;
    
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
