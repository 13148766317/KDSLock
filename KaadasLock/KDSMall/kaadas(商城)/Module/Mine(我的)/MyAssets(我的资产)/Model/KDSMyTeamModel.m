//
//  KDSMyTeamModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyTeamModel.h"

@implementation KDSMyTeamModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSMyTeamRowModel class]};
}
@end

@implementation KDSMyTeamRowModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
