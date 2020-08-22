//
//  KDSProductDetailNormalController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailNormalController.h"
#import "KDSProductDetailNormalCell.h"
#import "KDSProductIntroduceCell.h"
#import "KDSProductServiceCell.h"
#import "KDSProductDetailEvaluateCell.h"
#import "KDSProductDetailCell.h"
#import "KDSProductSegmentView.h"
#import "KDSProductDetailBottomView.h"
#import "KDSHomeBannerView.h"
#import "KDSProductEvaluateHeaderView.h"
#import "GoodsDetailController.h"
#import "ShopCarDetailController.h"
#import "UIViewController+WPopver.h"
#import "KDSProductIntroduceAlert.h"
#import "KDSProductDetailEvaluateController.h"
#import "ShareSheetView.h"
#import "KDSProdutDetailHttp.h"
#import "KDSProductDetailHeaderView.h"
#import "KDSNodataEvaluateCell.h"
#import "KDSBindingPhoneNumController.h"
#import "DetailModel.h"
#import "KDSOnlineServiceController.h"
#import "KDSShopCartController.h"

#import "KDSLoginViewController.h"

@interface KDSProductDetailNormalController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSProductEvaluateHeaderViewDelegate,
KDSProductDetailNormalCellDelegate,
KDSProductServiceCellDelegate,
KDSProductDetailBottomViewDelegate
>
@property (nonatomic,strong)UITableView                  * tableView;
//分段控件
@property (nonatomic,strong)KDSProductSegmentView        * segmentView;
//右侧button
@property (nonatomic,strong)UIButton                     * rightButton;
@property (nonatomic,strong)KDSProductDetailBottomView   * bottomView;
@property (nonatomic,strong)KDSHomeBannerView            * bannerView;
@property (nonatomic,strong)DetailModel                  * AModel;
//详情model
@property (nonatomic,strong)KDSProductDetailModel        * detailModel;
@property (nonatomic,strong)NSMutableArray               * evaluateArray;
@property (nonatomic,assign)NSInteger                     evalutateCount;
@property (nonatomic,strong)NSMutableArray               * goodsParamArray;
@property (nonatomic,strong)NSMutableArray               * partmerArray;
//记录tableview滚动方向
@property (nonatomic,assign)BOOL                           isScrollUp;
//记录tableview的Y的滚动距离
@property (nonatomic,assign)CGFloat                        scrollY;
//是否手动拖拽tableview
@property (nonatomic,assign)BOOL                           isDragDrop;
@property (nonatomic,assign)BOOL                           isClickButton;
@property (nonatomic,copy)NSString                       * paramString;


@property (nonatomic,strong)GoodsDetailController   *detailVC;
@end

@implementation KDSProductDetailNormalController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建UI
    [self createUI];
    //请求商品详情
    [self requestDetailData];
    //商品评价列表 请求
    [self evaluateRequest];
//    //请求商品参数
//    [self goodsParamterReuqest];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGRect headerRect =      [self.tableView tableHeaderView].frame;
    if (scrollView.contentOffset.y > 250 -  (isIPHONE_X ? (88 + 22) : (64 + 10))) {
        self.navigationBarView.backImage = [UIImage imageNamed:@"icon_return"];
        [_rightButton setImage:[UIImage imageNamed:@"icon_share_detail_black"] forState:UIControlStateNormal];
        self.navigationBarView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.navigationBarView.lineColor = [UIColor hx_colorWithHexRGBAString:dividingCorlor];
        _segmentView.hidden = NO;
    }else{
        self.navigationBarView.backImage = [UIImage imageNamed:@"icon_back_detail"];
        [_rightButton setImage:[UIImage imageNamed:@"icon_share_detail"] forState:UIControlStateNormal];
        self.navigationBarView.backgroundColor = [UIColor clearColor];
        self.navigationBarView.lineColor = [UIColor clearColor];
        _segmentView.hidden = YES;
    }
    
    _isScrollUp = _scrollY < scrollView.contentOffset.y;
    _scrollY = scrollView.contentOffset.y;
    //NSLog(@"%d",_isScrollUp);

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"%s",__func__);
    _isDragDrop    = YES;
    _isClickButton = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    _isDragDrop = NO;
