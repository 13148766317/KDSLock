//
//  KDSMyAssignmentController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyAssignmentController.h"
#import "KDSMyPostSegmentView.h"


#import "KDSAssignmentProceedController.h"
#import "KDSAssignmentCompleteController.h"

@interface KDSMyAssignmentController ()
<
UIScrollViewDelegate
>
@property (nonatomic,strong)KDSMyPostSegmentView   * segmentView;
@property (nonatomic,strong)UIScrollView           * scrollView;
@property (nonatomic,strong)UIView                 * svContentView;
@end

@implementation KDSMyAssignmentController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //创建UI
    [self createUI];
}


-(void)createUI{
    self.navigationBarView.backTitle = @"我的任务";
    
    //分栏
    CGFloat segmentHeight = 45.0f;
    _segmentView = [[KDSMyPostSegmentView alloc]initWithTitleArray:@[@"进行中",@"已完成"]];
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
    
    //进行中
    KDSAssignmentProceedController * proceedVC = [[KDSAssignmentProceedController alloc]init];
    proceedVC.navigationBarView.hidden = YES;
    [_svContentView addSubview:proceedVC.view];
    [proceedVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.svContentView.mas_height);
    }];
    
    
    //已完成
    KDSAssignmentCompleteController * completeVC = [[KDSAssignmentCompleteController alloc]init];
    completeVC.navigationBarView.hidden=YES;
    [_svContentView addSubview:completeVC.view];
    [completeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(proceedVC.view.mas_right);
        make.top.mas_equalTo(proceedVC.view.mas_top);
        make.width.mas_equalTo(proceedVC.view.mas_width);
        make.height.mas_equalTo(proceedVC.view.mas_height);
    }];
    
    [self addChildViewController:proceedVC];
    [self addChildViewController:completeVC];
    
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
