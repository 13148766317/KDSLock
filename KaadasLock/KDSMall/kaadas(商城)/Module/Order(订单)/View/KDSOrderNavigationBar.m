//
//  KDSOrderNavigationBar.m
//  kaadas
//
//  Created by 中软云 on 2019/7/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOrderNavigationBar.h"
#import "KDSOrderButton.h"
@interface KDSOrderNavigationBar ()

@end

@implementation KDSOrderNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        JXLayoutButton
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
//        _backButton.backgroundColor = [UIColor redColor];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.top.mas_equalTo((isIPHONE_X ? 44 : 20) + (MnavcBarH - (isIPHONE_X ? 44 : 20) - 30) / 2);
        }];
        
        _orderButton = [KDSOrderCusButton buttonWithType:UIButtonTypeCustom];
        [_orderButton setTitle:@"我的订单" forState:UIControlStateNormal];
        [_orderButton setImage:[UIImage imageNamed:@"icon_spread_nav_order"] forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        _orderButton.titleLabel.font = [UIFont systemFontOfSize:18];
//        _orderButton.midSpacing = 5;
//        _orderButton.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
//        _orderButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -10, 0);
        [self addSubview:_orderButton];
        [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backButton.mas_right);
            make.centerY.mas_equalTo(self.backButton.mas_centerY);
            make.height.mas_equalTo(self.backButton.mas_height);
            make.width.mas_equalTo(90);
        }];
    }
    return self;
}

@end
