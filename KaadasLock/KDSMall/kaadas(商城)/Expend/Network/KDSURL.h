//
//  KDSURL.h
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

/********************************************
 *
 * 0 测试环境
 * 1 生产环境
 *
 ********************************************/
//#define KDSNetWorkEnvironment 1

//地址
UIKIT_EXTERN NSString * const  baseuUrl;
//网页地址
UIKIT_EXTERN NSString * const  webBaseUrl;
//产品分享
UIKIT_EXTERN NSString * const productdetailUrl;

//微信 分享 授权
UIKIT_EXTERN NSString * const  KWXAppId;
UIKIT_EXTERN NSString * const  KWXAppSecret;

////推送
//UIKIT_EXTERN NSString * const pushAppKey;
////推送开发  YES 发布    NO开发
//UIKIT_EXTERN BOOL       const  pushOpen;
//
////百度AK
//UIKIT_EXTERN NSString * const baiduAK;

UIKIT_EXTERN CGFloat    const couponTime;


/********************************************* 接口 *******************************************************************/
#pragma mark  -------------------------------------- 系统消息 --------------------------------------
//消息数量
UIKIT_EXTERN NSString * const systemMessageNumber;
//根据类型获取该类型下的消息列表
UIKIT_EXTERN NSString * const systemMessageListByType;
//
UIKIT_EXTERN NSString * const getSysMessageList;

#pragma mark  --------------------------------------  首页 --------------------------------------

//前端获取系统升级
UIKIT_EXTERN NSString * const systemUpgradeApp;

//购物车数量
UIKIT_EXTERN NSString * const shopcarGetNumber;
//1.获取轮播图，视频，分类 
UIKIT_EXTERN NSString * const homeGetFirstPart;

// 2.获取灵动系列，推拉系列，活动
UIKIT_EXTERN NSString * const homeGetSecdPart;
//3.搜索
UIKIT_EXTERN NSString * const getFirstSearch;
//1.搜索标签
UIKIT_EXTERN NSString * const getAllKeyValue;
//获取商品列表
UIKIT_EXTERN NSString * const getProductList;
//查询个活动列表 (秒杀 团购 众筹 灵动)
UIKIT_EXTERN NSString * const getFirstAll;

UIKIT_EXTERN NSString * const getcategoryChildList;

//优惠券现金接口 (未登陆)
UIKIT_EXTERN NSString * const getNotokenCoupon;
//优惠券现金接口 (已登陆)
UIKIT_EXTERN NSString * const getCoupon;

//根据数字分类编码找到所有的key-value
UIKIT_EXTERN NSString * const getListValue;

#pragma mark -------------------------------------- 砍价 --------------------------------------
//砍价详情
UIKIT_EXTERN NSString * const bargainDetail;
//砍价流水
UIKIT_EXTERN NSString * const bargainRecord;
//我发起的砍价列表
UIKIT_EXTERN NSString * const getMyBargainList;
//发起砍价
UIKIT_EXTERN NSString * const startBargain;
#pragma mark  -------------------------------------- 社交 --------------------------------------
//获取资讯分页列表
UIKIT_EXTERN NSString * const informationPage;
//获取帖子分页列表
UIKIT_EXTERN NSString * const invitationPage;
//获取活动分页列表
UIKIT_EXTERN NSString * const activityPage;
//资讯 帖子 活动 轮播图
UIKIT_EXTERN NSString * const socicalBanner;
//发布帖子
UIKIT_EXTERN NSString * const invitationSave;

#pragma mark  -------------------------------------- 商品详情 --------------------------------------
//商品详情
UIKIT_EXTERN NSString * const productDetail;
//商品评价
UIKIT_EXTERN NSString * const productEvalutate;
//添加收藏
UIKIT_EXTERN NSString * const addCollectProduct;
//取消收藏
UIKIT_EXTERN NSString * const cancelCollectProdcut;
//添加购物车
UIKIT_EXTERN NSString * const addShoppingCart;
//获取参数根据渠道商品id
UIKIT_EXTERN NSString * const getParameterApp;

#pragma mark  -------------------------------------- 我的 --------------------------------------
//获取用户个人信息接口
UIKIT_EXTERN NSString * const mineInfo;
//修改用户信息
UIKIT_EXTERN NSString * const updateUserInfo;
//设置密码
UIKIT_EXTERN NSString * const setPwd;
//绑定微信
UIKIT_EXTERN NSString * const bingWechat;
//绑定手机号
UIKIT_EXTERN NSString * const bingPhoneNumber;
//绑定邀请码
UIKIT_EXTERN NSString * const bingInviteCode;
//地址列表
UIKIT_EXTERN NSString * const addresslist;
//设置默认地址
UIKIT_EXTERN NSString * const setDefaultAddress;
//新增地址
UIKIT_EXTERN NSString * const addAddress;
//收货地址信息信息更新
UIKIT_EXTERN NSString * const updateAddress;
//删除收货地址信息
UIKIT_EXTERN NSString * const deleteAddress;
//获取我的帖子分页列表
UIKIT_EXTERN NSString * const  myInvitationPage;
//获取我的帖子的回复分页列表
UIKIT_EXTERN NSString * const invitationReplyPage;
//我的收藏 获取活动分页列表
UIKIT_EXTERN NSString * const myCollectAppList;
//批量取消收藏
UIKIT_EXTERN NSString * const cancelCollectByIds;
//我的足迹 获取活动分页列表
UIKIT_EXTERN NSString * const myFootPrintList;
//删除足迹
UIKIT_EXTERN NSString * const deleteFootPrint;
//门店获取分页列表
UIKIT_EXTERN NSString * const shopAppPageList;
//门店详情
UIKIT_EXTERN NSString * const shopAppDetail;
//提交反馈
UIKIT_EXTERN NSString * const feedbackSave;
//我的资产
UIKIT_EXTERN NSString * const myAssets;
//我的资产详情
UIKIT_EXTERN NSString * const myAssetsDetail;
//我的团队
UIKIT_EXTERN NSString * const myTeam;
//收益明细
UIKIT_EXTERN NSString * const earnDetails;
//我的团队人数
UIKIT_EXTERN NSString * const myTeamCount;
//我的任务(进行时)
UIKIT_EXTERN NSString * const myTaskongoing;
//我的任务(完成)
UIKIT_EXTERN NSString * const myTaskcomplete;
//用户激活优惠券
UIKIT_EXTERN NSString * const activationCoupon;
//获取我的优惠券
UIKIT_EXTERN NSString * const getMyCoupon;
//获取过期的优惠券
UIKIT_EXTERN NSString * const getMyPastDueCoupon;
//在线客服服务
UIKIT_EXTERN NSString * const onlineService;
//积分明细
UIKIT_EXTERN NSString * const intergralDetail;

//app提现
UIKIT_EXTERN NSString * const withdrawalMoney;
//商户提现说明
UIKIT_EXTERN NSString * const withdrawRemark;


#pragma mark  --------------------------------------注册&登录--------------------------------------
//用户注册填写手机号
UIKIT_EXTERN NSString * const checkPhone;
//用户验证码验证
UIKIT_EXTERN NSString * const checkCode;
//获取验证码
UIKIT_EXTERN NSString * const getCode;
//设置密码
UIKIT_EXTERN NSString * const setPassword;
//密码登录
UIKIT_EXTERN NSString * const passwordLogin;
//用户退出
UIKIT_EXTERN NSString * const userLogout;

//分享记录
UIKIT_EXTERN NSString * const shareSave;

