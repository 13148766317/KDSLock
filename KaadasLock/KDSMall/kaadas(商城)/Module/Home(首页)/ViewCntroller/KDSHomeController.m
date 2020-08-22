//
//  KDSHomeController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeController.h"
#import "KDSHomeBannerView.h"
#import "KDSSearchView.h"
#import "KDSHomeHeaderView.h"
#import "KDSHomeVideoCell.h"
#import "KDSHomePageCell.h"
#import "KDSHomeOneItemCell.h"
#import "KDSHomeTwoItemCell.h"
#import "KDSCrowdfundingOneCell.h"
#import "KDSCrowdfundingTwoCell.h"
#import "KDSSeckillOneItemCell.h"
#import "KDSSeckillTwoItemCell.h"
#import "KDSHomeMoreItemCell.h"

//#import "KDSCrowfundingListController.h"
//#import "KDSGroupController.h"
//#import "KDSSeckillController.h"
#import "KDSProductCategoryController.h"
#import "KDSProductCategoryVC.h"
#import "KDSNewPersonCouponsController.h"
#import "KDSShopCartController.h"
//#import "KDSBargainListController.h"
//#import "KDSBargainingDetailController.h"

//详情
//#import "KDSProductDetailNorController.h"
//#import "KDSCrowFundProductDeailController.h"
//#import "KDSGroupProductDetailController.h"

//#import "KDSCrowfundDetailController.h"
#import "KDSProductDetailNormalController.h"
//#import "KDSGroupDetailViewController.h"
//#import "KDSBargainDetailController.h"

#import "KDSHomeSearchController.h"
#import "KDSMessageCenterController.h"
#import "KDSNewMessageCenterVC.h"
//#import "KDSSeckillDetailViewController.h"
#import "KDSBindingPhoneNumController.h"
//#import "KDSBargainingController.h"
#import "KDSHomeMoreAlertController.h"
#import "KDSOnlineServiceController.h"


#import "KDSInformationController.h"
#import "OrderListController.h"
#import "KDSFeedbackController.h"
#import "KDSIntergralDetailController.h"
#import "KDSDiscountCouponController.h"
#import "KDSMyCollectController.h"
#import "KDSMyFootPrintController.h"

#import "KDSHomePageHttp.h"
#import "KDSFirstPartModel.h"
#import "KDSSecondPartModel.h"
#import "KDSCheckUploadHttp.h"


#warning test
#import "AfterSaleController.h"

#import "KDSLoginViewController.h"

//显示的列数
#define kColumn 2

@interface KDSHomeController ()
<
UITableViewDataSource,
UITableViewDelegate,
KDSSearchViewDelegate,
KDSSearchViewDelegate,
KDSHomeHeaderViewDelegate,
KDSCrowdfundingTwoCellDelegate,
KDSHomeTwoItemCellDelegate,
KDSSeckillTwoItemCellDelegate,
KDSHomePageCellDelegate,
KDSHomeVideoCellDelegate,
KDSHomeBannerViewDelegate,
KDSHomeMoreItemCellDelegate
>
@property (nonatomic,strong)UITableView         *  tableView;
//轮播图
@property (nonatomic,strong)KDSHomeBannerView   * bannerView;
//搜索
@property (nonatomic,strong)KDSSearchView       * searchView;
//
@property (nonatomic,strong)KDSFirstPartModel   * firstPartModel;

@property (nonatomic,strong)NSMutableArray      * dataArray;

@property (nonatomic,assign)NSInteger            requestcount;

@end

@implementation KDSHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建UI
    [self createUI];

    //获取数据
    [self getHomeData];
    
    //添加刷新首页的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHomeData) name:HOME_REFRESH_NOTIFICATION object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {

    self.hidesBottomBarWhenPushed = NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //判断优惠券是否领取
    NSDate * lastDate =   [[NSUserDefaults standardUserDefaults] objectForKey:couponDate];
    if (lastDate== nil || [lastDate isKindOfClass:[NSNull class]]) {//
        //新人优惠券
        [self newPersonCounpon];
    }else{
        DTTimePeriod * timePeriod = [[DTTimePeriod alloc]initWithStartDate:lastDate endDate:[NSDate date]];
        if ([timePeriod durationInSeconds] > couponTime) {//
            [self newPersonCounpon];
        }
    }
    
    //获取是否要显示手机号登录
    [self getListValue];
    
    [self getShopCartAndSystemNumber];
}

