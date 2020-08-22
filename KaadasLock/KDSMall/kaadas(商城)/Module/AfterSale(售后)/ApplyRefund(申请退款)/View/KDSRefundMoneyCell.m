//
//  KDSRefundMoneyCell.m
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSRefundMoneyCell.h"

@interface KDSRefundMoneyCell ()

@end

@implementation KDSRefundMoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * topView = [KDSMallTool createDividingLineWithColorstring:@"#F7F7F7"];
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_offset(15);
        }];
        
        UILabel * titleLb = [KDSMallTool createLabelString:@"退款金额" textColorString:@"#333333" font:15];
        [self.contentView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topView.mas_bottom).mas_offset(18);
            make.left.mas_equalTo(15);
        }];
        
        
        _priceLb = [KDSMallTool createLabelString:@"￥2999" textColorString:@"#CA2128" font:15];
        [self.contentView addSubview:_priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLb.mas_centerY);
            make.right.mas_equalTo(-15);
        }];
        
        UIView * bottomView = [KDSMallTool createDividingLineWithColorstring:@"#F7F7F7"];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(18);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }
    return self;
}

+(instancetype)refundMoneyCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSRefundMoneyCellID";
    KDSRefundMoneyCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
