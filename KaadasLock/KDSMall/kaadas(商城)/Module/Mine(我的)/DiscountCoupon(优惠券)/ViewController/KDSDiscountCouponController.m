//
//  KDSDiscountCouponController.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSDiscountCouponController.h"
#import "KDSDiscountCouponUnUseController.h"
#import "KDSDiscountCouponOverdueController.h"
#import "KDSMyPostSegmentView.h"

@interface KDSDiscountCouponController ()
<
UIScrollViewDelegate
>
@property (nonatomic,strong)KDSMyPostSegmentView   * segmentView;
@property (nonatomic,strong)UIScrollView           * scrollView;
@property (nonatomic,strong)UIView                 * svContentView;

@end

@implementation KDSDiscountCouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UI
    [self createUI];
    
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"我的优惠券";
    
    //分栏
    CGFloat segmentHeight = 45.0f;
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    _segmentView = [[KDSMyPostSegmentView alloc]initWithTitleArray:@[[NSString stringWithFormat:@"未使用(%ld)",userModel.userCouponUseNum],
                                                                     [NSString stringWithFormat:@"已过期(%ld)",userModel.userCouponOverdueNum]]];
    [self.view addSubview:_segmentView];
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(segmentHeight);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
    }];
    
    //底部滚动的scrollview
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator= NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    CGFloat svcontentHeight = isIPHONE_X ? (KSCREENHEIGHT - 88 - 34 - segmentHeight) : (KSCREENHEIGHT - 64 - segmentHeight);
    _svContentView = [[UIView alloc]init];
    [_scrollView addSubview:_svContentView];
    [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(2 * KSCREENWIDTH);
        make.height.mas_equalTo(svcontentHeight);
    }];
    
    //我的帖子
    KDSDiscountCouponUnUseController * unUseVC = [[KDSDiscountCouponUnUseController alloc]init];
    unUseVC.navigationBarView.hidden = YES;
    [_svContentView addSubview:unUseVC.view];
    [unUseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.svContentView.mas_height);
    }];
    
    //我的回复
    KDSDiscountCouponOverdueController * overDueVC = [[KDSDiscountCouponOverdueController alloc]init];
    overDueVC.navigationBarView.hidden = YES;
    [_svContentView addSubview:overDueVC.view];
    [overDueVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(unUseVC.view.mas_right);
        make.top.mas_equalTo(unUseVC.view.mas_top);
        make.width.mas_equalTo(unUseVC.view.mas_width);
        make.height.mas_equalTo(unUseVC.view.mas_height);
    }];
    
    [self addChildViewController:unUseVC];
    [self addChildViewController:overDueVC];
    
    //分栏点击事件block
    __weak typeof(self)weakSekf  = self;
    _segmentView.segmentButton  = ^(NSInteger index) {
        if (index < 0) {
            return ;
        }
        [UIView animateWithDuration:0.25 animations:^{
            weakSekf.scrollView.contentOffset = CGPointMake(index * KSCREENWIDTH, 0);
        }];
    };
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _segmentView.selectIndexViewController = scrollView.contentOffset.x / KSCREENWIDTH;
}

@end
