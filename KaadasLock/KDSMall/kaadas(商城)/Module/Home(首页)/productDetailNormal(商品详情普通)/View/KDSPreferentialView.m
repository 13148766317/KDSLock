//
//  KDSPreferentialView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPreferentialView.h"

@interface KDSPreferentialView ()
@property (nonatomic,strong)UILabel   * detailLb;

@end

@implementation KDSPreferentialView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f6ede3"];
        _detailLb = [KDSMallTool createLabelString:@"" textColorString:@"#8a7a6a" font:12];
        [self addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        NSString * detailString = @"使用优惠至少可减¥300";
        NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc]initWithString:detailString];
        [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] range:NSMakeRange(detailString.length - 4, 4)];
        _detailLb.attributedText = attributed;
        
        
        //
        UIButton * getPreferentialButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getPreferentialButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#8a7a6a"].CGColor;
        getPreferentialButton.layer.borderWidth = 1;
        getPreferentialButton.layer.cornerRadius = 22 / 2;
        [getPreferentialButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#8a7a6a"] forState:UIControlStateNormal];
        getPreferentialButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [getPreferentialButton setTitle:@"领劵" forState:UIControlStateNormal];
        [self addSubview:getPreferentialButton];
        _getPreferentialButton = getPreferentialButton;
        [getPreferentialButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 22));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(-20);
        }];
    }
    return self;
}

@end
