//
//  PayTypeModel.h
//  YSEPaySDK
//
//  Created by JoakimLiu on 2017/5/3.
//  Copyright © 2017年 银盛通信有限公司. All rights reserved.
//


typedef NS_ENUM(NSInteger,PayChannelType){
    PayChannelType_wechat,//微信
    PayChannelType_Ali,   //支付宝
};


#import <Foundation/Foundation.h>
//#import <YSEPaySDK/YSEPayObjects.h>

@interface PayTypeModel : NSObject
@property (nonatomic, copy) NSString *iconString;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) PayChannelType channel;

- (instancetype)initWithChannel:(PayChannelType)channel;
@end
