//
//  KDSAppUpdateController.m
//  kaadas
//
//  Created by 中软云 on 2019/8/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSAppUpdateController.h"

static UIWindow               * __updateWindow = nil;
static KDSAppUpdateController * __updateVC     = nil;

@interface KDSAppUpdateController ()
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
@property (nonatomic,strong)UIView            * BGView;
//顶部图片 火箭
@property (nonatomic,strong)UIImageView       * topImageView;
//版本号
@property (nonatomic,strong)UILabel           * versonLb;

//更新button
@property (nonatomic,strong)UIButton         * updateButton;

@property (nonatomic,strong)UIScrollView     * scrollView;

@property (nonatomic,strong)UILabel          * titleLb;

@property (nonatomic,strong)UILabel          * detailLB;

@property (nonatomic,copy)APPUpdateBlock       updateBlock;

@property (nonatomic,strong)KDSSystemUpdateModel   * model;
@end

@implementation KDSAppUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.8;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    //
    _BGView = [[UIView alloc]init];
    _BGView.layer.cornerRadius = 10;
    _BGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_BGView];
    
    //顶部图片 火箭
    _topImageView = [[UIImageView alloc]init];
    [_BGView addSubview:_topImageView];

    //版本号
    _versonLb = [KDSMallTool createbBoldLabelString:[NSString stringWithFormat:@"V%@",[KDSMallTool checkISNull:_model.versionNumber]] textColorString:@"#EC3B3B" font:12];
    _versonLb.textAlignment = NSTextAlignmentLeft;
    [_topImageView addSubview:_versonLb];

    //更新内容title
    _titleLb = [KDSMallTool createLabelString:@"更新内容:" textColorString:@"#666666" font:15];
    [_BGView addSubview:_titleLb];
    
    //scrollView
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [_BGView addSubview:_scrollView];

    //更新详情内容
    _detailLB = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
    _detailLB.numberOfLines = 0;
    [_scrollView addSubview:_detailLB];
    
    //更新button
    _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _updateButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#EC3B3B"];
    [_updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
    _updateButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_updateButton addTarget:self action:@selector(updateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_BGView addSubview:_updateButton];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

        //背景图
        CGFloat bgViewX = 53;
        CGFloat bgViewW = KSCREENWIDTH - 2 * bgViewX;
        CGFloat bgViewH = KSCREENHEIGHT / 2;
        CGFloat bgViewY = (KSCREENHEIGHT - bgViewH ) / 2;
        _BGView.frame = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);

         //顶部图片 火箭
        UIImage * topImage = [UIImage imageNamed:@"bg_update"];
        _topImageView.image = topImage;
        CGFloat topImageViewX = 0;
        CGFloat topImageViewY = -35;
        CGFloat topImageViewW =  CGRectGetWidth(_BGView.frame);
        CGFloat topImageViewH = topImageViewW * topImage.size.height / topImage.size.width;
        _topImageView.frame = CGRectMake(topImageViewX, topImageViewY, topImageViewW, topImageViewH);

        //版本号
        _versonLb.frame = CGRectMake(CGRectGetWidth(_topImageView.frame) / 3 * 2 + 5, CGRectGetHeight(_topImageView.frame) - 25, 70, 25);

        //更新内容:
        CGFloat titleX = 21;
        CGFloat titleY = CGRectGetMaxY(_topImageView.frame) + 20;
        CGFloat titleW = 100;
        CGFloat titleH = 20;
        _titleLb.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
        //scrollview
        CGFloat scrollViewX  = 0;
        CGFloat scrollViewH  = 80;
        CGFloat scrollViewW  = CGRectGetWidth(_topImageView.frame);
        CGFloat scrollViewY  = CGRectGetMaxY(_titleLb.frame);
        _scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);

        //更新的详情内容
        CGFloat detailX = 21;
        CGFloat detailY = 10;
        CGFloat detailW = CGRectGetWidth(_BGView.frame) - 2 * detailX;
        NSString * detailString = [KDSMallTool checkISNull:_model.updateContent];
        CGFloat detailH = [KDSMallTool getNSStringHeight:detailString textMaxWith:detailW font:12];
        _detailLB.frame = CGRectMake(detailX, detailY,detailW , detailH);
        _detailLB.attributedText = [KDSMallTool attributedString:detailString lineSpacing:6];
    
        //重新设置scrollview
        if (detailH < 60) {
            scrollViewH = 60;
        }else if (detailH > 100){
            scrollViewH = 100;
        }else{
            scrollViewH = 80;
        }
        _scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
        _scrollView.contentSize =  CGSizeMake(CGRectGetWidth(_BGView.frame), detailH);
    
        //立即更新
        CGFloat updateButtonX = 20;
        CGFloat updateButtonW = CGRectGetWidth(_BGView.frame) - 2 * updateButtonX;
        CGFloat updateButtonH = 44;
        CGFloat updateButtonY = CGRectGetMaxY(_scrollView.frame) + 10;
        _updateButton.frame = CGRectMake(updateButtonX, updateButtonY, updateButtonW, updateButtonH);
    
        _BGView.frame = CGRectMake(bgViewX, bgViewY, bgViewW, CGRectGetMaxY(_updateButton.frame) + 20);
}


-(void)updateButtonClick{
    NSString *str =  [KDSMallTool checkISNull:_model.url];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    if (self.updateBlock) {
        self.updateBlock();
    }
}

+(instancetype)showModel:(KDSSystemUpdateModel *)model UpdateBlock:(APPUpdateBlock)updateBlock;{
    __updateVC = [[KDSAppUpdateController alloc]init];
    __updateVC.updateBlock = updateBlock;
    __updateVC.model = model;
//    __updateVC.model.updateContent = @"1,bug修复\n 2，完善流程,\n3,bug修复\n,4,bug修复\n 5，完善流程,\n6,bug修复\n,7,bug修复\n 8，完善流程,\n9,bug修复\n";
    
    //创建UIWindow
    __updateWindow = [[UIWindow alloc]init];
    __updateWindow.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    __updateWindow.windowLevel = UIWindowLevelStatusBar;
    __updateWindow.hidden = NO;
    //设置window的主控制器
    __updateWindow.rootViewController = __updateVC;
    
    return __updateVC;
    
    
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
