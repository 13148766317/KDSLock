//
//  StoreModel.h
//  Rent3.0
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class BaseModel;
#import "BaseModel.h"
@interface StoreModel : BaseModel
@property(nonatomic , strong)NSString *logo;
@property(nonatomic , strong)NSString *skuProductName;//商品名称
@property(nonatomic , strong)NSString *attributeComboName;//商品参数
@property(assign,nonatomic)NSInteger qty;//商品个数
@property (nonatomic,assign)NSInteger     agentProductId;


@property(nonatomic , strong)NSString *label;
@property(nonatomic , assign)CGFloat descH;
@property(nonatomic , strong)NSString *price;
@property(assign,nonatomic)BOOL isSelectState;//是否选中状态
@end
