//
//  KDSFootPrintListModel.m
//  kaadas
//
//  Created by 中软云 on 2019/6/3.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSFootPrintListModel.h"

@implementation KDSFootPrintListModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSFootPrintRowModel class]};
}
@end

@implementation KDSFootPrintRowModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[KDSMyCollectRowModel class]};
}

@end
