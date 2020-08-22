//
//  DetailModel.h
//  Rent3.0
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
//@class BaseModel;

@interface DetailModel : BaseModel

//订单列表详情相关
@property(nonatomic,strong)NSString* buyerMsg;
@property(nonatomic,strong)NSString* totalPrice;
@property(nonatomic,strong)NSString* discusPay;
@property(nonatomic,strong)NSString *createDate;


@property(nonatomic,strong)NSString *indentStatus;//订单状态
@property (nonatomic,copy)NSString      * installStatus; //安装状态
@property(nonatomic,strong)NSString *transportStatus;//物流状态
@property(nonatomic,strong)NSString *showType;//订单展示类型
@property(nonatomic,strong)NSString *type;
@property (nonatomic,copy)NSString      * indentType;

//产品详情介绍
@property(nonatomic , strong)NSString *name;
@property(nonatomic , strong)NSString* discountPrice;
@property(nonatomic , strong)NSString* price;
@property(nonatomic , strong)NSString *sold;
@property(nonatomic , strong)NSString *adesc;
@property(nonatomic , strong)NSString *logo;
@property(nonatomic , strong)NSString *flag;




//积分产品详情介绍
@property(nonatomic , strong)NSString *scorePrice;


@property(nonatomic , strong)NSString *myOrderType; //积分订单或普通订单


//规格按钮
//name 和id
@property(nonatomic , strong)NSString *aPropertyName;


//确认订单
@property(nonatomic , strong)NSString *productName;
@property(nonatomic , strong)NSString *orderCount;
@property(nonatomic , strong)NSString *label;
@property(nonatomic , assign)CGFloat   descH;



//优惠券
@property(nonatomic , strong)NSString *coupon;
@property(nonatomic , strong)NSString *couponCondition;
@property(nonatomic , strong)NSString *descriptionIOS;
@property(nonatomic , strong)NSString *idIOS;


//订单列表
@property(nonatomic , strong)NSString *img;
@property(nonatomic , strong)NSString *produceSize;


//收货地址
@property(nonatomic , strong)NSString *status;
@property(nonatomic , strong)NSString *areaCode;//省市区
@property(nonatomic , strong)NSString *address;//详细地址
@property(nonatomic , strong)NSString *personName;//姓名
@property(nonatomic , strong)NSString *phone;//电话

//消息中心
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *createtime;
@property(nonatomic , strong)NSString *content;



//分类名字
@property(nonatomic , strong)NSString *categoryNamee;


//订单列表
@property(nonatomic,strong)NSString *indentStatusCN; //订单状态显示文字
@property(nonatomic,strong)NSString *qty; //订单数量
@property(nonatomic,strong)NSString *productLabels; //订单商品属性
@property(nonatomic,strong)NSString* realPay;
@property(nonatomic,strong)NSString *orderNo;
@property (nonatomic,copy)NSString      * indentId;
@property (nonatomic,copy)NSString      * productId;
@property (nonatomic,copy)NSString      * indentDetailId;


@property(nonatomic,strong)NSAttributedString *priceAtribute;
@property(nonatomic,strong)NSAttributedString *footAtribute;


//订单详情默认地址
@property(nonatomic,strong)NSString *transportName;
@property(nonatomic,strong)NSString *transportPhone;
@property(nonatomic,strong)NSString *transportAddress;
@property (nonatomic,copy)NSString      * province;
@property (nonatomic,copy)NSString      * city;
@property (nonatomic,copy)NSString      * area;


//产品属性
@property(nonatomic,strong)NSString     *attributeComboName;
@property(nonatomic,strong)NSString     *realQty;
@property (nonatomic,assign)NSInteger     businessId; //活动Id
@property (nonatomic,copy)NSString      * skuName;
@property (nonatomic,copy)NSString      * oldPrice;

@property(nonatomic,strong)NSMutableArray *indentInfo;




@end
