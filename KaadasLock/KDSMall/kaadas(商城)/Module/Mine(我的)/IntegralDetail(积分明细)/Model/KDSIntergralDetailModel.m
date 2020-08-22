//
//  KDSIntergralDetailModel.m
//  kaadas
//
//  Created by 中软云 on 2019/7/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSIntergralDetailModel.h"

@implementation KDSIntergralDetailModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSIntergralDetailRowModel class]};
}
@end

@implementation KDSIntergralDetailRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
