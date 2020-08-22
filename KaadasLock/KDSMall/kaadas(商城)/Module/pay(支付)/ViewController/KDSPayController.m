//
//  KDSPayController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPayController.h"
#import "KDSPayTableCell.h"

//#import <YSEPaySDK/YSEPayStorage.h>
//#import <YSEPaySDK/YSRSADataSinger.h>

static UIWindow * __payWindow;
static KDSPayController  * __PayVC;

@interface KDSPayController ()
<
UITableViewDelegate,
UITableViewDataSource
//YSEPayDelegate
>
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
//提示框的背景
@property (nonatomic,strong)UIView            *  alertBG;
//确认支付title
@property (nonatomic,strong)UILabel           * titleLb;
//支付价格
@property (nonatomic,strong)UILabel           *  priceLb;

//
@property (nonatomic,strong)UITableView       * tableView;
@property (nonatomic,strong)NSArray           * dataArray;
@property (nonatomic,strong)UIButton          * payButton;
@property (nonatomic,assign)NSInteger           selectIndex;
@property (nonatomic,assign)CGFloat             bgViewHeight;
@property (nonatomic,copy)NSString            * priceString;

@property (nonatomic,copy)KDSPayOkButtonClick   okButtonClick;
@property (nonatomic,copy)KDSPayResultBlock     payResultBlock;
@property (nonatomic,copy)KDSCancelButtonClick  cancelButtonClick;

//@property (nonatomic, strong) YSEPayReq       * payReq;
@property (nonatomic, assign) PayChannelType     channel;
@property (nonatomic,copy)NSString             * orderNo;

@property (nonatomic,strong)UIButton * closeButton;//关闭button

@end

@implementation KDSPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 0;
    
//    //创建支付对象
//    self.channel = PayChannelType_wechat;
//    self.payReq = [[YSEPayReq alloc]init];
//    self.payReq.viewController = self;
//    self.payReq.type = YSEPayEvenTypePayReq;
//
//    //这是代理
//    [[YSEPay sharedInstance] setYSEPayDelegate:self];
//    //打印 log
//    [[YSEPay sharedInstance] setPrintLog:YES];
    self.channel = PayChannelType_Ali;//指定支付宝

    //创建UI
    [self createUI];
    
    //添加微信支付通知
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(wechatPayResultEvent:) name:WECHAT_PAY_RESULT_NOTOFOCATION object:nil];
    //添加支付宝支付通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayResultEvent:) name:ALI_PAY_RESULT_NOTIFICATION object:nil];
}

#pragma mark - 微信支付通知
-(void)wechatPayResultEvent:(NSNotification *)noti{
    NSLog(@"微信支付结果 %@",noti.object);
    __weak typeof(self)weakSelf = self;
    _closeButton.enabled = NO;
    //在主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
        int errCode = [noti.object intValue];
        PayResultCodeType  payType = 10000;
        NSString * msgResult = @"";
        
        switch (errCode) {
            case WXSuccess:{ /**< 成功    */
                NSLog(@"微信支付 成功 ");
                msgResult = @"支付成功";
                payType = PayResultCodeType_success;
            }
                break;
            case WXErrCodeCommon:{/**< 普通错误类型    */
                 NSLog(@"微信支付 普通错误类型 ");
                msgResult = @"普通错误类型";
                 payType = PayResultCodeType_fail;
            }
                break;
                
            case WXErrCodeUserCancel:{/**<    */
                 NSLog(@"微信支付 用户点击取消并返回 ");
                  msgResult = @"取消支付";
                  payType = PayResultCodeType_Cancel;
            }
                break;
                
            case WXErrCodeSentFail:{ /**< 发送失败    */
                 NSLog(@"微信支付 发送失败");
                msgResult = @"发送失败";
                  payType = PayResultCodeType_fail;
            }
                break;
            case WXErrCodeAuthDeny:{ /**< 授权失败    */
                 NSLog(@"微信支付 授权失败");
                 msgResult = @"授权失败";
                 payType = PayResultCodeType_fail;
            }
                break;
            case WXErrCodeUnsupport:{ /**< 微信不支持    */
                 NSLog(@"微信支付 微信不支持");
                 msgResult = @"微信不支持";
                payType = PayResultCodeType_fail;
            }
                
            default:
                break;
        }
    
        [KDSProgressHUD showFailure:msgResult toView:weakSelf.view completion:^{
            if (weakSelf.payResultBlock) {
                weakSelf.payResultBlock(payType);
            }
            weakSelf.closeButton.enabled = YES;
            [weakSelf backgroundViewTap];
        }];
        
        
    });
    
}

