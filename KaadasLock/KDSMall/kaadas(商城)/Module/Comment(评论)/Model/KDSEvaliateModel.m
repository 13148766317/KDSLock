//
//  KDSEvaliateModel.m
//  kaadas
//
//  Created by 中软云 on 2019/7/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEvaliateModel.h"

@implementation KDSEvaliateModel
-(instancetype)init{
    if (self = [super init]) {
        _isAnonymous = @"true";
        _productScore = 5;
        _content = @"";
        _imgs = @"";
        _conformityScore = 5;
        _dispatchingScore = 5;
        _installScore = 5;
        _imagesArray = [NSMutableArray array];
    }
    return self;
}
@end
