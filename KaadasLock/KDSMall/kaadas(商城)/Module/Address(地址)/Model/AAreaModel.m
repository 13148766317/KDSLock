//
//  aaAreaModel.m
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import "AAreaModel.h"

@implementation AAreaModel
+ (instancetype)showAreaDataWith:(NSDictionary *)dict
{
    AAreaModel *model = [[AAreaModel alloc] init];
    model.name = dict[@"name"];
    model.code = dict[@"id"];
    //    model.postCode = dict[@"postCode"];
    return model;
}
@end
