//
//  KDSPayTableCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPayTableCell.h"

@interface KDSPayTableCell ()
@property (nonatomic,strong)UIImageView   * iconImageView;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UIButton      * selectButton;
@end

@implementation KDSPayTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"icon_pay_nor"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"icon_pay_sel"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-27);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.selectButton.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    [super hitTest:point withEvent:event];
    return self;
}

-(void)setPayTypeModel:(PayTypeModel *)payTypeModel{
    _payTypeModel = payTypeModel;
    
    _iconImageView.image   = [UIImage imageNamed:_payTypeModel.iconString];
    _titleLb.text          = _payTypeModel.typeName;
    _selectButton.selected = _payTypeModel.isSelected;
    
}

+(instancetype)payTableViewCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSPayTableCellID";
    KDSPayTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
