//
//  KDSURL.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//


#if KDSNetWorkEnvironment   == 0 //测试环境
//测试地址
NSString * const baseuUrl                = @"https://www.kaishuzhijia.com:8080/";// @"https://test.zrytech.com/"; //
//网页地址
NSString * const  webBaseUrl             =  @"https://test.zrytech.com/h5/index.html#/";
//产品分享
NSString * const productdetailUrl        =  @"https://test.zrytech.com/h5/index.html?from=singlemessage#/productdetail?";

//微信 分享
//NSString * const  KWXAppId               = @"wxd1cccfeb16cd07d1";
//NSString * const  KWXAppSecret           = @"5d3d1005f5fc485c65adfcf64320b6d9";
NSString * const  KWXAppId               = @"wxaa2df1f344ba0755";


//优惠券弹出时间间隔
CGFloat    const  couponTime             = 5 * 60;

#elif KDSNetWorkEnvironment == 1 //生产环境

NSString * const  baseuUrl               = @"https://www.kaishuzhijia.com:8080/"; //@"https://www.kaishuzhijia.com/";//
//网页地址
NSString * const  webBaseUrl             =  @"https://www.kaishuzhijia.com/h5/index.html#/";
//产品分享
NSString * const  productdetailUrl       =  @"https://www.kaishuzhijia.com/h5/index.html?from=singlemessage#/productdetail?";

//微信 分享
NSString * const  KWXAppId               = @"wxaa2df1f344ba0755";
//NSString * const  KWXAppId               = @"wx496a49943fabac18";
//NSString * const  KWXAppSecret           = @"e59ede27c5b4bc97a78179a566609a4b";

//优惠券弹出时间间隔
CGFloat    const couponTime              = 60 * 60;

#endif

/*********************************************接口*******************************************************************/

#pragma mark  --------------------------------------系统消息--------------------------------------
//消息数量
NSString * const systemMessageNumber     = @"sysMessage/getSysMessageNumber";
//根据类型获取该类型下的消息列表
NSString * const systemMessageListByType = @"sysMessage/getSysMessageListByType";
//
NSString * const getSysMessageList       = @"sysMessage/getSysMessageList";

#pragma mark  -------------------------------------- 首页 --------------------------------------

//前端获取系统升级
NSString * const systemUpgradeApp       = @"systemUpgradeApp/getSystem";
//购物车数量
NSString * const shopcarGetNumber       = @"shopcar/getNumber";
//1.获取轮播图，视频，分类
NSString * const homeGetFirstPart       = @"home/getFirstPart";
// 2.获取灵动系列，推拉系列，活动
NSString * const homeGetSecdPart        = @"home/getSecdPart";
//3.搜索
NSString * const getFirstSearch         = @"home/getFirstSearch";
//1.搜索标签 
NSString * const getAllKeyValue         = @"commonApp/getAllKeyValue";
//获取商品列表
NSString * const getProductList         = @"front/product/page";
//查询个活动列表 (秒杀 团购 众筹 灵动)
NSString * const getFirstAll            = @"home/getFirstAll";

NSString * const getcategoryChildList   = @"sysCategory/getChildList";
//优惠券现金接口 (未登陆)
NSString * const getNotokenCoupon       = @"appcounpon/getNotokenCoupon";
//优惠券现金接口 (已登陆)
NSString * const getCoupon              = @"appcounpon/getCoupon";
//根据数字分类编码找到所有的key-value
NSString * const getListValue           = @"dict/getListValue" ;


#pragma mark -------------------------------------- 砍价 --------------------------------------
//砍价详情
NSString * const bargainDetail          = @"appBargain/detail";
//砍价流水
NSString * const bargainRecord          = @"appBargain/getBargainRecord";
//我发起的砍价列表
NSString * const getMyBargainList       = @"appBargain/getMyBargainList";
//发起砍价
NSString * const startBargain           = @"appBargain/startBargain";

#pragma mark  -------------------------------------- 社交 --------------------------------------
//获取资讯分页列表
NSString * const informationPage        = @"articleApp/informationPage";
//获取帖子分页列表
NSString * const invitationPage         = @"articleApp/invitationPage";
// 获取活动分页列表
//NSString * const activityPage     = @"articleApp/activityPage";
NSString * const activityPage           = @"appAactivity/getList";
//资讯 帖子 活动 轮播图
NSString * const socicalBanner          = @"commonApp/getBannerList";
//发布帖子
NSString * const invitationSave         = @"articleApp/invitationSave";

