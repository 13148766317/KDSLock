//
//  aaProvinceModel.m
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import "AProvinceModel.h"

@implementation AProvinceModel
+ (instancetype)showDataWith:(NSDictionary *)dict
{
    AProvinceModel *model = [[AProvinceModel alloc] init];
    model.name = dict[@"name"];
    model.code = dict[@"id"];
    
    NSArray *arrayT = [dict objectForKey:@"child"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [arrayT enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ACityModel *Models = [ACityModel showCityDataWith:obj];
        [data addObject:Models];
    }];
    model.city = data;
    return model;
}
@end
