//
//  KDSAfterSaleModel.m
//  kaadas
//
//  Created by 中软云 on 2019/8/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSAfterSaleModel.h"

@implementation KDSAfterSaleModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[DetailModel class]};
}
@end
