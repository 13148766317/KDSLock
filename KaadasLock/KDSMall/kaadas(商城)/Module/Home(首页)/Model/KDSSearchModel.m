//
//  KDSSearchModel.m
//  kaadas
//
//  Created by 中软云 on 2019/5/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSearchModel.h"

@implementation KDSSearchModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSSearchRowModel class]};
}
@end


@implementation KDSSearchRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
