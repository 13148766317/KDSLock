//
//  QZHelpTool.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/4/8.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSHelperTool.h"

static KDSHelperTool  * helperTool = nil;

@implementation KDSHelperTool

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helperTool = [[KDSHelperTool alloc]init];
        helperTool.lessionArr = [NSMutableArray array];
    });
    return helperTool;
}


-(instancetype)init{
    if (self = [super init]) {
        _isUnToken = NO;
    }
    return self;
}

-(void)dealloc{
    
}
@end