#pragma mark - 获取购物车系统消息数量
-(void)getShopCartAndSystemNumber{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * params = @{@"token":[KDSMallTool checkISNull:userToken]};
    __weak typeof(self)weakSelf = self;
    [KDSHomePageHttp getShopCartAndSysNumberWithParams:params success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            if ([KDSMallTool checkObjIsNull:obj]) {
                return;
            }
            weakSelf.searchView.shopCartButton.badgeNumber =  [obj[@"shopNumber"] integerValue];
//            weakSelf.searchView.newsMsgButton.badgeNumber  = [obj[@"sysMessageNumber"] integerValue];
        }else{
            weakSelf.searchView.shopCartButton.badgeNumber = 0;
//            weakSelf.searchView.newsMsgButton.badgeNumber  = 0;
        }
      
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 获取是否要显示手机号登录
-(void)getListValue{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictParams = @{@"params":@{@"categorys":@[@"login_type"]},
                                  @"token":[KDSMallTool checkISNull:userToken]
                                    };
    [KDSCheckUploadHttp getListValueWithParams:dictParams success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [HelperTool shareInstance].isUpload  = false; // [obj[@"login_type"][@"iostellogin1"] boolValue];  // 
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 新人优惠券
-(void)newPersonCounpon{
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    NSString * userToken = [KDSMallTool checkISNull:[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    if (userToken.length <= 0) {//未登录
        NSDictionary * paramDict = @{@"params":@{}};
        [KDSHomePageHttp getNotokenCouponWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
            if (isSuccess) {
                if ([HelperTool shareInstance].isHomeCoupon || self.tabBarController.selectedIndex != 0) {
                    return ;
                }
                [KDSNewPersonCouponsController showCouponsWithModel:obj getButtonClick:^{
//                    WxLoginController * wxLogin =   [[WxLoginController alloc]init];
                    KDSLoginViewController * wxLogin = [[KDSLoginViewController alloc]init];

                    [self presentViewController:wxLogin animated:YES completion:^{}];
                } cancelButtonClick:^{
                    NSDate * nowDate = [NSDate date];
                    [[NSUserDefaults standardUserDefaults] setValue:nowDate forKey:couponDate];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }];
            }else{
               
            }
        } failure:^(NSError * _Nonnull error) {
           
        }];
    }else{//已登录
        NSDictionary * paramDict = @{@"params":@{},
                                     @"token": userToken //
                                     };
        [KDSHomePageHttp getCouponWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
            if (isSuccess) {
                if ([HelperTool shareInstance].isHomeCoupon || self.tabBarController.selectedIndex != 0) {
                    return ;
                }
                
                KDSCouponModel * model = (KDSCouponModel *)obj;
                if (!model.status) {//判断是否领取
                    NSString * userToken = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
                    [KDSNewPersonCouponsController showCouponsWithModel:obj getButtonClick:^{
                        if ([KDSMallTool checkISNull:userModel.tel].length <= 0) {
                            KDSBindingPhoneNumController  * bindingPhoneController = [[KDSBindingPhoneNumController alloc]init];
                             bindingPhoneController.coupon = YES;
                            self.hidesBottomBarWhenPushed = YES;

                            [self.navigationController pushViewController:bindingPhoneController animated:YES];

                        }else{
                            WebViewController * webView = [[WebViewController alloc]init];
                            webView.url = [NSString stringWithFormat:@"%@coupon?token=%@",webBaseUrl,[KDSMallTool checkISNull:userToken]];
                            //NSLog(@"webView.url:%@",webView.url);
                            webView.title = @"新人福利";
                            webView.rightButtonHidden = YES;
                            self.hidesBottomBarWhenPushed = YES;
                            
                            [self.navigationController pushViewController:webView animated:YES];

                        }
                        
                    } cancelButtonClick:^{
                         NSDate * nowDate = [NSDate date];
                        [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:couponDate];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }];
                }
             
            }else{
            
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
}

#pragma mark - 下拉刷新
-(void)homeRefresh{
    _requestcount = 0;
    [self getHomeData];
}

#pragma mark - 获取首页数据
-(void)getHomeData{
    [self getFitstPartData];
    [self getSecondPartData];
}

#pragma mark - 获取第一部分数据
-(void)getFitstPartData{
    NSString * usertoken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    __weak typeof(self)weakSelf = self;
    [KDSHomePageHttp getFirstPartParams:@ {@"token":[KDSMallTool checkISNull:usertoken]} success:^(BOOL isSuccess, id  _Nonnull obj) {
        weakSelf.requestcount ++;
        if (weakSelf.requestcount >=2) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        if (isSuccess) {
            weakSelf.firstPartModel = (KDSFirstPartModel *)obj;
            KDSHomeBannerView   * bannerView = (KDSHomeBannerView *)self.tableView.tableHeaderView;
            bannerView.bannerArray = weakSelf.firstPartModel.banner;
//            [weakSelf.tableView reloadData];
        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
            
//            }];
        }
      
    } failure:^(NSError * _Nonnull error) {
        weakSelf.requestcount ++;
        if (weakSelf.requestcount >=2) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];

}
#pragma mark - 获取第二部分数据
-(void)getSecondPartData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
      __weak typeof(self)weakSelf = self;
    [KDSHomePageHttp getSecondPartWithParams:@{@"token":[KDSMallTool checkISNull:userToken]} success:^(BOOL isSuccess, id  _Nonnull obj) {
        weakSelf.requestcount ++;
        if (weakSelf.requestcount >=2) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        if (isSuccess) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:obj];
            [weakSelf.tableView reloadData];
        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
        
    } failure:^(NSError * _Nonnull error) {
        weakSelf.requestcount ++;
        if (weakSelf.requestcount >=2) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark -   KDSCrowdfundingTwoCellDelegate 今日众筹
//-(void)crowdfundingTwoCellButtonClick:(NSIndexPath *)indexPath buttonTag:(NSInteger)buttonTag{
//
//    KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];
//
//    NSInteger index = 0;
//    if (model.list.count % 2 == 0) {
//        index = indexPath.row * 2 + buttonTag;
//    }else {
//        index = indexPath.row * 2 + buttonTag - 1;
//    }
//
//    KDSCrowfundDetailController  * productDetailVC = [[KDSCrowfundDetailController alloc]init];
//    productDetailVC.rowModel = model.list[index];
//    [self.navigationController pushViewController:productDetailVC animated:YES];
//}


//-(void)crowdfundingTwoCellCheckButtonClick:(NSIndexPath *)indexPath buttonTag:(NSInteger)buttonTag{
//    KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];
//
//    NSInteger index = 0;
//    if (model.list.count % 2 == 0) {
//        index = indexPath.row * 2 + buttonTag;
//    }else {
//        index = indexPath.row * 2 + buttonTag - 1;
//    }
//
//    KDSCrowfundDetailController  * productDetailVC = [[KDSCrowfundDetailController alloc]init];
//    [self.navigationController pushViewController:productDetailVC animated:YES];
//}

#pragma mark - KDSHomeTwoItemCellDelegate  点击两个item的cell 普通 今日拼团  砍价 详情
-(void)homeTwoItemCellButtonClick:(NSIndexPath *)indexPath buttonTag:(NSInteger)buttonTag productType:(KDSProductType)productType{
    
    KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];
    
    NSInteger index = 0;
    if (model.list.count % 2 == 0) {
        index = indexPath.row * 2 + buttonTag;
    }else {
        index = indexPath.row * 2 + buttonTag - 1;
    }
    
    switch (productType) {
        case KDSProduct_noraml:{//普通商品
            KDSProductDetailNormalController * normalDetail = [[KDSProductDetailNormalController alloc]init];
            KDSSecondPartRowModel * rowModel =  model.list[index];
            normalDetail.rowModel = rowModel;
            
            self.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:normalDetail animated:YES];

        }
            break;
        case KDSProduct_group:{//拼团
//            KDSGroupDetailViewController * group = [[KDSGroupDetailViewController alloc]init];
//            group.rowModel = model.list[index];
//            [self.navigationController pushViewController:group animated:YES];
        }
            
            break;
        case KDSProduct_bargain:{//砍价
//            NSLog(@"砍价详情2");
//            KDSSecondPartRowModel * rowModel = model.list[index];
//            if (!rowModel.flg) {//未砍价
//                KDSBargainDetailController * bargain   =  [[KDSBargainDetailController alloc]init];
//                bargain.rowModel =rowModel;
//                bargain.bargainCustomIDBlock = ^(NSString * _Nullable customerBargainId) {
//                    rowModel.flg = 1;
//                    rowModel.customerBargainId = [customerBargainId integerValue];
//                };
//                [self.navigationController pushViewController:bargain animated:YES];
//            }else{//已砍价
//                KDSBargainingDetailController * bargainingDetailVC = [[KDSBargainingDetailController alloc]init];
//                bargainingDetailVC.customerBargainId = rowModel.customerBargainId;
//                [self.navigationController pushViewController:bargainingDetailVC animated:YES];
//            }
           
        }
            break;
            
        default:
            break;
    }
   
}
#pragma mark - KDSSeckillTwoItemCellDelegate 限时秒杀
//-(void)seckillTwoItemCellButtonClck:(NSIndexPath *)indexPath buttonTag:(NSInteger)buttonTag{
//
//    KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];
//
//    NSInteger index = 0;
//    if (model.list.count % 2 == 0) {
//        index = indexPath.row * 2 + buttonTag;
//    }else {
//        index = indexPath.row * 2 + buttonTag - 1;
//    }
//
////    KDSSeckillProductDetailController * seckillDetailVC = [[KDSSeckillProductDetailController alloc]init];
//    KDSSeckillDetailViewController * seckillDetailVC = [[KDSSeckillDetailViewController alloc]init];
//    seckillDetailVC.rowModel = model.list[index];
//    [self.navigationController pushViewController:seckillDetailVC animated:YES];
//}


#pragma mark - 产品更多 KDSHomePageCellDelegate
-(void)homePageCellMoreButtonClick{
    KDSProductCategoryController  * productCategoryVC = [[KDSProductCategoryController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productCategoryVC animated:YES];

}

#warning
-(void)homePageCellItemButtonClick:(NSInteger)index{
    KDSFirstPartCategoriesModel * categoryModel = self.firstPartModel.categories[index];
    KDSProductCategoryController  * productCategoryVC = [[KDSProductCategoryController alloc]init];
    productCategoryVC.ID = categoryModel.ID;
    productCategoryVC.titleStr = categoryModel.name;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productCategoryVC animated:YES];

}

#pragma mark -  UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1 + self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {//视频  更多产品    大图
        return 1;
    }else{
        KDSSecondPartModel * secondPartModel = self.dataArray[section - 1];
        if (secondPartModel.list.count % 2 == 0) {
            return secondPartModel.list.count / 2;
        }else{
            return secondPartModel.list.count / 2 + 1;
        }
    }
    
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else{
        
        KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];
        if (model.list.count % 2 != 0) {
            if ([model.moduleKey isEqualToString:@"product_type_pushAndPull"]|| [model.moduleKey isEqualToString:@"product_type_s"]) {//推拉
                KDSProductDetailNormalController * normalDetail = [[KDSProductDetailNormalController alloc]init];
                KDSSecondPartRowModel * rowRodel = model.list[0];
                normalDetail.rowModel = rowRodel;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:normalDetail animated:YES];

            }else if ([model.moduleKey isEqualToString:@"product_type_flexible"]|| [model.moduleKey isEqualToString:@"product_type_k"]){//灵动
                KDSProductDetailNormalController * normalDetail = [[KDSProductDetailNormalController alloc]init];
                KDSSecondPartRowModel * rowRodel = model.list[0];
                normalDetail.rowModel = rowRodel;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:normalDetail animated:YES];

            }else if ([model.moduleKey isEqualToString:@"product_type_invite"]){
                KDSProductDetailNormalController * normalDetail = [[KDSProductDetailNormalController alloc]init];
                KDSSecondPartRowModel * rowRodel = model.list[0];
                normalDetail.rowModel = rowRodel;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:normalDetail animated:YES];

            }else if ([model.moduleKey isEqualToString:@"product_type_crowd"]){//今日众筹
//                KDSCrowfundDetailController  * productDetailVC = [[KDSCrowfundDetailController alloc]init];
//                productDetailVC.rowModel  = model.list[0];
//                [self.navigationController pushViewController:productDetailVC animated:YES];
            }else if ([model.moduleKey isEqualToString:@"product_type_group"]){//今日拼团
//                KDSGroupDetailViewController * group = [[KDSGroupDetailViewController alloc]init];
//                group.rowModel = model.list[0];
//                [self.navigationController pushViewController:group animated:YES];
            }else if ([model.moduleKey isEqualToString:@"product_type_seckill"]){//限时秒杀
//                KDSSeckillDetailViewController * seckillDetailVC = [[KDSSeckillDetailViewController alloc]init];
////                KDSSeckillProductDetailController * seckillDetailVC = [[KDSSeckillProductDetailController alloc]init];
//                seckillDetailVC.rowModel = model.list[0];
//                [self.navigationController pushViewController:seckillDetailVC animated:YES];
            }else if ([model.moduleKey isEqualToString:@"product_type_bargain"]){
//                NSLog(@"砍价详情1");
//                KDSSecondPartRowModel  * rowModel = model.list[0];
//                if (!rowModel.flg) {//未砍价
//                    KDSBargainDetailController * bargainDetailVC = [[KDSBargainDetailController alloc]init];
//                    bargainDetailVC.rowModel = rowModel;
//                    bargainDetailVC.bargainCustomIDBlock = ^(NSString * _Nullable customerBargainId) {
//                        rowModel.customerBargainId = [customerBargainId integerValue];
//                        rowModel.flg = 1;
//                    };
//                    [self.navigationController pushViewController:bargainDetailVC animated:YES];
//                }else{//已砍价
//                    KDSBargainingDetailController * bargainingDetailVC = [[KDSBargainingDetailController alloc]init];
//                    bargainingDetailVC.customerBargainId = rowModel.customerBargainId;
//                    [self.navigationController pushViewController:bargainingDetailVC animated:YES];
//                }
              
            }
        }
    }
}


#pragma mark - KDSHomeVideoCellDelegate 点击播放视频
-(void)videoTableCellVideoButtonClick:(NSIndexPath *)cellIndexPath videoIndex:(NSInteger)videoIndex videoView:(UIImageView *)videoView{

    NSMutableArray *browserDataArr = [NSMutableArray array];
    KDSFirstPartVideoModel * videoModel  = self.firstPartModel.vedio;
    // Type 1 : 网络视频 / Network video
    YBVideoBrowseCellData *data = [YBVideoBrowseCellData new];
    data.url = [NSURL URLWithString:videoModel.url];
    data.sourceObject =videoView;
    data.allowSaveToPhotoAlbum = NO;
    data.autoPlayCount = 1;
    [browserDataArr addObject:data];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = videoIndex;
    [browser show];
    
}
#pragma mark - KDSHomeMoreItemCellDelegate 积分 优惠券 我的收藏 浏览足迹  点击事件
-(void)homeMoreItemCellButtonClick:(NSInteger)index{
    switch (index) {
            case 0:{//积分
                KDSIntergralDetailController * interfalDetailVC = [[KDSIntergralDetailController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:interfalDetailVC animated:YES];

            }
            break;
            
            case 1:{//优惠券
                KDSDiscountCouponController * discountCouponVC = [[KDSDiscountCouponController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:discountCouponVC animated:YES];

            }
            break;
            
            case 2:{//我的收藏
                KDSMyCollectController * myCollectionVC = [[KDSMyCollectController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myCollectionVC animated:YES];

            }
            break;
            
            case 3:{//浏览足迹
                KDSMyFootPrintController * myFootPrintVC = [[KDSMyFootPrintController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myFootPrintVC animated:YES];

            }
            break;
            
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            KDSHomeMoreItemCell * cell = [KDSHomeMoreItemCell homeMoreItemWithTableView:tableView dataArray:@[@"积分",@"优惠券",@"我的收藏",@"浏览足迹"]];
            cell.delegate = self;
            return cell;
        }else{
            KDSHomePageCell * cell = [KDSHomePageCell homePageCellWithTableView:tableView];
            cell.delegate = self;
            cell.categoryArray = self.firstPartModel.categories;
            return cell;
        }
    }else{
            KDSSecondPartModel * model = self.dataArray[indexPath.section - 1];

            NSInteger loction = 0;
            NSInteger length  = 0;
            if (model.list.count % 2 == 0) {
                 loction = indexPath.row * kColumn;
                 length  = kColumn;
            }else{
                if (indexPath.row == 0) {
                    loction = indexPath.row * kColumn;
                    length  = kColumn - 1;
                }else{
                    loction = indexPath.row * kColumn - 1;
                    length  = kColumn;
                }
            }
        
            if (length + loction > model.list.count) {
                length = model.list.count - loction;
            }
            
            NSRange range = NSMakeRange(loction, length);
            NSArray * newArray = [model.list subarrayWithRange:range];
        
            if ([model.moduleKey isEqualToString:@"product_type_pushAndPull"] || [model.moduleKey isEqualToString:@"product_type_s"] || [model.moduleKey isEqualToString:@"product_type_flexible"] || [model.moduleKey isEqualToString:@"product_type_k"] || [model.moduleKey isEqualToString:@"product_type_invite"] ) {//推拉系列
                if (model.list.count % 2 == 0 ) {
                    KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                    cell.productType = KDSProduct_noraml;
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    cell.array = newArray;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSHomeOneItemCell * cell = [KDSHomeOneItemCell homeOneItemWithTableView:tableView];
                        cell.prouctType = KDSProduct_noraml;
                        cell.array = newArray;
                        return cell;
                    }else{
                        KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                        cell.productType = KDSProduct_noraml;
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        cell.array = newArray;
                        return cell;
                    }
                }
            }

            else if ([model.moduleKey isEqualToString:@"product_type_crowd"]){//今日众筹
                if (model.list.count % 2 == 0 ) {
                    KDSCrowdfundingTwoCell * cell = [KDSCrowdfundingTwoCell crowdfundingTwoCellWithTableView:tableView];
                    cell.array = newArray;
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSCrowdfundingOneCell * cell = [KDSCrowdfundingOneCell crowdfundingOneCellWithTableView:tableView];
                        cell.array = newArray;
                        return cell;
                    }else{
                        KDSCrowdfundingTwoCell * cell = [KDSCrowdfundingTwoCell crowdfundingTwoCellWithTableView:tableView];
                        cell.array = newArray;
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        return cell;
                    }
                }
            }else if ([model.moduleKey isEqualToString:@"product_type_group"]){//今日拼团
                if (model.list.count % 2 == 0 ) {
                    KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    cell.productType = KDSProduct_group;
                    cell.array = newArray;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSHomeOneItemCell * cell = [KDSHomeOneItemCell homeOneItemWithTableView:tableView];
                        cell.prouctType = KDSProduct_group;
                        cell.array = newArray;
                        return cell;
                    }else{
                        KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        cell.productType = KDSProduct_group;
                        cell.array = newArray;
                        return cell;
                    }
                }
            }else if ([model.moduleKey isEqualToString:@"product_type_seckill"]){//限时秒杀
                if (model.list.count % 2 == 0 ) {
                    KDSSeckillTwoItemCell * cell = [KDSSeckillTwoItemCell seckillTwoItemCellWithTableView:tableView];
                    cell.array = newArray;
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSSeckillOneItemCell * cell = [KDSSeckillOneItemCell seckillOneItemCellWithTableView:tableView];
                        cell.array = newArray;
                        return cell;
                    }else{
                        KDSSeckillTwoItemCell * cell = [KDSSeckillTwoItemCell seckillTwoItemCellWithTableView:tableView];
                         cell.array = newArray;
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        return cell;
                    }
                }
            }else if ([model.moduleKey isEqualToString:@"product_type_bargain"]){//砍价
                if (model.list.count % 2 == 0 ) {
                    KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                    cell.productType = KDSProduct_bargain;
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    cell.bargainArray = newArray;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSHomeOneItemCell * cell = [KDSHomeOneItemCell homeOneItemWithTableView:tableView];
                        cell.prouctType = KDSProduct_bargain;
                        cell.bargainArray = newArray;
                        return cell;
                    }else{
                        KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                        cell.productType = KDSProduct_bargain;
                        cell.bargainArray = newArray;
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        return cell;
                    }
                }
            }else{
                if (model.list.count % 2 == 0 ) {
                    KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                    cell.productType = KDSProduct_noraml;
                    cell.delegate = self;
                    cell.indexPath = indexPath;
                    cell.array = newArray;
                    return cell;
                }else{
                    if (indexPath.row == 0) {
                        KDSHomeOneItemCell * cell = [KDSHomeOneItemCell homeOneItemWithTableView:tableView];
                        cell.prouctType = KDSProduct_noraml;
                        cell.array = newArray;
                        return cell;
                    }else{
                        KDSHomeTwoItemCell * cell = [KDSHomeTwoItemCell homeTwoItemWithTableView:tableView];
                        cell.productType = KDSProduct_noraml;
                        cell.delegate = self;
                        cell.indexPath = indexPath;
                        cell.array = newArray;
                        return cell;
                    }
                }
            }
    }
 
}