//    NSLog(@"%s",__func__);
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"%s--header  将要出现 %ld",__func__,section);
}

-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"%s--header  已经出现 %ld",__func__,section);
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"%s++footer  将要出现 %ld",__func__,section);
     //向下滚动&&不是点击顶部的button引起的滚动
    if (!_isScrollUp && !_isClickButton) {
        _segmentView.selectIndexViewController = section;
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"%s++footer  已经出现 %ld",__func__,section);
    //向上滚动&&不是点击顶部的button引起的滚动
    if (_isScrollUp && !_isClickButton) {
        _segmentView.selectIndexViewController = section + 1;
    }
}

#pragma mark - 创建UI -
-(void)createUI{
    
    //初始化默认值
    _isScrollUp = NO;
    _scrollY    = 0.0;
    _isClickButton = NO;
    
    //设置导航栏属性
    self.navigationBarView.backgroundColor = [UIColor clearColor];
    self.navigationBarView.lineColor = [UIColor clearColor];
    //
    self.navigationBarView.backImage = [UIImage imageNamed:@"icon_back_detail"];
    self.navigationBarView.backImageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_rightButton setImage:[UIImage imageNamed:@"icon_share_detail"] forState:UIControlStateNormal];
//    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBarView.rightItem = _rightButton;
    
    //分段控件
    _segmentView = [[KDSProductSegmentView alloc]initWithTitleArray:@[@"商品",@"评价",@"详情"]];
    _segmentView.bounds = CGRectMake(0, 0, 180, 44);
    _segmentView.hidden = YES;
    _segmentView.backgroundColor = [UIColor clearColor];
    self.navigationBarView.titleView = _segmentView;
    
    //底部控件
    CGFloat bottomViewHeight = 49;
    _bottomView = [[KDSProductDetailBottomView alloc]initWithType:KDSProductDetail_noraml];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomViewHeight);//
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
    
    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self.view bringSubviewToFront:self.navigationBarView];
    
    __weak typeof(self)weakSelf = self;
    _segmentView.segmentBtn = ^(NSInteger index, BOOL isClickButton) {
        if (index < 0) {
            return ;
        }
        if (index == 0) {
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            weakSelf.tableView.contentInset = UIEdgeInsetsMake((isIPHONE_X ? 44 : 44), 0, 0, 0);
        }
        weakSelf.isClickButton = isClickButton;
        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    };
    
    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

