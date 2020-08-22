//
//  KDSProductDetailModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailModel.h"

@implementation KDSProductDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"banners":[KDSProductImageModel class],@"detailImgs":[KDSProductImageModel class]};
}

@end

@implementation KDSProductImageModel



@end
