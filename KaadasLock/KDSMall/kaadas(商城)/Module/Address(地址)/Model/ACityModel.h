//
//  aaCityModel.h
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
#import "AAreaModel.h"
@interface ACityModel : AddressModel
@property (nonatomic,strong) NSArray <AAreaModel *>*area;
@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *code;
+ (instancetype)showCityDataWith:(NSDictionary *)dict;
@end