#pragma mark - 支付宝支付通知
-(void)aliPayResultEvent:(NSNotification *)noti{
    NSDictionary * resultDic = noti.object;
    NSLog(@"resultDic:%@",resultDic);
    NSString * resultStatus = [KDSMallTool checkISNull:resultDic[@"resultStatus"]];
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        PayResultCodeType  payType = 10000;
        NSString * msgResult = @"";
        weakSelf.closeButton.enabled = NO;
        if ([resultStatus isEqualToString:@"9000"]) {//订单支付成功
            NSLog(@"alipay: 订单支付成功");
            msgResult = @"支付成功";
            payType = PayResultCodeType_success;
        }else if ([resultStatus isEqualToString:@"8000"]){//正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            NSLog(@"alipay: 正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态");
            msgResult = @"支付结果未知";
            payType = PayResultCodeType_fail;
        }else if ([resultStatus isEqualToString:@"4000"]){//订单支付失败
            NSLog(@"alipay: 订单支付失败");
            msgResult = @"订单支付失败";
            payType = PayResultCodeType_fail;
        }else if ([resultStatus isEqualToString:@"5000"]){//重复请求
            NSLog(@"alipay: 重复请求");
            msgResult = @"重复请求";
            payType = PayResultCodeType_fail;
        }else if ([resultStatus isEqualToString:@"6001"]){//用户中途取消
            NSLog(@"alipay: 用户中途取消");
            msgResult = @"取消支付";
            payType = PayResultCodeType_Cancel;
        }else if ([resultStatus isEqualToString:@"6002"]){//网络连接出错
            NSLog(@"alipay: 网络连接出错");
            msgResult = @"网络连接出错";
            payType = PayResultCodeType_fail;
        }else if ([resultStatus isEqualToString:@"6004"]){//支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            NSLog(@"alipay: 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态");
            msgResult = @"支付结果未知";
            payType = PayResultCodeType_fail;
        }else{//其它支付错误
            NSLog(@"alipay: 其它支付错误");
            msgResult = @"其它支付错误";
            payType = PayResultCodeType_fail;
        }
        
        
        [KDSProgressHUD showFailure:msgResult toView:self.view completion:^{
            if (weakSelf.payResultBlock) {
                weakSelf.payResultBlock(payType);
            }
            weakSelf.closeButton.enabled = YES;
            [weakSelf backgroundViewTap];
        }];
    });
   
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDSPayTableCell * cell = [KDSPayTableCell payTableViewCellWithTableView:tableView];
    cell.payTypeModel = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __block NSUInteger selectedIndex = 0;
    [self.dataArray enumerateObjectsUsingBlock:^(PayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            selectedIndex = idx;
            *stop = YES;
        }
    }];
    if (indexPath.row == selectedIndex) {
        return;
    }
    [self.dataArray enumerateObjectsUsingBlock:^(PayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = NO;
    }];
    PayTypeModel *payTypeModel = self.dataArray[indexPath.row];
    payTypeModel.isSelected = YES;
    self.channel = payTypeModel.channel;
    [self.tableView reloadData];
    
}

-(void)payButtonClick{

    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    switch (self.channel) {
        case PayChannelType_wechat:{//微信付款
            
             if (![WXApi isWXAppInstalled]) {
                [KDSProgressHUD showFailure:@"请安装微信客户端" toView:self.view completion:^{}];
                return;
            }
        
            NSDictionary *dictParam = @{@"params":@{@"outTradeNo":_orderNo},
                                        @"token":[KDSMallTool checkISNull:userToken]
                                        };
            __weak typeof(self)weakSelf = self;
            [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"wxApp/payment" paramsDict:dictParam success:^(NSInteger code, id  _Nullable json) {
                if (code == 1) {
                    /** 商家向财付通申请的商家id */
                    NSString *strPartnerid = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"mch_id"]];
                    /** 预支付订单 */
                    NSString *strPrepayid = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"prepay_id"]];
                    /** 随机串，防重发 */
                    NSString *strNonce = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"nonce_str"]];//
                    /** 时间戳，防重发 */
                    NSString *strTimestamp = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"timestamp"]];//
                    /** 商家根据微信开放平台文档对数据做的签名 */
                    NSString *strSign = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"sign"]]; //
                    /** 商家根据财付通文档填写的数据和签名 */
