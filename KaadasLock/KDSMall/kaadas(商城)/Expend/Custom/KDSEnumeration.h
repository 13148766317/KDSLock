//
//  KDSEnumeration.h
//  kaadas
//
//  Created by 宝弘 on 2019/5/19.
//  Copyright © 2019年 kaadas. All rights reserved.
//

//社交  帖子  button类型
typedef NS_ENUM(NSInteger,KDSPostSocialButtonType){
    KDSPostSocialButtonType_eye,//观看
    KDSPostSocialButtonType_evaluate,//评论
    KDSPostSocialButtonType_share //分享
    
};


//产品详情评论button类型
typedef NS_ENUM(NSInteger,KDSProductEvaluateButtonType){
    KDSProductEvaluate_evaluate,//评论
    KDSProductEvaluate_like     //点赞
};

// 客服  收藏 购物车  拼团  加入购物车  立即购买
typedef NS_ENUM(NSInteger,KDSProductBottomButtonType){
    KDSProductBottom_service,//客服
    KDSProductBottom_collect,//收藏
    KDSProductBottom_shopCart,//购物车
    KDSProductBottom_addCart,//加入购物车
    KDSProductBottom_buy,//立即购买
    KDSProductBottom_group,//拼团
    KDSProductBottom_crowdfunding,//众筹
    KDSProductBottom__seckill,//秒杀
    KDSProductBottom_bargain,//砍价
};

//商品详情类型
typedef NS_ENUM(NSInteger,KDSProductDetailBottomType){
    KDSProductDetail_noraml,      //默认
    KDSProductDetail_seckill,     //秒杀
    KDSProductDetail_group,       //拼团 团购
    KDSProductDetail_crowdfunding,//众筹
    KDSProductDetail_bargain      //砍价
};

typedef NS_ENUM(NSInteger,KDSProductType){
    KDSProduct_noraml,      //默认
    KDSProduct_seckill,     //秒杀
    KDSProduct_group,       //拼团 团购
    KDSProduct_crowdfunding,//众筹
    KDSProduct_bargain,     //砍价
};


typedef NS_ENUM(NSInteger,KDSNetWorkServiceType){
    NetWorkService_NoNetWork = -100,//无网络
    NetWorkService_serviceError//服务器异常
};


typedef NS_ENUM(NSInteger,KDSPayType){
    KDSPayType_WX,    //微信
    KDSPayType_alipay,//支付宝
    KDSPayType_QQ,     //QQ
};
typedef NS_ENUM(NSInteger,QZShareButtonType){
    QZShareButton_wechatFriend,   //微信好友
    QZShareButton_Wechatmoments,  //朋友圈
    QZShareButton_QQFriend,       //QQ好友
    QZShareButton_QZone,          //QQ空间
    QZShareButton_weibo,          //微博
    QZShareButton_downImage,      //下载图片
    QZShareButton_copyUrl        //复制链接
    
};
