//
//  KDSRefundReasonCell.m
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSRefundReasonCell.h"

@interface KDSRefundReasonCell ()
@property (nonatomic,strong)UILabel * desLabel;
@end

@implementation KDSRefundReasonCell


-(void)setDesString:(NSString *)desString{
    _desString = desString;
    
    _desLabel.text  = [KDSMallTool checkISNull:_desString];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * titleLb = [KDSMallTool createLabelString:@"退款原因" textColorString:@"#333333" font:15];
        [self.contentView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(18);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(25);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-18).priorityLow();
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
        UIImageView * arrowImage = [[UIImageView alloc]init]; //icon_list_more
        arrowImage.image = [UIImage imageNamed:@"icon_list_more"];
        [self.contentView addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(titleLb.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14));
        }];
        
        _desLabel = [KDSMallTool createLabelString:@"请选择" textColorString:@"#999999" font:15];
        [self.contentView addSubview:_desLabel];
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLb.mas_centerY);
            make.right.mas_equalTo(arrowImage.mas_left).mas_offset(-10);
        }];
        
        
    }
    return self;
}

+(instancetype)refundReasonCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSRefundReasonCellID";
    KDSRefundReasonCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
