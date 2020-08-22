//
//  QZCodeTextfieldView.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/13.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QZCodeTextfieldViewDelegate <NSObject>

-(void)getCodeClick;

@end

@interface QZCodeTextfieldView : UIView

@property(nonatomic,weak)id<QZCodeTextfieldViewDelegate> delegate;
//获取输入内容
@property (nonatomic,copy)NSString * text;
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
#pragma mark - 获取验证码 事件
-(void)getCodeButtonClick;
#pragma mark - 停止计时器
-(void)stopTimer;
@end

NS_ASSUME_NONNULL_END
