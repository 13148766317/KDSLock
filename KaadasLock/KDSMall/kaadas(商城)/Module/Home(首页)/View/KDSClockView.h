//
//  KDSClockView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSClockView;
@protocol KDSClockViewDlegate <NSObject>

@optional
-(void)clockView:(KDSClockView *)clockView State:(BOOL)state;
@end


@interface KDSClockView : UIView
@property (nonatomic,weak)id <KDSClockViewDlegate> delegate;
@property (nonatomic,copy)NSString   *   timer;

//@property (nonatomic,assign)double        second;
//时间背景色
@property (nonatomic,copy)NSString      * timeBgColor;
//时间文本颜色
@property (nonatomic,copy)NSString      * timetextColor;
//分隔:的颜色
@property (nonatomic,copy)NSString      * separatedColor;
//
//@property (nonatomic,assign)CGSize       timeItemSize;
//-(void)pause;
//-(void)resume;
@end

NS_ASSUME_NONNULL_END
