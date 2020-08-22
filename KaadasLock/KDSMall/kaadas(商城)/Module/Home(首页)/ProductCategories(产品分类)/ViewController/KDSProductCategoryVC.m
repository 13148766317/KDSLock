//
//  KDSProductCategoryVC.m
//  kaadas
//
//  Created by 中软云 on 2019/6/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductCategoryVC.h"
#import "KDSCategoryHeaderView.h"
#import "KDSHomePageHttp.h"
#import "KDSCategoryChildModel.h"

#import "KDSCategoryDetailController.h"

@interface KDSProductCategoryVC ()
<
KDSProductCategoryHeaderViewDelegate,
UIScrollViewDelegate
>
@property (nonatomic,strong)KDSCategoryHeaderView   * headerView;
@property (nonatomic,strong)NSMutableArray          * categotyArray;
@property (nonatomic,strong)UIScrollView            * scrollView;
@property (nonatomic,strong)UIView                  * svContentView;

@end

@implementation KDSProductCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
    if (_ID > 0) {
        [self getategoryChildList];
    }else{
        
    }
}
//#pragma mark - 筛选button点击事件
-(void)productCategiryButtonClick:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index * KSCREENWIDTH, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _headerView.selectIndexViewController = scrollView.contentOffset.x / KSCREENWIDTH;
}

-(void)getategoryChildList{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{
                            @"token":[KDSMallTool checkISNull:userToken],
                            @"params":@{
                                    @"id":@(_ID)
                                    }
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSHomePageHttp getChildListWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD  hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            [weakSelf.categotyArray removeAllObjects];
            [weakSelf.categotyArray  addObjectsFromArray:obj];
//            if (weakSelf.categotyArray.count > 0) {
//                weakSelf.childModel = [weakSelf.categotyArray firstObject];
//            }
            weakSelf.headerView.categoryArray = weakSelf.categotyArray;
            
            for (int i = 0; i < weakSelf.categotyArray.count; i++) {
                KDSCategoryDetailController * detailVC = [[KDSCategoryDetailController alloc]init];
                KDSCategoryChildModel * childModel = weakSelf.categotyArray[i];
                detailVC.ID = [childModel.ID integerValue];
                [_svContentView addSubview:detailVC.view];
                [detailVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(0).mas_offset(i * KSCREENWIDTH);
                    make.top.mas_equalTo(weakSelf.svContentView.mas_top);
                    make.height.mas_equalTo(weakSelf.svContentView.mas_height);
                    make.width.mas_equalTo(KSCREENWIDTH);
                }];
                [self addChildViewController:detailVC];
            }
            
            if (_ID > 0) {
                [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(weakSelf.scrollView);
                    make.width.mas_equalTo(weakSelf.categotyArray.count * KSCREENWIDTH);
                    make.height.mas_equalTo(KSCREENHEIGHT - (isIPHONE_X ?  88 : 64) - 45 - (isIPHONE_X ? 34 : 0));
                }];
            }else{
                [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(weakSelf.scrollView);
                    make.width.mas_equalTo(weakSelf.categotyArray.count * KSCREENWIDTH);
                    make.height.mas_equalTo(KSCREENHEIGHT - (isIPHONE_X ?  88 : 64) - (isIPHONE_X ? 34 : 0));
                }];
            }
            
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD  hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}
#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = _titleStr;
    
    _headerView = [[KDSCategoryHeaderView alloc]init];
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];

    
    _svContentView = [[UIView alloc]init];
    [_scrollView addSubview:_svContentView];
    
    if (_ID > 0) {
        _headerView.hidden = NO;
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.navigationBarView.mas_bottom);
            make.height.mas_equalTo(45);
        }];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
        }];
        [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollView);
            make.width.mas_equalTo( KSCREENWIDTH);
            make.height.mas_equalTo(KSCREENHEIGHT - (isIPHONE_X ?  88 : 64) - 45 - (isIPHONE_X ? 34 : 0));
        }];
    }else{
        _headerView.hidden = YES;
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.navigationBarView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
        }];
        [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollView);
            make.width.mas_equalTo( KSCREENWIDTH);
            make.height.mas_equalTo(KSCREENHEIGHT - (isIPHONE_X ?  88 : 64) - (isIPHONE_X ? 34 : 0));
        }];
    }
    
}

-(NSMutableArray *)categotyArray{
    if (_categotyArray == nil) {
        _categotyArray  = [NSMutableArray array];
    }
    return _categotyArray;
}

@end
