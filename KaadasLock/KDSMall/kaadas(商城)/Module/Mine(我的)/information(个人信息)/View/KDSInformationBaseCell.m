//
//  KDSInformationBaseCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSInformationBaseCell.h"

@implementation KDSInformationBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLb = [KDSMallTool createLabelString:@"12" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(18);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-18).priorityLow();
        }];
        
        
        //右箭头
        _arrowImageView  = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14));
        }];
        
        _detailLabel = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:15];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowImageView.mas_left).mas_offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        //分割线
        _dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:_dividingView];
        [_dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.arrowImageView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
    }
    return self;
}


+(instancetype)informationBaseCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSInformationBaseCellID";
    KDSInformationBaseCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLb.text = _titleString;
}

-(void)setDetailString:(NSString *)detailString{
    _detailString = detailString;
    _detailLabel.text = _detailString;
}
@end
