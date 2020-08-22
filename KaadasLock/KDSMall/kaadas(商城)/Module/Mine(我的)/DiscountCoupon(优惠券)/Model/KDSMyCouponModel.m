//
//  KDSMyCouponModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/11.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyCouponModel.h"

@implementation KDSMyCouponModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSMyCouponRowModel class]};
}
@end

@implementation KDSMyCouponRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
