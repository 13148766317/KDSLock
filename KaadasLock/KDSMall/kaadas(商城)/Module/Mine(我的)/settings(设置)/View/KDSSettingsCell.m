//
//  KDSSettingsCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSettingsCell.h"

@interface KDSSettingsCell ()
@property (nonatomic,strong)UILabel     * titleLb;
@property (nonatomic,strong)UIView      * dividingView;
@property (nonatomic,strong)UIImageView * arrowImageview;
@property (nonatomic,strong)UILabel   * desLb;
@end


@implementation KDSSettingsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(18);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-18).priorityLow();
        }];
        
        
        _arrowImageview = [[UIImageView alloc]init];
        _arrowImageview.image = [UIImage imageNamed:@"icon_list_more"];
        [self.contentView addSubview:_arrowImageview];
        [_arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14));
        }];
        
        _desLb = [KDSMallTool createLabelString:@"" textColorString:@"666666" font:15];
        [self.contentView addSubview:_desLb];
        [_desLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowImageview.mas_left).mas_offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:_dividingView];
        [_dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.arrowImageview.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    return self;
}
-(void)setIsClear:(BOOL)isClear{
    _isClear = isClear;
    if (_isClear) {
        _desLb.hidden = NO;
    }else{
        _desLb.hidden = YES;
    }
}

-(void)setCacheSize:(NSInteger)cacheSize{
    _cacheSize  = cacheSize;
    _desLb.text = [NSString stringWithFormat:@"%.2fM",_cacheSize / 1000.00f /1000.00f];
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLb.text = _titleString;
}

-(void)setHiddenArrow:(BOOL)hiddenArrow{
    _hiddenArrow = hiddenArrow;
    _arrowImageview.hidden = _hiddenArrow;
}

+(instancetype)settingsCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSSettingsCellID";
    KDSSettingsCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
