//
//  KDSGenderTableCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSGenderTableCell.h"

@interface KDSGenderTableCell ()
@property (nonatomic,strong)UILabel    * genderLb;
@property (nonatomic,strong)UIButton   * selectButton;
@property (nonatomic,strong)UIView     * dividingView;
@end


@implementation KDSGenderTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _genderLb  = [KDSMallTool createLabelString:@"12" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_genderLb];
        [_genderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"btn_sel"] forState:UIControlStateSelected];
        
        [_selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-50);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        
        _dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:_dividingView];
        [_dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
    }
    return self;
}

-(void)selectButtonClick{
    if ([_delegate respondsToSelector:@selector(genderCellSelect:)]) {
        [_delegate genderCellSelect:_indexPath.row];
    }
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    if (_indexPath.row == _selectIndex) {
        _selectButton.selected = YES;
    }else{
        _selectButton.selected = NO;
    }
}

-(void)setHiddenDividing:(BOOL)hiddenDividing{
    _hiddenDividing = hiddenDividing;
    _dividingView.hidden = _hiddenDividing;
}

-(void)setTitltString:(NSString *)titltString{
    _titltString = titltString;
    _genderLb.text = _titltString;
}

+(instancetype)genderCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSGenderTableCellID";
    KDSGenderTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