//                    NSString * package = [NSString stringWithFormat:@"%@",[json[@"data"] objectForKey:@"package"]];
                    
                    PayReq *request = [[PayReq alloc] init];
                    
                    request.partnerId = strPartnerid;
                    request.prepayId= strPrepayid;
                    request.nonceStr= strNonce;
                    request.timeStamp= [strTimestamp intValue];
                    request.sign = strSign;
                    request.package =  @"Sign=WXPay";//package; //
                    NSLog(@"%@", request.prepayId);
                    [WXApi sendReq:request];
                }else{
                    [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
                }
            } failure:^(NSError * _Nullable error) {
                [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
            }];
            
        }
            break;
        case PayChannelType_Ali:{//支付宝付款
            if (![[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
                 [KDSProgressHUD showFailure:@"请安装支付宝客户端" toView:self.view completion:^{}];
                return;
            }
            
            NSDictionary *dictParam = @{@"params":@{@"outTradeNo":_orderNo},
                                        @"token":[KDSMallTool checkISNull:userToken]
                                        };
            __weak typeof(self)weakSelf = self;
            [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"aliApp/payment" paramsDict:dictParam success:^(NSInteger code, id  _Nullable json) {
                 NSLog(@"支付宝签约信息=%@" ,json);
                if (code == 1) {
                    NSString * orderStr = [NSString stringWithFormat:@"%@",json[@"data"]];
                    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:@"kaadasAliPaySchemes" callback:^(NSDictionary *resultDic) {
                        NSLog(@"resultDic:%@",resultDic);
                        NSString * resultStatus = [KDSMallTool checkISNull:resultDic[@"resultStatus"]];
                        if ([resultStatus isEqualToString:@"9000"]) {//订单支付成功
                            NSLog(@"alipay: 订单支付成功");
                        }else if ([resultStatus isEqualToString:@"8000"]){//正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
                             NSLog(@"alipay: 正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态");
                        }else if ([resultStatus isEqualToString:@"4000"]){//订单支付失败
                             NSLog(@"alipay: 订单支付失败");
                        }else if ([resultStatus isEqualToString:@"5000"]){//重复请求
                             NSLog(@"alipay: 重复请求");
                        }else if ([resultStatus isEqualToString:@"6001"]){//用户中途取消
                             NSLog(@"alipay: 用户中途取消");
                        }else if ([resultStatus isEqualToString:@"6002"]){//网络连接出错
                             NSLog(@"alipay: 网络连接出错");
                        }else if ([resultStatus isEqualToString:@"6004"]){//支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
                             NSLog(@"alipay: 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态");
                        }else{//其它支付错误
                             NSLog(@"alipay: 其它支付错误");
                        }
                    }];
                }else{
                    [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
                }
            } failure:^(NSError * _Nullable error) {
                [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
                    
                }];
            }];
            

        }
            break;

        default:
            break;
    }

}

#pragma mark - 关闭事件
-(void)closeButtonClick{
    if (self.cancelButtonClick) {
        self.cancelButtonClick();
    }
    [self backgroundViewTap];
}