#pragma mark - 所有请求
#pragma mark - 商品详情 请求
-(void)requestDetailData{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params": @{@"id":@(_rowModel.ID)},  // int 必填 渠道商品id
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
//    NSLog(@"IDIIIIII:%ld",_ID);
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSProdutDetailHttp productDetailWithParams:dict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            weakSelf.detailModel = (KDSProductDetailModel *)obj;
            
            weakSelf.AModel.myId = [NSString stringWithFormat:@"%ld",(long)weakSelf.detailModel.ID];
            weakSelf.AModel.qty  = @"1";
            weakSelf.AModel.attributeComboName = weakSelf.detailModel.attributeComboName;
            NSMutableArray * bannerUrlArray = [NSMutableArray array];
            //轮播图图片
            for (KDSProductImageModel * imageModel in weakSelf.detailModel.banners) {
                [bannerUrlArray addObject:imageModel.imgUrl];
            }
            KDSHomeBannerView * bannerView = self.bannerView;//(KDSHomeBannerView *)self.tableView.tableHeaderView;
            bannerView.imageUrlArray = bannerUrlArray;
//            //修改收藏button的选中状态
            weakSelf.bottomView.collectState  = weakSelf.detailModel.colloctFlag;
            [weakSelf getSkuData];
            [weakSelf goodsParamterReuqest];
            
//          //下载图片
//            dispatch_group_t group = dispatch_group_create();
//            for (KDSProductImageModel  * imageModel in  weakSelf.detailModel.detailImgs) {
//                dispatch_group_enter(group);
//                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:imageModel.imgUrl]] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
////                        NSLog(@"第%d --image:%@  ---- error:%@   finished:%d",i,image,error,finished);
//                        if (!error && image) {
//                            [[SDImageCache sharedImageCache] storeImage:image forKey:imageModel.imgUrl completion:^{}];
//                        }
//                        dispatch_group_leave(group);
//                    }];
//                });
//            }
            
            //等待所有图片下载完成执行的操作
//            dispatch_group_notify(group, dispatch_get_main_queue(), ^{});
            
            //刷新tableview
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 商品评价列表 请求
-(void)evaluateRequest{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params": @{@"id":@(_rowModel.ID)},
                            @"page":@{
                                    @"pageNum": @(1),
                                    @"pageSize": @(1)
                                    },
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProdutDetailHttp productEvaluateDetailWithParams:dict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            KDSProductEvaluateModel * model = (KDSProductEvaluateModel *)obj;
            weakSelf.evalutateCount = model.total;
            [weakSelf.evaluateArray removeAllObjects];
            [weakSelf.evaluateArray addObjectsFromArray:model.list];
            
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 请求商品参数
-(void)goodsParamterReuqest{
    if (_detailModel == nil) {
        return;
    }
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{@"params":@{ @"id":_detailModel.productId}, // int 必填  商品id
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    __weak typeof(self)weakSelf = self;
    [KDSProdutDetailHttp getParameterAppWithParams:dict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            _goodsParamArray = (NSMutableArray *)obj;
            
            NSMutableString * string = [NSMutableString string];
            for (int i = 0; i < _goodsParamArray.count; i++) {
                NSDictionary * dict = _goodsParamArray[i];
                NSString * name = [NSString stringWithFormat:@"%@  ",[KDSMallTool checkISNull:dict[@"name"]]];
//                NSString * value = [NSString stringWithFormat:@"%@ ",[KDSMallTool checkISNull:dict[@"value"]]];
                [string appendString:name];
//                [string appendString:value];
            }
            
            weakSelf.paramString = string;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 商品种类 获取商品属性组合名称
-(void)getSkuData{
    self.partmerArray = [NSMutableArray array];
    NSDictionary * dic = @{@"params": @{ @"id":_detailModel.productId },@"token":[KDSMallTool checkISNull:[KDSMallTool checkISNull:ACCESSTOKEN]] };
    __weak typeof(self)weakSelf = self;
    [JavaNetClass JavaNetRequestWithPort:@"front/product/getSku" andPartemer:dic Success:^(id responseObject) {
        NSLog(@"参数数据=%@",responseObject);
        NSString *code = [NSString stringWithFormat:@"%@" ,[responseObject objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSMutableArray *dataArr =  [responseObject objectForKey:@"data"] ;
            for (NSDictionary *dataDic in dataArr) {
                DetailModel * model = [[DetailModel alloc]initWithDictionary:dataDic];
                [weakSelf.partmerArray addObject:model];
            }
        }
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return 1;//self.evaluateArray.count == 0 ? 1 : self.evaluateArray.count;
    }else{
        return self.detailModel.detailImgs.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            KDSProductDetailNormalCell * cell = [KDSProductDetailNormalCell productDetailNormalCellWithTableView:tableView];
            cell.delegate = self;
            cell.detailModel = self.detailModel;
            return cell;
        }else if (indexPath.row == 1) {
            KDSProductIntroduceCell * cell = [KDSProductIntroduceCell ProductIntroducCelleWithTableView:tableView];
            cell.indexPath = indexPath;
            cell.titleString = @"选择";
            cell.detailString = self.AModel.attributeComboName;
            return cell;
        }else if (indexPath.row == 2){
            KDSProductIntroduceCell * cell = [KDSProductIntroduceCell ProductIntroducCelleWithTableView:tableView];
            cell.indexPath = indexPath;
            cell.titleString = @"参数";
            cell.detailString = _paramString;
            return cell;
        }else{
            KDSProductServiceCell * cell = [KDSProductServiceCell productServiceCellWithTableView:tableView];
            cell.indexPath = indexPath;
            cell.titleString = @"服务";
            cell.delegate = self;
            return cell;
        }

    }else if(indexPath.section == 1){
        
        if (self.evaluateArray.count > 0) {
            KDSProductDetailEvaluateCell * cell = [KDSProductDetailEvaluateCell producDetailtEvaluteCellWithTableView:tableView];
            cell.rowModel = self.evaluateArray[indexPath.row];
            if (indexPath.row == 0) {
                cell.hiddenBoldDividing = YES;
            }else{
                cell.hiddenBoldDividing = NO;
            }
            return cell;
        }else{
           KDSNodataEvaluateCell * cell = [KDSNodataEvaluateCell nodataEvaluateWithTableView:tableView];
            return cell;
        }
        
      
    }else{
        KDSProductDetailCell * cell = [KDSProductDetailCell productDetailCellWithTableView:tableView];
        KDSProductImageModel *imageModel  = self.detailModel.detailImgs[indexPath.row];
        NSString * imageString = imageModel.imgUrl;
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:placeholder_h]];
//        [self configureCell:cell aiIndexPath:indexPath];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        KDSProductImageModel *imageModel  = self.detailModel.detailImgs[indexPath.row];
        NSString * imageString = imageModel.imgUrl;
        UIImage * image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageString];
        if (!image) {
            image = [UIImage imageNamed:placeholder_h];
        }
        CGFloat imageHeight = image.size.height * KSCREENWIDTH / image.size.width;
        return imageHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        KDSProductEvaluateHeaderView * headerView = [KDSProductEvaluateHeaderView productEvaluteHeaderViewWithTableView:tableView];
        headerView.delegate = self;
        headerView.titleLb.text = [NSString stringWithFormat:@"商品评价(%ld)",(long)_evalutateCount];
        return headerView;
    }else if (section == 0){
       return  self.bannerView;
    }
    else{
        KDSProductDetailHeaderView * headerView = [KDSProductDetailHeaderView productDetailWithTableView:tableView];
        
        return headerView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return KSCREENWIDTH;
    }
    else if (section == 1) {
        return 70.0f;
    }else{
        return 60.0f;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {//选择 弹框
            if (self.partmerArray.count <1) {
                [KDSProgressHUD showFailure:@"暂无数据" toView:self.view completion:^{
                }];
                return;
            }
            
            CGFloat ahh = 450;
//            GoodsDetailController *detailVC = [[GoodsDetailController alloc]init];
            self.detailVC.type = KDSProductDetail_noraml;
            self.detailVC.dataArray = self.partmerArray;
            self.detailVC.contentH = ahh;
           
             __weak typeof(self)weakSelf = self;
            self.detailVC.selectBlock = ^(DetailModel *amodel) {
                weakSelf.AModel = amodel;
                KDSProductIntroduceCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.detailString = weakSelf.AModel.attributeComboName;
                
                KDSProductDetailNormalCell * zeroCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                NSString * productName = [NSString stringWithFormat:@"%@ %@",weakSelf.AModel.name,weakSelf.AModel.skuName];
                NSString * productName = [NSString stringWithFormat:@"%@",weakSelf.AModel.name];
                zeroCell.productName = productName;
                weakSelf.detailModel.price = amodel.price;
                weakSelf.detailModel.name = productName;
                weakSelf.detailModel.oldPrice = amodel.oldPrice;
                
                [UIView performWithoutAnimation:^{
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }];

            };
            
            self.detailVC.selBlock = ^(DetailModel *amodel, NSInteger index) {
                NSLog(@"选中参数model=%@" ,amodel);
                NSLog(@"name=%@" ,amodel.attributeComboName);
                NSLog(@"qty=%@" ,amodel.qty);
                NSLog(@"index=%ld" ,(long)index);
                
                NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
                QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
                if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//                    WxLoginController * wxloginVC = [[WxLoginController alloc]init];
                    KDSLoginViewController * wxloginVC = [[KDSLoginViewController alloc]init];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:wxloginVC animated:YES completion:^{}];
                    });
                    return;
                }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
                    /*
                    KDSBindingPhoneNumController * bind = [[KDSBindingPhoneNumController alloc]init];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:bind animated:YES completion:^{}];
                    });
                    
                    return;
                     */
                }else{
                    
                }
                
                NSDictionary * params = @{@"agentProductId": amodel.myId,@"qty":amodel.qty};
                NSMutableDictionary * newDict = [NSMutableDictionary dictionary];
                if (index == 1) {
                    [newDict setValue:@"to_buy" forKey:@"type"];
                }
                [newDict addEntriesFromDictionary:params];
                
                NSDictionary * paramDict = @{@"params":newDict,
                                                @"token":[KDSMallTool checkISNull:userToken]
                                                };
            
               
                [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
                [KDSProdutDetailHttp addShopCartProductWithParams:paramDict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
                    [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
                    if (isSuccess) {
                        weakSelf.AModel = amodel;
                        NSLog(@"======: %@----%@",weakSelf.AModel.myId,weakSelf.AModel.attributeComboName);
                        KDSProductIntroduceCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                        cell.detailString = weakSelf.AModel.attributeComboName;
                        [KDSProgressHUD showSuccess:@"添加成功" toView:weakSelf.view completion:^{}];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                        
                        switch (index) {
                            case 0:{//加入购物车
                                
                            }
                                break;
                            case 1:{//立即购买
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSString * ID = obj[@"data"][@"id"];
                                    ShopCarDetailController *shopCarDetailVC=[[ShopCarDetailController alloc]init];
                                    shopCarDetailVC.type = KDSProductDetail_noraml;
                                    shopCarDetailVC.productIDArray = [NSMutableArray arrayWithObject:ID];
                                    [weakSelf.navigationController pushViewController:shopCarDetailVC animated:YES];
                                });
                               
                            }
                                
                            default:
                                break;
                        }
                        
                    }else{
                        [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
                    }
                } failure:^(NSError * _Nonnull error) {
                    [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
                    [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
                }];
                
            };
             [self yc_bottomPresentController:self.detailVC presentedHeight:ahh completeHandle:nil];
        }else if (indexPath.row == 2){//参数  弹框
            if (self.goodsParamArray) {
                [KDSProductIntroduceAlert productIntroduceShow:KDSProductIntroduceAlert_parameter dataArray:self.goodsParamArray];
            }else{
                [KDSProgressHUD showFailure:@"参数错误" toView:self.view completion:^{}];
                [self goodsParamterReuqest];
            }
        }else if (indexPath.row == 3){
            [KDSProductIntroduceAlert productIntroduceShow:KDSProductIntroduceAlert_serveice dataArray:nil];
        }
    }
}


