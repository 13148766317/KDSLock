//
//  aaAreaModel.h
//  DXLAddressView
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AAreaModel : AddressModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *postCode;
//@property (nonatomic,strong) NSString *code;
+ (instancetype)showAreaDataWith:(NSDictionary *)dict;
@end
