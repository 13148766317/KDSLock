//
//  KDSFirstPartModel.m
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSFirstPartModel.h"

@implementation KDSFirstPartModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"banner":[KDSFirstPartBannerModel class],
             @"categories":[KDSFirstPartCategoriesModel class]
             };
}
@end


@implementation KDSFirstPartVideoModel

@end

@implementation KDSFirstPartBannerModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation KDSFirstPartCategoriesModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"description_rep":@"description"};
}
@end
