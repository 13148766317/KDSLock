//
//  GCDTimerTool.m
//  kaadas
//
//  Created by 中软云 on 2019/6/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "GCDTimerTool.h"

static GCDTimerTool * timerTool = nil;

@interface GCDTimerTool ()
//定时器
@property (nonatomic,strong)dispatch_source_t     gcdTimer;

@end


@implementation GCDTimerTool


//+(instancetype)shareInstance{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        timerTool = [[GCDTimerTool alloc]init];
//    });
//    return timerTool;
//}


-(instancetype)init{
    if (self = [super init]) {
        [self createGCDTimer];
    }
    return self;
}

#pragma mark - 创建定时器
-(void)createGCDTimer{
    
    if (_gcdTimer) {
        dispatch_cancel(_gcdTimer);
        _gcdTimer = nil;
    }
    
    _gcdTimer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0*NSEC_PER_SEC);
    dispatch_source_set_timer(_gcdTimer, start, interval, 0);
    
//    static NSInteger i = 0;
    dispatch_source_set_event_handler(_gcdTimer, ^{
       
    });
    
    //启动定时器
    dispatch_resume(_gcdTimer);
}

-(void)resume{
    //重新加载一次定时器
    [self createGCDTimer];
}

//
-(void)pause{
    if (_gcdTimer) {
        dispatch_cancel(_gcdTimer);
        _gcdTimer = nil;
    }
}

-(void)dealloc{
    
}

@end
