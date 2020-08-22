//
//  aaProvinceModel.h
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "bbAddressModel.h"
#import "AddressModel.h"
#import "ACityModel.h"
@interface AProvinceModel : AddressModel
@property (nonatomic,strong) NSArray <ACityModel *>*city;
@property (nonatomic,strong) NSString *name;
+ (instancetype)showDataWith:(NSDictionary *)dict;
@end
