//
//  BSOrderStatusView.h
//  BuyAndSend
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopBarViewDelegate <NSObject>
/// 选中某个tab
- (void)statusViewSelectIndex:(NSInteger)index;
@end

@interface TopBarView : UIView
/// 是否正在滑动
@property (nonatomic, assign) BOOL isScroll;
/// 代理
@property (nonatomic, weak) id <TopBarViewDelegate>delegate;
/// 界面初始化
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor;
/// 切换tag
-(void)changeTag:(NSInteger)tag;


@end
