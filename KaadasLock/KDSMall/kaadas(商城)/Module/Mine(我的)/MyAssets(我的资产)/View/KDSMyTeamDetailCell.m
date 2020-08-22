//
//  KDSMyTeamDetailCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyTeamDetailCell.h"

@interface KDSMyTeamDetailCell ()
//头像
@property (nonatomic,strong)UIImageView * iconImageview;
//昵称
@property (nonatomic,strong)UILabel     * nickLabel;
//ID
@property (nonatomic,strong)UILabel     * IDLabel;
//直接下级
@property (nonatomic,strong)UILabel     * directSubordinatesLb;
//间接下级
@property (nonatomic,strong)UILabel     * indirectSubordinatesiLB;
@end

@implementation KDSMyTeamDetailCell

-(void)setRowModel:(KDSMyTeamRowModel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //头像
    [_iconImageview sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.logo]] placeholderImage:[UIImage imageNamed:@"pic_head_mine"]];
    //昵称
    _nickLabel.text = [KDSMallTool checkISNull:_rowModel.name];
    
    //ID
    _IDLabel.text = [NSString stringWithFormat:@"ID:%@",[KDSMallTool checkISNull:_rowModel.tel]];
    
    //直接下级
    _directSubordinatesLb.text = [NSString stringWithFormat:@"直接下级：%@人",_rowModel.direct_one_count];
    
    //间接下级
    _indirectSubordinatesiLB.text = [NSString stringWithFormat:@"间接下级：%@人",_rowModel.direct_two_count];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        //头像
        CGFloat iconHeight =45.0f;
        _iconImageview = [[UIImageView alloc]init];
        _iconImageview.layer.cornerRadius = iconHeight / 2;
        _iconImageview.layer.masksToBounds = YES;
        _iconImageview.image = [UIImage imageNamed:@"pic_head_mine"];
        [self.contentView addSubview:_iconImageview];
        [_iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(27);
            make.size.mas_equalTo(CGSizeMake(iconHeight, iconHeight));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-27).priorityLow();
        }];
        
        //昵称
        _nickLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageview.mas_top).mas_offset(-0);
            make.left.mas_equalTo(self.iconImageview.mas_right).mas_offset(15);
        }];
        
        //ID
        _IDLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_IDLabel];
        [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickLabel.mas_left);
            make.bottom.mas_equalTo(self.iconImageview.mas_bottom).mas_offset(5);
        }];
        
        //直接下级
        _directSubordinatesLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:12];
        [self.contentView addSubview:_directSubordinatesLb];
        [_directSubordinatesLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(30);
            make.centerY.mas_equalTo(self.nickLabel.mas_centerY);
        }];
        
        //间接下级
        _indirectSubordinatesiLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:12];
        [self.contentView addSubview:_indirectSubordinatesiLB];
        [_indirectSubordinatesiLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.directSubordinatesLb.mas_left);
            make.centerY.mas_equalTo(self.IDLabel.mas_centerY);
        }];
        
        //分割线
        UIView * dividingView  = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageview.mas_left);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(dividinghHeight);
        }];
    }
    return self;
}

+(instancetype)myTeamDetailCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMyTeamDetailCellID";
    KDSMyTeamDetailCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
