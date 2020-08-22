//
//  QZUserModel.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/26.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class QZExtendModel;
NS_ASSUME_NONNULL_BEGIN

@interface QZUserModel : NSObject<NSCoding>
//登录账号id(基本信息)
@property (nonatomic,assign)NSInteger     ID;
//昵称
@property (nonatomic,copy)NSString      * userName;
//头像url
@property (nonatomic,copy)NSString      * logo;
//手机号
@property (nonatomic,copy)NSString      * tel;
//邀请码;(邀请码为8位系统生成的数字),有邀请码表示已绑定,没有表示未绑定
@property (nonatomic,copy)NSString      * inviteCode;
@property (nonatomic,copy)NSString      * levelCN;
//性别;1:男;0:女
@property (nonatomic,copy)NSString      * genderCN;
//年龄
@property (nonatomic,copy)NSString      * age;
//自己的邀请码
@property (nonatomic,copy)NSString      * randomCode;
//生日
@property (nonatomic,copy)NSString      * birthday;
@property (nonatomic,copy)NSString      * qrImgUrl;
//任务数
@property (nonatomic,copy)NSString      * taskNum;
//优惠券数量
@property (nonatomic,copy)NSString      * couponNum;
//积分数量
@property (nonatomic,copy)NSString      * score;
//总金额
@property (nonatomic,copy)NSString      * taskTotalMoney;
//待解锁金额
@property (nonatomic,copy)NSString      * taskHaveMoney;
//还剩余推荐
@property (nonatomic,copy)NSString      * inviteNum;
//未使用
@property (nonatomic,assign)NSInteger     userCouponUseNum;
//已过期
@property (nonatomic,assign)NSInteger     userCouponOverdueNum;
//是否已领延保卡   true 已领
@property (nonatomic,assign)BOOL           isGetTimeDelay;

@end





NS_ASSUME_NONNULL_END
