//
//  HelperTool.m
//  kaadas
//
//  Created by 中软云 on 2019/6/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "HelperTool.h"
static HelperTool * helperTool = nil;

@implementation HelperTool
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helperTool = [[HelperTool alloc]init];
    });
    return helperTool;
}


-(instancetype)init{
    if (self = [super init]) {
        _isUnToken = NO;
        _isUpload = true;
        _isHomeCoupon = NO;
        _clock = [NetworkClock sharedNetworkClock];
        
    }
    return self;
}

-(void)dealloc{
    
}
@end
