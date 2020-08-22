//
//  KDSCategoryChildModel.m
//  kaadas
//
//  Created by Apple on 2019/6/6.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSCategoryChildModel.h"

@implementation KDSCategoryChildModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",@"Description":@"description"};
}
@end
