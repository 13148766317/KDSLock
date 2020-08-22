//
//  KDSNavigationBar.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSNavigationBar : UIView
//返回button的title
@property (nonatomic,copy)NSString               * backTitle;

@property (nullable,nonatomic,strong)UIImage     * backImage;

//中间title
@property (nonatomic,copy)NSString               * title;
//中间title color
@property (nonatomic, strong) UIColor *titleColor;
//隐藏返回button
@property (nonatomic,assign)BOOL                  hiddenBackButton;
//返回button调用事件
@property (nonatomic,assign)SEL                   action;

@property (nonatomic,assign)id                    tagrget;
//导航栏右侧控件
@property (nonatomic,strong)UIControl           * rightItem;
//
@property (nonatomic,strong)UIView              * titleView;
//底部分割线的颜色
@property (nonatomic,strong)UIColor             * lineColor;
@property (nonatomic,assign)UIEdgeInsets           backImageEdgeInsets;

@end

NS_ASSUME_NONNULL_END
