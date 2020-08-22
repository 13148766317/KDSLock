//
//  KDSProductListModel.m
//  kaadas
//
//  Created by 中软云 on 2019/5/31.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductListModel.h"

@implementation KDSProductListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSProductListRowModel class]};
}
@end

@implementation KDSProductListRowModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end



