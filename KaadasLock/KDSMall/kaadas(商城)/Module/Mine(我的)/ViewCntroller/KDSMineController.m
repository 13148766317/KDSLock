//
//  KDSMineController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMineController.h"
#import "KDSMineNavigationBar.h"
#import "KDSMineInfoCell.h"
#import "KDSMineMyOrderCell.h"
#import "KDSMineAssetsCell.h"
#import "KDSMineUnlockAmountCell.h"
#import "KDSMineFunctionCell.h"
#import "KDSMineFunctionCell.h"
#import "KDSSpreadCell.h"


#import "KDSMessageCenterController.h"
#import "KDSNewMessageCenterVC.h"
#import "KDSMyAssetsController.h"
#import "KDSInformationController.h"
#import "KDSMyQRCodeController.h"
#import "KDSSettingsController.h"
//#import "KDSMyPostController.h"
//#import "KDSBargainingController.h"
#import "KDSMyCollectController.h"
#import "KDSMyFootPrintController.h"
#import "KDSDiscountCouponController.h"
#import "KDSFeedbackController.h"
//#import "KDSNearShopController.h"
#import "KDSMyAssignmentController.h"
#import "OrderListController.h"
#import "AfterSaleController.h"
#import "ComentController.h"
//#import "KDSNearShopListController.h"
#import "KDSBindingPhoneNumController.h"
#import "KDSOnlineServiceController.h"
#import "KDSIntergralDetailController.h"
//#import "KDSAmbassadorController.h"

#import "KDSMineHttp.h"



@interface KDSMineController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSMineInfoCellDelegate,
KDSMineOrderCellDelegate,
KDSMineAssetsCellDelegate,
KDSMineUnlockAmountCellDelegate,
KDSMineFunctionCellDelegate,
KDSSpreadCellDelegate
>

@property (nonatomic,strong)UITableView          * tableView;
//导航栏
@property (nonatomic,strong)KDSMineNavigationBar   * navigationBar;
@property (nonatomic,strong)QZUserModel   * userModel;
@end

@implementation KDSMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UI
    [self createUI];
    
    _userModel = [QZUserArchiveTool loadUserModel];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData];
    //获取个人信息
    [self getMineInfo];
}

