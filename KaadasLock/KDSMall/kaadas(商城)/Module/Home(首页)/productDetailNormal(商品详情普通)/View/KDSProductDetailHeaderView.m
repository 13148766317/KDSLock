//
//  KDSProductDetailHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailHeaderView.h"

@implementation KDSProductDetailHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F7F7F7"];
        UILabel * titleLb = [KDSMallTool createLabelString:@"商品详情" textColorString:@"#666666" font:15];
        [self.contentView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
        
        CGFloat circleHeight = 7;
        
        UIView * leftCircle = [[UIView alloc]init];
        leftCircle.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#E6E6E6"].CGColor;
        leftCircle.layer.borderWidth = 1;
        leftCircle.layer.cornerRadius = circleHeight / 2;
        leftCircle.layer.masksToBounds = YES;
        [self.contentView addSubview:leftCircle];
        
        [leftCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titleLb.mas_left).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(circleHeight, circleHeight));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        UIView * leftLine = [KDSMallTool createDividingLineWithColorstring:@"#E6E6E6"];
        [self.contentView addSubview:leftLine];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(leftCircle.mas_left).mas_offset(0);
            make.height.mas_equalTo(dividinghHeight);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        UIView * rightCircle = [[UIView alloc]init];
        rightCircle.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#E6E6E6"].CGColor;
        rightCircle.layer.borderWidth = 1;
        rightCircle.layer.cornerRadius = circleHeight / 2;
        rightCircle.layer.masksToBounds = YES;
        [self.contentView addSubview:rightCircle];
        
        [rightCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titleLb.mas_right).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(circleHeight, circleHeight));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        UIView * rightLine = [KDSMallTool createDividingLineWithColorstring:@"#E6E6E6"];
        [self.contentView addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(dividinghHeight);
            make.left.mas_equalTo(rightCircle.mas_right).mas_offset(0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
    }
    return self;
}

+(instancetype)productDetailWithTableView:(UITableView *)tableView{
    static NSString * headerViewID = @"KDSProductDetailHeaderViewID";
    KDSProductDetailHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

@end
