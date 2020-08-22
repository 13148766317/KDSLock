//
//  KDSSecondPartModel.m
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSecondPartModel.h"

@implementation KDSSecondPartModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSSecondPartRowModel class]};
}
@end


@implementation KDSSecondPartRowModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