#pragma mark - KDSHomeHeaderViewDelegate  进入商品列表 （普通  活动 秒杀 拼团 砍价）
-(void)homeHeaderViewBGClick:(NSInteger)section{
  
    KDSSecondPartModel * model = self.dataArray[section - 1];

    if ([model.moduleKey isEqualToString:@"product_type_pushAndPull"]|| [model.moduleKey isEqualToString:@"product_type_s"]) {//推拉
        KDSProductCategoryController  * productCategoryVC = [[KDSProductCategoryController alloc]init];
//        KDSProductCategoryVC  * productCategoryVC = [[KDSProductCategoryVC alloc]init];
        productCategoryVC.titleStr = model.moduleName;
        productCategoryVC.ID = -1;
        productCategoryVC.type = @"product_type_s";
        productCategoryVC.isActivity = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productCategoryVC animated:YES];

    }else if ([model.moduleKey isEqualToString:@"product_type_flexible"]|| [model.moduleKey isEqualToString:@"product_type_k"]){//灵动
        KDSProductCategoryController  * productCategoryVC = [[KDSProductCategoryController alloc]init];
//        KDSProductCategoryVC  * productCategoryVC = [[KDSProductCategoryVC alloc]init];
        productCategoryVC.titleStr = model.moduleName;
        productCategoryVC.ID = -1;
        productCategoryVC.type = @"product_type_k";
        productCategoryVC.isActivity = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productCategoryVC animated:YES];

    }else if ([model.moduleKey isEqualToString:@"product_type_invite"]){
        KDSProductCategoryController  * productCategoryVC = [[KDSProductCategoryController alloc]init];
        //        KDSProductCategoryVC  * productCategoryVC = [[KDSProductCategoryVC alloc]init];
        productCategoryVC.titleStr = model.moduleName;
        productCategoryVC.ID = -1;
        productCategoryVC.type = @"product_type_invite";
        productCategoryVC.isActivity = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productCategoryVC animated:YES];

    }else if ([model.moduleKey isEqualToString:@"product_type_crowd"]){//今日众筹
//        KDSCrowfundingListController * CrowfundingVC = [[KDSCrowfundingListController alloc]init];
//        [self.navigationController pushViewController:CrowfundingVC animated:YES];
    }else if ([model.moduleKey isEqualToString:@"product_type_group"]){//今日拼团
//        KDSGroupController * groupList = [[KDSGroupController alloc]init];
//        [self.navigationController pushViewController:groupList animated:YES];
    }else if ([model.moduleKey isEqualToString:@"product_type_seckill"]){//限时秒杀
//        KDSSeckillController * crowfundingListVC = [[KDSSeckillController alloc]init];
//        [self.navigationController pushViewController:crowfundingListVC animated:YES];
    }else if ([model.moduleKey isEqualToString:@"product_type_bargain"]){
//        NSLog(@"砍价列表");
//        KDSBargainListController * bargainingListVC = [[KDSBargainListController  alloc]init];
//        [self.navigationController pushViewController:bargainingListVC animated:YES];

    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        KDSHomeHeaderView * headerView = [KDSHomeHeaderView homeHeaderViewWithTableView:tableView];
        headerView.delegate = self;
        headerView.section = section;
        
        KDSSecondPartModel * model = self.dataArray[section - 1];
        headerView.titleString = model.moduleName;
        return headerView;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01f;
    }else{
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - 搜索 提醒 点击  代理 KDSSearchViewDelegate
-(void)searchViewButtonClick:(KDSSearchButtonType)buttonType{
    switch (buttonType) {
        case KDSSearchButtonType_search:{//进入搜索
            KDSHomeSearchController * homeSearchVC = [[KDSHomeSearchController alloc]init];
            homeSearchVC.hidesBottomBarWhenPushed = YES;//底部栏隐藏
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homeSearchVC animated:NO];

        }
            
            break;
        case KDSSearchButtonType_more:{//更多
            
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
            if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//                WxLoginController * wxloginVC = [[WxLoginController alloc]init];
                KDSLoginViewController * wxloginVC = [[KDSLoginViewController alloc]init];

                [self presentViewController:wxloginVC animated:YES completion:^{}];
                return;
            }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
                //                KDSBindingPhoneNumController * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
                //                [self presentViewController:bindPhoneVC animated:YES completion:^{}];
                //                return;
            }else{

            }
            
            __weak typeof(self)weakSelf = self;
            [KDSHomeMoreAlertController homeMoreShowView:_searchView.moreButton homeMoreClickBlock:^(NSInteger index) {
                switch (index) {
                        case 0:{//消息
                            KDSNewMessageCenterVC  * messageCenterVC = [[KDSNewMessageCenterVC alloc]init];
                            self.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:messageCenterVC animated:YES];

                        }
                        
                        break;
                        case 1:{//订单
                    
                            OrderListController * orderList = [[OrderListController alloc]init];
                            orderList.selectIndex = 0;
                            self.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:orderList animated:YES];

                        }
                        break;
                        case 2:{//反馈中心
                            KDSFeedbackController * feedBackVC = [[KDSFeedbackController alloc]init];
                            self.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:feedBackVC animated:YES];

                        }
                        break;
                        case 3:{//个人信息
                            KDSInformationController * informationVC = [[KDSInformationController alloc]init];
                            self.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:informationVC animated:YES];

                        }
                        break;
                        
                    default:
                        break;
                }
            }];
   
            return;
           
        }
            break;
            
        case KDSSearchButtonType_shopCart:{
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
            if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//                WxLoginController * wxloginVC = [[WxLoginController alloc]init];
                KDSLoginViewController * wxloginVC = [[KDSLoginViewController alloc]init];

                [self presentViewController:wxloginVC animated:YES completion:^{}];
                return;
            }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