#pragma mark - KDSProductDetailBottomViewDelegate
-(void)productDetailBottomViewViewType:(KDSProductDetailBottomType)viewType buttonType:(KDSProductBottomButtonType)buttonType{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
        if (buttonType == KDSProductBottom_service) {
            KDSOnlineServiceController * onlineVC = [[KDSOnlineServiceController alloc] init];
            [self.navigationController pushViewController:onlineVC animated:YES];
            return;
        }else{
//            WxLoginController * wxloginVC = [[WxLoginController alloc]init];
            KDSLoginViewController * wxloginVC = [[KDSLoginViewController alloc]init];

            [self presentViewController:wxloginVC animated:YES completion:^{}];
            self.bottomView.collectState = _detailModel.colloctFlag;
            return;
        }
    }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
        
    }else{
        
    }
    switch (buttonType) {
        case KDSProductBottom_service:{//客服
//            KDSTabBarController *rootViewController =(KDSTabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
//            rootViewController.selectedIndex = 4;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            UINavigationController * nvc = rootViewController.viewControllers[4];
//            KDSOnlineServiceController * onlineVC = [[KDSOnlineServiceController alloc] init];
//            [nvc pushViewController:onlineVC animated:YES];
            KDSOnlineServiceController * onlineVC = [[KDSOnlineServiceController alloc] init];
            [self.navigationController pushViewController:onlineVC animated:YES];
        }
            break;
        case KDSProductBottom_collect:{//收藏
            if (_detailModel== nil) {
                return;
            }
            if (_detailModel.colloctFlag) {//取消收藏
                [self cancelCollectRequest];
            }else{//添加收藏
                [self addCollectRequest];
            }
        }
            
            break;
        case KDSProductBottom_shopCart:{//购物车
            NSLog(@"购物车");
//            self.tabBarController.selectedIndex = 2;
//            [self.navigationController popViewControllerAnimated:NO];
            KDSShopCartController * shopCarVC = [[KDSShopCartController alloc]init];
            [self.navigationController pushViewController:shopCarVC animated:YES];
        }
            
            break;
        case KDSProductBottom_addCart:{//加入购物车
            [self addShopCartAndBuy];
        }
            
            break;
        case KDSProductBottom_buy:{//立即购买
            if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
                /*
                KDSBindingPhoneNumController * bind = [[KDSBindingPhoneNumController alloc]init];
                [self presentViewController:bind animated:YES completion:^{}];
                return;
                 */
            }
            
            [self addShopCartAndBuy];
        }
            
            break;
        default:
            break;
    }
}
#pragma mark - 添加收藏 请求
-(void)addCollectRequest{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramsDict = @{@"params":@{
                                          @"agentProductId":[KDSMallTool checkISNull:[NSString stringWithFormat:@"%ld",self.detailModel.ID]]
                                          },
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    
    __weak typeof(self)weakSelf = self;
    [KDSProdutDetailHttp addCollectProductWithParams:paramsDict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [KDSProgressHUD showSuccess:@"收藏成功" toView:weakSelf.view completion:^{
                
            }];
            weakSelf.detailModel.colloctFlag = 1;
            weakSelf.bottomView.collectState = YES;
        }else{
            weakSelf.bottomView.collectState = NO;
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        weakSelf.bottomView.collectState = NO;
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 取消收藏 请求
-(void)cancelCollectRequest{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramsDict = @{@"params":@{
                                          @"agentProductId":[KDSMallTool checkISNull:[NSString stringWithFormat:@"%ld",self.detailModel.ID]]
                                          },
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSProdutDetailHttp cancelCollectProductWithParams:paramsDict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [KDSProgressHUD showSuccess:@"取消收藏成功" toView:weakSelf.view completion:^{
                
            }];
            weakSelf.detailModel.colloctFlag = 0;
            weakSelf.bottomView.collectState = NO;
        }else{
            weakSelf.bottomView.collectState = YES;
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        weakSelf.bottomView.collectState = YES;
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 添加购物车 购买
-(void)addShopCartAndBuy{
    
    QZUserModel * userModel  = [QZUserArchiveTool loadUserModel];
    
    if (self.partmerArray.count <1) {
        [KDSProgressHUD showFailure:@"暂无数据" toView:self.view completion:^{
        }];
        return;
    }
    NSLog(@"partmerArray:%@",self.partmerArray);
    CGFloat ahh = 450;
//    GoodsDetailController *detailVC = [[GoodsDetailController alloc]init];
    self.detailVC.type = KDSProductDetail_noraml;
    self.detailVC.dataArray = self.partmerArray;
    self.detailVC.contentH = ahh;
    
     __weak typeof(self)weakSelf = self;
    self.detailVC.selectBlock = ^(DetailModel *amodel) {
        weakSelf.AModel = amodel;
        KDSProductIntroduceCell * cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.detailString = weakSelf.AModel.attributeComboName;
        
        KDSProductDetailNormalCell * zeroCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        NSString * productName = [NSString stringWithFormat:@"%@ %@",weakSelf.AModel.name,weakSelf.AModel.skuName];
        NSString * productName = [NSString stringWithFormat:@"%@",weakSelf.AModel.name];
        zeroCell.productName = productName;
        weakSelf.detailModel.name = productName;
        weakSelf.detailModel.price = amodel.price;
        weakSelf.detailModel.oldPrice = amodel.oldPrice;

        [UIView performWithoutAnimation:^{
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    };
    
    self.detailVC.selBlock = ^(DetailModel *amodel, NSInteger index) {
        NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        if (index == 1) {
            if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
                /*
                KDSBindingPhoneNumController * bindPhoneVC  = [[KDSBindingPhoneNumController alloc]init];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf presentViewController:bindPhoneVC animated:YES completion:^{}];
                });
                return;
                 */
            }
        }
        NSDictionary * params = @{@"agentProductId": amodel.myId,@"qty":amodel.qty};
        NSMutableDictionary * newDict = [NSMutableDictionary dictionary];
        if (index == 1) {
            [newDict setValue:@"to_buy" forKey:@"type"];
        }
        [newDict addEntriesFromDictionary:params];
        
        NSDictionary * paramDict =   @{@"params":newDict,
                                       @"token":[KDSMallTool checkISNull:userToken]
                                       };
        
        [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
        [KDSProdutDetailHttp addShopCartProductWithParams:paramDict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
            [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
            if (isSuccess) {
//                weakSelf.AModel = amodel;
                NSLog(@"======: %@----%@",weakSelf.AModel.myId,weakSelf.AModel.attributeComboName);
//                [weakSelf.tableView reloadData];
                 weakSelf.AModel = amodel;
                KDSProductIntroduceCell * cell = [ weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.detailString =  weakSelf.AModel.attributeComboName;
                
//
                [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                
                switch (index) {
                    case 0:{//加入购物车
                         [KDSProgressHUD showSuccess:@"添加成功" toView:weakSelf.view completion:^{}];
                    }
                        break;
                    case 1:{//立即购买
                        NSString * ID = obj[@"data"][@"id"];
                        ShopCarDetailController *shopCarDetailVC=[[ShopCarDetailController alloc]init];
                        shopCarDetailVC.type = KDSProductDetail_noraml;
                        shopCarDetailVC.productIDArray = [NSMutableArray arrayWithObject:ID];
                        [weakSelf.navigationController pushViewController:shopCarDetailVC animated:YES];
                    }
                        
                    default:
                        break;
                }
                
            }else{
                [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
            }
        } failure:^(NSError * _Nonnull error) {
            [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
            [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
        }];
        
    };
    
    [self yc_bottomPresentController:self.detailVC presentedHeight:ahh completeHandle:nil];
    
}

#pragma mark - KDSProductServiceCellDelegate
-(void)productServiceCellButtonClick:(NSInteger)index{
    [KDSProductIntroduceAlert productIntroduceShow:KDSProductIntroduceAlert_serveice dataArray:nil];
}

#pragma mark - KDSProductDetailNormalCellDelegate  领券 点击代理
-(void)productDetailPreferentialButtonClick{
    NSLog(@"领券");
}

#pragma mark - KDSProductEvaluateHeaderViewDelegate
-(void)productEvaluateBgButtonClick{
    KDSProductDetailEvaluateController  * evaluateVC = [[KDSProductDetailEvaluateController alloc]init];
    evaluateVC.productModel = _rowModel;
    evaluateVC.navigationBarView.backTitle = @"评论";
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

#pragma mark - 懒加载tableview
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = 100.0f;
//        _tableView.estimatedSectionFooterHeight = 10;
//        _tableView.tableHeaderView = self.bannerView;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}
-(KDSHomeBannerView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[KDSHomeBannerView alloc]init];
        _bannerView.bounds = CGRectMake(0, 0, KSCREENWIDTH, KSCREENWIDTH);
    }
    return _bannerView;
}

-(NSMutableArray *)evaluateArray{
    if (_evaluateArray == nil) {
        _evaluateArray = [NSMutableArray array];
    }
    return _evaluateArray;
}
-(DetailModel *)AModel{
    if (_AModel == nil) {
        _AModel = [[DetailModel alloc]init];
    }
    return _AModel;
}
-(GoodsDetailController *)detailVC{
    if (_detailVC == nil) {
        _detailVC = [[GoodsDetailController alloc]init];
    }
    return _detailVC;
}

//#pragma mark - 所有点击事件
//#pragma mark  分享点击事件
//-(void)rightButtonClick{
//    NSLog(@"分享");
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//
//    if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//        WxLoginController * wxloginVC = [[WxLoginController alloc]init];
//        [self presentViewController:wxloginVC animated:YES completion:^{}];
//        return;
//    }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
//        KDSBindingPhoneNumController * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
//        [self presentViewController:bindPhoneVC animated:YES completion:^{}];
//        return;
//    }else{
//
//    }
//    __weak typeof(self)weakSelf = self;
//    ShareSheetView * shareV = [[ShareSheetView alloc]initWithTitle:@"微信好友" rightTitles:@"朋友圈"];
//    shareV.btnBlock = ^(int index) {
//        //分享记录请求
//        [weakSelf shareSave];
//
//        if(![WXApi isWXAppInstalled]){
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请安装微信客户端" preferredStyle: UIAlertControllerStyleAlert];
//            [alert addAction:[ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            }]];
//            [weakSelf presentViewController:alert animated:true completion:nil];
//            return ;
//        }
//
//        WXMediaMessage *message = [WXMediaMessage message];
//
//        //分享图文链接
////        message.title = _detailModel.name;//标题
//        message.description = _detailModel.name;//描述
//        [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[KDSMallTool checkISNull:_detailModel.logo]]] scale:0.5]];//缩略图˜
//        WXWebpageObject *webObj = [WXWebpageObject object];
//        NSString * webUrl = [NSString stringWithFormat:@"%@id=%ld&customerId=%ld&status=%@&activityProductId=%@",productdetailUrl,_detailModel.ID,(long)userModel.ID,@"null",@"null"];
//        webObj.webpageUrl = webUrl;
//        message.mediaObject = webObj;
//        NSLog(@"webUrl:%@",webUrl);
//        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
//        sendReq.bText = NO;
//        sendReq.message = message;
//        sendReq.scene = index;
//        [WXApi sendReq:sendReq];
//
//    };
//    [shareV show];
//
//}

//#pragma mark - 分享记录
//-(void)shareSave{
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    NSDictionary * dict = @{@"params":@{
//                                @"type":@"share_type_product", //类型（商品，活动，文章）
//                                @"businessId":@(self.detailModel.ID) //分享的类容编号
//                            },
//                            @"token": [KDSMallTool checkISNull:userToken]
//    };
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:shareSave paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            NSLog(@"分享记录成功");
//        }else{
//            NSLog(@"分享记录失败");
//        }
//    } failure:^(NSError * _Nullable error) {
//        NSLog(@"分享记录成功%@",error);
//    }];
//}

@end
