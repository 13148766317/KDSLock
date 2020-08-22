//
//  PayTypeModel.m
//  YSEPaySDK
//
//  Created by JoakimLiu on 2017/5/3.
//  Copyright © 2017年 银盛通信有限公司. All rights reserved.
//

#import "PayTypeModel.h"
//title , [YSEPayChannelQQApp] = @"QQ钱包支付"
NSString *const YSEPayChannelNameDict[] = {[PayChannelType_wechat] = @"微信支付", [PayChannelType_Ali] = @"支付宝支付"};
//支付图标 , [YSEPayChannelQQApp] = @"QQPayLogo"
NSString *const YSEPayChannelIconNameDict[] = {[PayChannelType_wechat] = @"微信支付", [PayChannelType_Ali] = @"支付宝支付"};

@implementation PayTypeModel
- (instancetype)initWithChannel:(PayChannelType)channel {
    self = [super init];
    if (self) {
        _iconString = YSEPayChannelIconNameDict[channel];
        _typeName = YSEPayChannelNameDict[channel];
        _isSelected = (channel == PayChannelType_Ali) ? YES : NO;//默认支付宝
        _channel = channel;
    }
    return self;
}

@end