//                KDSBindingPhoneNumController * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
//                [self presentViewController:bindPhoneVC animated:YES completion:^{}];
//                return;
            }else{
                
            }
            
            KDSShopCartController  * shopCartVC = [[KDSShopCartController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopCartVC animated:YES];

        }
            break;
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect headerRect = [self.tableView tableHeaderView].frame;
    
    if (scrollView.contentOffset.y > headerRect.size.height -  (isIPHONE_X ? 88 : 64)) {
        _searchView.bgAlphaScale = 1;
    }else{
        CGFloat scale = (scrollView.contentOffset.y + 0) / (headerRect.size.height -  (isIPHONE_X ? 88.0 : 64.0));
        _searchView.bgAlphaScale = scale;
    }
}

#pragma mark -  创建UI
-(void)createUI{
    //适配屏幕
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //添加搜索框
    _searchView = [[KDSSearchView alloc]init];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MnavcBarH);
    }];
    
    //客服button
    UIButton * serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceButton setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(serviceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-11);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-MtabBarH);
    }];
}
#pragma mark - 客服点击事件
-(void)serviceButtonClick{
    KDSOnlineServiceController * onlineServiceVC = [[KDSOnlineServiceController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:onlineServiceVC animated:YES];

}

-(void)homeBannerViewSelectItemAtIndex:(NSInteger)index{
    KDSFirstPartBannerModel * bannerModel = self.firstPartModel.banner[index];
    NSString * urlStr = @"";
    if ([bannerModel.bannerType isEqualToString:@"banner_type_product"]) {//跳转到商品详情
        KDSProductDetailNormalController * normalDetail = [[KDSProductDetailNormalController alloc]init];
        KDSSecondPartRowModel * rowModel = [[KDSSecondPartRowModel alloc]init];
        rowModel.ID = [bannerModel.bannerUrl integerValue];
        normalDetail.rowModel = rowModel;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:normalDetail animated:YES];

        
    }else{//跳转到网页
        if ([bannerModel.bannerType isEqualToString:@"banner_type_h5"]) {//H5跳转，直接取  bannerUrl  路径进行跳转
            urlStr = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:bannerModel.bannerUrl]];
        }else if ([bannerModel.bannerType isEqualToString:@"banner_type_information"]){//资讯详情页跳转，bannerUrl为资讯的id，跳转到资讯详情的H5页面
            urlStr = [NSString stringWithFormat:@"%@?id=%@&bannerType=%@",webBaseUrl,[KDSMallTool checkISNull:bannerModel.bannerUrl],[KDSMallTool checkISNull:bannerModel.bannerType]];
        }else if ([bannerModel.bannerType isEqualToString:@"banner_type_activity"]){//活动详情页跳转，bannerUrl为活动的id，跳转到活动详情的H5页面
            urlStr = [NSString stringWithFormat:@"%@activity?id=%@&bannerType=%@",webBaseUrl,[KDSMallTool checkISNull:bannerModel.bannerUrl],[KDSMallTool checkISNull:bannerModel.bannerType]];
        }
        
        WebViewController * webView = [[WebViewController alloc]init];
        webView.rightButtonHidden = YES;
        webView.url = urlStr;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webView animated:YES];

    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HOME_REFRESH_NOTIFICATION object:nil];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 150.0f;
        _tableView.estimatedSectionHeaderHeight = 150.0f;
        _tableView.tableHeaderView = self.bannerView;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MtabBarH, 0);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(homeRefresh)];
     
    }
    return _tableView;
}

-(KDSHomeBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[KDSHomeBannerView alloc]init];
        _bannerView.bounds = CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH);
        _bannerView.delegate = self;
    }
    return _bannerView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
