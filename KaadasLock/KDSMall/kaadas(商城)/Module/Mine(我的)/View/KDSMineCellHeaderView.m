//
//  KDSMineCellHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMineCellHeaderView.h"

@interface KDSMineCellHeaderView ()
@property (nonatomic,strong)UILabel   * titleLb;
@end

@implementation KDSMineCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:15];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [self addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14 ));
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_offset(dividinghHeight);
        }];
        
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
    _titleLb.text = _text;
}


@end
