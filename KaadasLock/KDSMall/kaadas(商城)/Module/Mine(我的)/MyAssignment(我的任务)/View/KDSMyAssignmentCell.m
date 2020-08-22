//
//  KDSMyAssignmentCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyAssignmentCell.h"

@interface KDSMyAssignmentCell ()
@property (nonatomic,strong)UIImageView   * photoImageView;
@property (nonatomic,strong)UILabel   * titleLb;
@property (nonatomic,strong)UILabel   * invitationLabel;
@property (nonatomic,strong)UILabel   * getMoneyLb;
@property (nonatomic,strong)UIButton   * rightButton;
@end

@implementation KDSMyAssignmentCell


-(void)setRowModel:(KDSMyTaskOnGoingRowmodel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //图片
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    _titleLb.text = [KDSMallTool checkISNull:_rowModel.name];
    
    //已完成提醒
    _invitationLabel.text =  [NSString stringWithFormat:@"已邀请%ld人,还需要邀请%ld人",_rowModel.finishQty,_rowModel.notFinishQty];
    
    _getMoneyLb.text = [NSString stringWithFormat:@"邀请%ld人即可提现",_rowModel.conditionQty];
}


-(void)setFinishModel:(KDSmyTaskFinishRowModel *)finishModel{
    _finishModel = finishModel;
    if ([KDSMallTool checkObjIsNull:_finishModel]) {
        return;
    }
    
    //图片
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_finishModel.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    _titleLb.text = [KDSMallTool checkISNull:_finishModel.name];
    
    //已完成提醒
    _invitationLabel.text =  [NSString stringWithFormat:@"已成功邀请%@人",_finishModel.conditionQty];
    _getMoneyLb.text = [NSString stringWithFormat:@"邀请%@人即可提现",_finishModel.finishTime];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //分割线
        UIView  * boldDividing = [KDSMallTool createDividingLineWithColorstring:@"F7F7F7"];
        [self.contentView addSubview:boldDividing];
        [boldDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(15);
        }];
        
        //图片
        CGFloat imageH = 60;
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.layer.cornerRadius = imageH / 2;
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        [self.contentView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(boldDividing.mas_bottom).mas_offset(30);
            make.size.mas_equalTo(CGSizeMake(imageH, imageH));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30).priorityLow();
        }];
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.photoImageView.mas_right).mas_offset(20);
            make.top.mas_equalTo(self.photoImageView.mas_top).mas_offset(-5);
        }];
        
        _invitationLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_invitationLabel];
        [_invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.centerY.mas_equalTo(self.photoImageView.mas_centerY).mas_offset(5);
        }];
        
        _getMoneyLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_getMoneyLb];
        [_getMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.invitationLabel.mas_left);
            make.bottom.mas_equalTo(self.photoImageView.mas_bottom).mas_offset(6);
        }];
        
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_rightButton];
        _rightButton.layer.cornerRadius = 30 /2;
        _rightButton.layer.masksToBounds = YES;
       
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(self.invitationLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(90, 30));
        }];
        
        
    }
    return self;
}

-(void)rightButtonClick{

    if ([_delegate respondsToSelector:@selector(myAssignmentButtonClickIndexPath:)]) {
        [_delegate myAssignmentButtonClickIndexPath:_indexPath];
    }
    
}

-(void)setCellType:(KDSAssignmentCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case KDSAssignmentCellType_proceed:{//进行中
            [_rightButton setTitle:@"邀请好友" forState:UIControlStateNormal];
        }
            break;
        case KDSAssignmentCellType_complete:{//已完成
             [_rightButton setTitle:@"查看好友" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

+(instancetype)myAssignmentCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMyAssignmentCellID";
    KDSMyAssignmentCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
