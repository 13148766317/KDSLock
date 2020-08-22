//
//  KDSClockView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSClockView.h"
//#import "GCDTimerTool.h"

@interface KDSClockView ()
@property (nonatomic,strong)NSMutableArray   * timeArray;
@property (nonatomic,strong)NSMutableArray   * separatedArray;
//定时器
@property (nonatomic,strong)dispatch_source_t     gcdTimer;
@end

@implementation KDSClockView

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
        [self gcdTimeRun];
//        [self gcdTimeRun1];
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
    [self pause];
}

-(void)setTimer:(NSString *)timer{
    _timer = timer;

    if ([KDSMallTool checkISNull:_timer].length <= 0) {
        if ([_delegate respondsToSelector:@selector(clockView:State:)]) {
            [_delegate clockView:self State:NO];
        }
        return;
    }
    [self gcdTimeRun];

}


-(void)gcdTimeRun{
    
    double  duratiion =    [KDSMallTool durationIndistanceSeconds:_timer];
    if (duratiion <= 0 ) {
        if ([_delegate respondsToSelector:@selector(clockView:State:)]) {
            [_delegate clockView:self State:NO];
        }
//        [self pause];
        return;
    }
    if ([_delegate respondsToSelector:@selector(clockView:State:)]) {
        [_delegate clockView:self State:YES];
        
    }
    //小时
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(NSInteger)duratiion/3600];
    //分钟
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",((NSInteger)duratiion%3600)/60];
    //秒数
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(NSInteger)duratiion%60];
    
    
    UILabel * hourLb   = (UILabel *)[self.timeArray firstObject];
    UILabel * minuteLb = (UILabel *)self.timeArray[1];
    UILabel * secondLb = (UILabel *)[self.timeArray lastObject];
    
    //主线程刷新UI   否则崩溃
    dispatch_async(dispatch_get_main_queue(), ^{
        hourLb.text = str_hour;
        minuteLb.text = str_minute;
        secondLb.text = str_second;
    });
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createGCDTimer];
        //时间背景色
        _timeBgColor = @"#333333";
        //时间文本颜色
        _timetextColor = @"#FFFFFF";
        //分隔:的颜色
        _separatedColor = @"#333333";
        
        
        for (int i = 0; i < 3; i++) {
            //时间label
            UILabel * timeLabel = [KDSMallTool createbBoldLabelString:@"0" textColorString:_timetextColor font:10];
            timeLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:_timeBgColor];
            timeLabel.textAlignment = NSTextAlignmentCenter;
            timeLabel.layer.cornerRadius = 3;
            timeLabel.layer.masksToBounds = YES;
            [timeLabel sizeToFit];
            [self addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).mas_offset(i * (20 + 10));
                make.size.mas_equalTo(CGSizeMake(22.5, 15));
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
            
            //添加时间label控件
            [self.timeArray addObject:timeLabel];
            
            if ( i < 2) {
                //：分割
                UILabel * semicolonLabel = [KDSMallTool createLabelString:@":" textColorString:_separatedColor font:12];
                semicolonLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:semicolonLabel];
                [semicolonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(timeLabel.mas_right);
                    make.size.mas_equalTo(CGSizeMake(8, 15));
                    make.centerY.mas_equalTo(timeLabel.mas_centerY);
                }];
                [self.separatedArray addObject:semicolonLabel];
            }
        }
    }
    return self;
}

-(void)setTimeBgColor:(NSString *)timeBgColor{
    _timeBgColor = timeBgColor;
    for (UILabel * label in self.timeArray) {
        label.backgroundColor = [UIColor hx_colorWithHexRGBAString:_timeBgColor];
    }
}

-(void)setTimetextColor:(NSString *)timetextColor{
    _timetextColor = timetextColor;
    for (UILabel * label in self.timeArray) {
        label.textColor = [UIColor hx_colorWithHexRGBAString:_timetextColor];
    }
}

-(void)setSeparatedColor:(NSString *)separatedColor{
    _separatedColor = separatedColor;
    for (UILabel * label in self.separatedArray) {
        label.textColor = [UIColor hx_colorWithHexRGBAString:_separatedColor];
    }
}

#pragma mark - 懒加载
-(NSMutableArray *)timeArray{
    if (_timeArray == nil) {
        _timeArray = [NSMutableArray array];
    }
    return _timeArray;
}

-(NSMutableArray *)separatedArray{
    if (_separatedArray == nil) {
        _separatedArray = [NSMutableArray array];
    }
    return _separatedArray;
}
@end
