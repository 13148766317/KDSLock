//
//  KDSEarningDetailModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningDetailModel.h"

@implementation KDSEarningDetailModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSEarningMonthModel class]};
}
@end

@implementation KDSEarningMonthModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSEarningDayModel class]};
}
@end

@implementation KDSEarningDayModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
