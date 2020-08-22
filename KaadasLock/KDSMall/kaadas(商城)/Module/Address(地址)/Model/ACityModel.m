//
//  aaCityModel.m
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import "ACityModel.h"

@implementation ACityModel
+ (instancetype)showCityDataWith:(NSDictionary *)dict{
    ACityModel *model = [[ACityModel alloc] init];
    model.name = dict[@"name"];
    model.code = dict[@"id"];
    NSArray *arrayT = [dict objectForKey:@"child"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [arrayT enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AAreaModel *teanModels = [AAreaModel showAreaDataWith:obj];
        [data addObject:teanModels];
    }];
    model.area = data;
    return model;
}
@end
