//
//  KDSAddressListModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/30.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class KDSAddressListRowModel;

@interface KDSAddressListModel : NSObject
@property (nonatomic,assign)NSInteger     total;
@property (nonatomic,strong)NSArray <KDSAddressListRowModel *>  *    list;

@end

@interface KDSAddressListRowModel : NSObject
//主键
@property (nonatomic,assign)NSInteger     ID;
//用户id
@property (nonatomic,assign)NSInteger     customerId;
//收货人姓名
@property (nonatomic,copy)NSString      * name;
//手机号
@property (nonatomic,copy)NSString      * phone;
//邮政编码
@property (nonatomic,copy)NSString      * zipCode;
//省
@property (nonatomic,copy)NSString      * province;
//市
@property (nonatomic,copy)NSString      * city;
//区
@property (nonatomic,copy)NSString      * area;
//经度
@property (nonatomic,copy)NSString      * longitude;
//纬度
@property (nonatomic,copy)NSString      * latitude;
//地址
@property (nonatomic,copy)NSString      * address;
//是否默认地址
@property (nonatomic,copy)NSString      * isDefault;
//日期
@property (nonatomic,copy)NSString      * createDate;
@end


NS_ASSUME_NONNULL_END
