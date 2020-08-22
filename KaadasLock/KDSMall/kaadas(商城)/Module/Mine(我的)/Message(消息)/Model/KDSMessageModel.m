//
//  KDSMessageModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMessageModel.h"

@implementation KDSMessageModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSMessageRowModel class]};
}
@end


@implementation KDSMessageRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
