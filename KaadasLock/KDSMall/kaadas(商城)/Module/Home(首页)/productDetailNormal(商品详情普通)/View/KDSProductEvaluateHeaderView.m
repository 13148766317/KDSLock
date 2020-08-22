//
//  KDSProductEvaluateHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductEvaluateHeaderView.h"


@interface KDSProductEvaluateHeaderView ()

@end

@implementation KDSProductEvaluateHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        //底部分割线
        UIView * boldDividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:boldDividing];
        [boldDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(15);
            make.left.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-100).priorityLow();
        }];


        //点击背景
        UIButton * bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton addTarget:self action:@selector(bgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bgButton];
        [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(boldDividing.mas_bottom);
        }];


        _titleLb = [KDSMallTool createLabelString:@"商品评价(0)" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(boldDividing.mas_bottom).mas_offset(20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10).priorityMedium();
        }];


        //箭头
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"more_blue"];
        [self.contentView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.titleLb.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(7, 7 * 26 / 15));
        }];

        //查看全部
        UILabel * moreLabel = [KDSMallTool createLabelString:@"查看全部" textColorString:@"#1F96F7" font:12];
        [self.contentView addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowImageView.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(arrowImageView.mas_centerY);
        }];
    }
    return self;
}

-(void)bgButtonClick{
    if ([_delegate respondsToSelector:@selector(productEvaluateBgButtonClick)]) {
        [_delegate productEvaluateBgButtonClick];
    }
}


+(instancetype)productEvaluteHeaderViewWithTableView:(UITableView *)tableView{
    static NSString * headerViewID = @"KDSProductEvaluateHeaderViewID";
    KDSProductEvaluateHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

@end
