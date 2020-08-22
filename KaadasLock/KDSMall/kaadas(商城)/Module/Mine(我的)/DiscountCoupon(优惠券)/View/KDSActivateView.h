//
//  KDSActivateView.h
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSActivateViewDelegate <NSObject>
-(void)activateViewActivationButtonClick:(NSString *)text;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSActivateView : UIView
@property (nonatomic,weak)id <KDSActivateViewDelegate> delegate;
//获取输入框内容
@property (nonatomic,copy)NSString      * text;
@end

NS_ASSUME_NONNULL_END