+(instancetype)showPay:(NSString *)priceString orderNo:(NSString *)orderNo  payResult:(KDSPayResultBlock)payResult cancelButtonClick:(KDSCancelButtonClick)cancelButtonClick{
    __PayVC = [[KDSPayController alloc]init];
    __PayVC.priceString = priceString;
    __PayVC.payResultBlock = payResult;
    __PayVC.cancelButtonClick = cancelButtonClick;
    __PayVC.orderNo = orderNo;
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __PayVC;
    __payWindow = window;
    
    return __PayVC;
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
    
    //半透明view添加点击手势
    //    UITapGestureRecognizer * backgroundViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTap)];
    //    [_backgroundView addGestureRecognizer:backgroundViewTap];
    
    //提示框的背景
    _alertBG = [[UIView alloc]init];
    _alertBG.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
    [self.view addSubview:_alertBG];
    _alertBG.frame = CGRectMake(0, 150, KSCREENWIDTH, KSCREENHEIGHT - 150);
    
    //确认支付title
    _titleLb = [KDSMallTool createLabelString:@"确认支付" textColorString:@"#333333" font:18];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [_alertBG addSubview:_titleLb];
    _titleLb.frame = CGRectMake(40, 0, KSCREENWIDTH - 2 * 40, 60);
    //    _titleLb.backgroundColor = [UIColor purpleColor];
    
    //关闭button
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    closeButton.backgroundColor = [UIColor redColor];
    [_closeButton setImage:[UIImage imageNamed:@"icon_norms_del"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertBG addSubview:_closeButton];
    _closeButton.frame = CGRectMake(KSCREENWIDTH - 50 , 5, 50, 50);
    
    //分割线
    UIView * dividingLine = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
    [_alertBG addSubview:dividingLine];
    dividingLine.frame = CGRectMake(0, CGRectGetMaxY(_titleLb.frame), KSCREENWIDTH, dividinghHeight);
    
    //支付价格
    _priceLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:30];
    _priceLb.textAlignment = NSTextAlignmentCenter;
    [_alertBG addSubview:_priceLb];
    _priceLb.frame = CGRectMake(0, CGRectGetMaxY(dividingLine.frame) , KSCREENWIDTH, 112);
    
    //标记
    UIView * tagView = [[UIView alloc]init];
    tagView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [_alertBG addSubview:tagView];
    tagView.frame = CGRectMake(15, CGRectGetMaxY(_priceLb.frame), 5, 15);
    
    //选择支付方式
    UILabel * payTitleLb = [KDSMallTool createbBoldLabelString:@"选择支付方式" textColorString:@"#333333" font:15];
    [_alertBG addSubview:payTitleLb];
    payTitleLb.frame = CGRectMake(CGRectGetMinX(tagView.frame) + 15, CGRectGetMinY(tagView.frame) - 5, 150, 25);
    
    //添加tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.rowHeight = 60.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_alertBG addSubview:_tableView];
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(payTitleLb.frame) + 5, KSCREENWIDTH, 3  * 60);
    
    
    UIButton * payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [payButton setTitle:@"立即付款" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertBG addSubview:payButton];
    payButton.layer.cornerRadius = 44 / 2;
    payButton.layer.masksToBounds = YES;
    payButton.frame = CGRectMake(15, CGRectGetMaxY(_tableView.frame) + 20, KSCREENWIDTH - 30, 44);
    
    CGFloat bgViewX = 0;
    CGFloat bgViewW = KSCREENWIDTH;
    CGFloat bgViewH = CGRectGetMaxY(payButton.frame) + 30;
    _bgViewHeight = bgViewH;
    _alertBG.frame = CGRectMake(bgViewX, KSCREENHEIGHT, bgViewW, bgViewH);
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSString * payStr = [NSString stringWithFormat:@"￥%@",_priceString];
    _priceLb.attributedText = [KDSMallTool attributedString:payStr dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} range:NSMakeRange(0, 1) lineSpacing:0 alignment:NSTextAlignmentCenter];
    
    [UIView animateWithDuration:0.25 animations:^{
        _alertBG.frame = CGRectMake(0, KSCREENHEIGHT - _bgViewHeight, KSCREENWIDTH, _bgViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 点击半透明背景事件
-(void)backgroundViewTap{
    [UIView animateWithDuration:0.25 animations:^{
        _alertBG.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, _bgViewHeight);
    } completion:^(BOOL finished) {
        [self clseaAlert];
    }];
}
#pragma mark - 关闭窗口
-(void)clseaAlert{
    __PayVC = nil;
    __payWindow.hidden = YES;
    __payWindow = nil;
}

#pragma mark - 懒加载
-(NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:
//                      [[PayTypeModel alloc]initWithChannel:PayChannelType_wechat],
                      [[PayTypeModel alloc]initWithChannel:PayChannelType_Ali], nil];
    }
    return _dataArray;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WECHAT_PAY_RESULT_NOTOFOCATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALI_PAY_RESULT_NOTIFICATION object:nil];
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

#pragma mark -
+(instancetype)showPay:(NSString *)priceString okButtonClick:(KDSPayOkButtonClick)okButtonClick cancelButtonClick:(KDSCancelButtonClick)cancelButtonClick{
    __PayVC = [[KDSPayController alloc]init];
    __PayVC.priceString = priceString;
    __PayVC.okButtonClick = okButtonClick;
    __PayVC.cancelButtonClick = cancelButtonClick;
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __PayVC;
    __payWindow = window;
    
    return __PayVC;
    
}

/**
 生成随机订单
 
 @return return value description
 */
- (NSString *)generateTradeNO
{
    static int kNumber = 16;
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (sourceStr.length-1);
        char tempStr = [sourceStr characterAtIndex:index];
        [resultStr appendString:[NSString stringWithFormat:@"%c", tempStr]];
    }
    NSLog(@"resultStr:%@",resultStr);
    
    [resultStr insertString:[self getCurrentTimestampString:@"yyyyMMdd"] atIndex:0];
    
    return resultStr;
}

- (NSString *)signparams:(NSDictionary *)params {
    NSArray * keyArr = params.allKeys;
    NSArray * newArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        //return [obj1 compare:obj2];
    }];
    NSMutableString *String = [NSMutableString string];
    for (int j = 0; j< newArr.count;j++) {
        if (j == 0) {
            if ([[[params objectForKey:newArr[j]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            }else{
                [String appendFormat:@"%@=%@",newArr[j],[params objectForKey:newArr[j]]];
            }
        }
        else{
            if ([[[params objectForKey:newArr[j]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            }else{
                [String appendFormat:@"&%@=%@",newArr[j],[params objectForKey:newArr[j]]];
            }
        }
    }
    //    NSLog(@"signparams String------------->%@",String);
    return String;
}

- (NSString *)dictToJsonString:(NSDictionary *)dict {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - demo util
- (NSString *)getCurrentTimestampString:(NSString *)format {
    static NSDateFormatter *dateFormatter;
    dateFormatter = dateFormatter ?: [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}
@end