//获取个人信息
-(void)getMineInfo{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{
                                  @"params":@{},
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    
    __weak typeof(self)weakSelf = self;
    
    [KDSMineHttp mineInfoWithParams:dictionary  success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.userModel = (QZUserModel *)obj;
            [weakSelf.tableView reloadData];
        }else{
           
        }
    } failure:^(NSError * _Nonnull error) {
       
    }];
}
#pragma mark - 创建UI
-(void)createUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        KDSMineInfoCell * cell = [KDSMineInfoCell MineInfoWithTableView:tableView];
        [cell refreshData];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1){//全部订单
        KDSMineMyOrderCell * cell = [KDSMineMyOrderCell mineMyOrderCellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2){//我的资产
        KDSMineAssetsCell * cell = [KDSMineAssetsCell mineAssetsCellWithTableView:tableView];
        [cell refreshData];
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 3){
//        KDSMineUnlockAmountCell * cell = [KDSMineUnlockAmountCell mineUnlockAmountCellWithTableView:tableView];
//        cell.delegate = self;
//        return cell;
        KDSSpreadCell  * cell = [KDSSpreadCell spreadCellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 4){
        KDSMineFunctionCell * cell = [KDSMineFunctionCell mineFunctionCellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    else{
        static NSString * cellID = @"cellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        KDSInformationController * informationVC = [[KDSInformationController alloc]init];
        [self.navigationController pushViewController:informationVC animated:YES];
    }else if (indexPath.row == 3){
        [self spreadCellButtonClick];
    }
}

#pragma mark - KDSSpreadCellDelegate
-(void)spreadCellButtonClick{
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//
//    if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//        WxLoginController * wxloginVC = [[WxLoginController alloc]init];
//        [self presentViewController:wxloginVC animated:YES completion:^{
//
//        }];
//        return;
//    }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
//        KDSBindingPhoneNumController * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
//        [self presentViewController:bindPhoneVC animated:YES completion:^{ }];
//        return;
//    }else{
//
//    }
//
//    KDSAmbassadorController  * ambassadorVC = [[KDSAmbassadorController alloc]init];
//    [self.navigationController pushViewController:ambassadorVC animated:YES];
//
}

#pragma mark - 设置 消息 头像 二维码 点击代理 KDSMineInfoCellDelegate
-(void)mineInfoCellEventType:(KDSMineInfoEventType)type{
    switch (type) {
        case KDSMineInfoEvent_icon:{//头像
        
        }
            break;
        case KDSMineInfoEvent_setting:{//设置
            KDSSettingsController * settingsVC = [[KDSSettingsController alloc]init];
            [self.navigationController pushViewController:settingsVC animated:YES];
        }
            break;
        case KDSMineInfoEvent_message:{//消息
            KDSNewMessageCenterVC  * messageCenterVC = [[KDSNewMessageCenterVC alloc]init];
            [self.navigationController pushViewController:messageCenterVC animated:YES];
        }
            break;
        case KDSMineInfoEvent_QRCode:{//二维码
            KDSMyQRCodeController  * myQRcodeVC = [[KDSMyQRCodeController alloc]init];
            [self.navigationController pushViewController:myQRcodeVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - KDSMineOrderCellDelegate
-(void)mineOrderEventType:(KDSMyOrderEventType)type{
    switch (type) {
        case KDSMyOrderEvent_allOrder:{//全部订单
            NSLog(@"全部订单");
            OrderListController *listVC=[[OrderListController alloc]init];
            listVC.selectIndex = 0;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
        case KDSMyOrderEvent_unPay:{//待支付
            NSLog(@"待支付");
            OrderListController *listVC=[[OrderListController alloc]init];
            listVC.selectIndex = 1;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;

        case KDSMyOrderEvent_unInstall:{//待安装
            NSLog(@"待安装");
            OrderListController *listVC=[[OrderListController alloc]init];
            listVC.selectIndex = 2;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
        case KDSMyOrderEvent_unEvaluate:{//待评价
            NSLog(@"待评价");
            OrderListController *listVC=[[OrderListController alloc]init];
            listVC.selectIndex = 3;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
        case KDSMyOrderEvent_refundAfter:{//退款售后
            NSLog(@"退款售后");   
            AfterSaleController *afterVC=[[AfterSaleController alloc]init];
            [self.navigationController pushViewController:afterVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)mineAssetsCellEvent:(KDSMineAssetsEventType)type{
    switch (type) {
        case KDSMineAssetsEvent_myAssets:{//我的资产
            KDSMyAssetsController * myAssetsVC = [[KDSMyAssetsController alloc]init];
            [self.navigationController pushViewController:myAssetsVC animated:YES];
        }
            break;
        case KDSMineAssetsEvent_assignment:{//任务
            KDSMyAssignmentController * myAssigmentVC = [[KDSMyAssignmentController alloc]init];
            [self.navigationController pushViewController:myAssigmentVC animated:YES];
        }
            break;
        case KDSMineAssetsEvent_discountCoupon:{//优惠券
            KDSDiscountCouponController * discountCouponVC = [[KDSDiscountCouponController alloc]init];
            [self.navigationController pushViewController:discountCouponVC animated:YES];
        }
            break;
        case KDSMineAssetsEvent_integral:{//积分
            KDSIntergralDetailController * intergralDetailVC = [[KDSIntergralDetailController alloc]init];
            [self.navigationController pushViewController:intergralDetailVC animated:YES];
            
//            [KDSProgressHUD showFailure:@"暂未开放" toView:self.view completion:^{}];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 待解锁金额 事件点击代理 KDSMineUnlockAmountCellDelegate
-(void)mineUnlockAmountCellEventClick:(KDSMineUnlockAmountEventType)type{
    switch (type) {
        case KDSUnlockAmount_question:{//问号点击
            
        }
            break;
        case KDSUnlockAmount_invitation:{//去邀请好友
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - KDSMineFunctionCellDelegate
-(void)mineFunctionCellButtonClick:(NSInteger)buttonTag{
    switch (buttonTag) {
        case 0:{//砍价
////            [KDSProgressHUD showFailure:@"暂未开放" toView:self.view completion:^{ }];
//            KDSBargainingController * bargainingVC = [[KDSBargainingController alloc]init];
//            [self.navigationController pushViewController:bargainingVC animated:YES];
        }
            break;
        case 1:{//我的帖子
//            KDSMyPostController * myPostVC = [[KDSMyPostController alloc]init];
//            [self.navigationController pushViewController:myPostVC animated:YES];
        }
            break;
        case 2:{//我的收藏
            KDSMyCollectController  * myCollectionVC = [[KDSMyCollectController alloc]init];
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }
            break;
        case 3:{//浏览足迹
            KDSMyFootPrintController * myFooterPrintVC = [[KDSMyFootPrintController alloc]init];
            [self.navigationController pushViewController:myFooterPrintVC animated:YES];
        }
            break;
        case 4:{//附近门店
//            KDSNearShopController * nearShopVC = [[KDSNearShopController alloc]init];
//            [self.navigationController pushViewController:nearShopVC animated:YES];
//            KDSNearShopListController * nearShopVC = [[KDSNearShopListController alloc]init];
//            nearShopVC.hiddenNaviBar = NO;
//            [self.navigationController pushViewController:nearShopVC animated:YES];
        }
            break;
        case 5:{//设备管理
            [KDSProgressHUD showFailure:@"暂未开放" toView:self.view completion:^{}];
        }
            break;
        case 6:{//在线客服
            KDSOnlineServiceController * onlineServiceVC = [[KDSOnlineServiceController alloc]init];
            [self.navigationController pushViewController:onlineServiceVC animated:YES];
        }
            break;
        case 7:{//反馈中心
            KDSFeedbackController * feedbackVC = [[KDSFeedbackController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"F7F7F7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100.0f;
        
    }
    return _tableView;
}

#pragma mark - 导航栏
-(KDSMineNavigationBar *)navigationBar{
    if (_navigationBar == nil) {
        _navigationBar = [[KDSMineNavigationBar alloc]init];
    }
    return _navigationBar;
}

@end
