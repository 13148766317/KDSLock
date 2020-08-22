//
//  KDSNoCouponView.m
//  kaadas
//
//  Created by 中软云 on 2019/7/17.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNoCouponView.h"

@interface KDSNoCouponView ()

@end

@implementation KDSNoCouponView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton * topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [topButton setImage:[UIImage imageNamed:@"coupon_missing_pages"] forState:UIControlStateNormal];
        [self addSubview:topButton];
        [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.left.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.6);
        }];
        
        
        NSString * desString = @"很遗憾\n您暂无可以使用的优惠券";
        UILabel * desLabel = [KDSMallTool createLabelString:@"" textColorString:@"#CCCCCC" font:15];
        desLabel.numberOfLines = 0;
        [self addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topButton.mas_bottom).mas_offset(20);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        desLabel.attributedText = [KDSMallTool attributedString:desString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"#999999"]} range:NSMakeRange(0, 3) lineSpacing:10 alignment:NSTextAlignmentCenter];
        
        
    }
    return self;
}
@end