#pragma mark  --------------------------------------商品详情--------------------------------------
//商品详情
 NSString * const productDetail         = @"front/product/get";
//商品评价
NSString * const productEvalutate       = @"front/product/getCommentListByProductId";
//添加收藏
NSString * const addCollectProduct      = @"collectApp/addCollect";
//取消收藏
NSString * const cancelCollectProdcut   = @"collectApp/cancelCollect";
//添加购物车
NSString * const addShoppingCart        = @"shopcar/save";
//获取参数根据渠道商品id
NSString * const getParameterApp        = @"parameterApp/getParameterApp";


#pragma mark  -------------------------------------- 我的 --------------------------------------
//获取用户个人信息接口
NSString * const  mineInfo              = @"customerApp/myInfo";
//修改用户信息
NSString * const updateUserInfo         = @"customerApp/update";
//设置密码
NSString * const setPwd                 = @"customerApp/setPwd";
//绑定微信
NSString * const bingWechat             = @"customerApp/bingWx";
//绑定手机号
NSString * const  bingPhoneNumber       = @"customerApp/bingTel";
//绑定邀请码
NSString * const bingInviteCode         = @"customerApp/bingInviteCode";
//地址列表
NSString * const  addresslist           = @"userAddressApp/page";
//设置默认地址
NSString * const setDefaultAddress      = @"userAddressApp/updateAddress";
//新增地址
NSString * const  addAddress            = @"userAddressApp/save";
//收货地址信息信息更新
NSString * const  updateAddress         = @"userAddressApp/update";
//删除收货地址信息
NSString * const  deleteAddress         = @"userAddressApp/delete";
//获取我的帖子分页列表
NSString * const  myInvitationPage      = @"articleApp/myInvitationPage";
//获取我的帖子的回复分页列表
NSString * const invitationReplyPage    = @"articleApp/myReply";
//我的收藏 获取活动分页列表
NSString * const myCollectAppList       = @"collectApp/page";
//批量取消收藏
NSString * const cancelCollectByIds     = @"collectApp/cancelCollectByIds";
//我的足迹 获取活动分页列表
NSString * const myFootPrintList        = @"collectApp/viewPage";
//删除足迹
NSString * const deleteFootPrint        = @"collectApp/delete";
//门店获取分页列表
NSString * const shopAppPageList        = @"shopApp/page";
//门店详情
NSString * const shopAppDetail          = @"shopApp/details";
//提交反馈
NSString * const  feedbackSave          = @"feedback/save";
//我的资产
NSString * const  myAssets              = @"front/businessCenter/myAssets";
//我的资产详情
NSString * const  myAssetsDetail        = @"front/businessCenter/myAssetsDetail";
//我的团队
NSString * const  myTeam                = @"front/businessCenter/myTeam";
//收益明细
NSString * const  earnDetails           = @"front/businessCenter/earnDetails";
//我的团队人数
NSString * const  myTeamCount           = @"front/businessCenter/myTeamCount";
//我的任务(进行时)
NSString * const myTaskongoing          = @"myTask/ongoing";
//我的任务(完成)
NSString * const myTaskcomplete         = @"myTask/complete";
//用户激活优惠券
NSString * const activationCoupon       = @"coupon/activation";
//获取我的优惠券
NSString * const getMyCoupon            = @"coupon/getMyCoupon";
//获取过期的优惠券
NSString * const getMyPastDueCoupon     = @"coupon/getMyPastDueCoupon";
//在线客服服务
NSString * const onlineService          = @"serverconfig/getList";
//积分明细
NSString * const intergralDetail        = @"integralWater/page";
//app提现
NSString * const withdrawalMoney        = @"payApp/withdraw";
//商户提现说明
NSString * const withdrawRemark         = @"payApp/withdrawRemark";

#pragma mark - 注册&登录
//用户注册填写手机号验证
NSString * const  checkPhone            = @"customerApp/checkPhoneCode";
//获取验证码
NSString * const  getCode               = @"customerApp/getCode";
//用户验证码验证
NSString * const  checkCode             = @"customerApp/register";
//设置密码
NSString * const  setPassword           = @"customerApp/initPwd";
//密码登录
NSString * const  passwordLogin         = @"customer/login";
//用户退出
NSString * const userLogout             = @"customer/logout";
//分享记录
NSString * const shareSave              = @"share/save";















































