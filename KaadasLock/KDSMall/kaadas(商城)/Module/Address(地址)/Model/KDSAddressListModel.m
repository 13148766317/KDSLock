//
//  KDSAddressListModel.m
//  kaadas
//
//  Created by 中软云 on 2019/5/30.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSAddressListModel.h"

@implementation KDSAddressListModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSAddressListRowModel class]};
}
@end

@implementation KDSAddressListRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
