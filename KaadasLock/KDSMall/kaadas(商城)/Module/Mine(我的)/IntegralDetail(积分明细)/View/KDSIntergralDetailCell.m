//
//  KDSIntergralDetailCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/16.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSIntergralDetailCell.h"

@interface KDSIntergralDetailCell ()
@property (nonatomic,strong)UILabel   * titleLb;
@property (nonatomic,strong)UILabel   * timeLabel;
@property (nonatomic,strong)UILabel   * priceLb;
@end

@implementation KDSIntergralDetailCell

-(void)setRowModel:(KDSIntergralDetailRowModel *)rowModel{
    _rowModel = rowModel;
    
    _titleLb.text = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_rowModel.typeCN]];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_rowModel.createDate]];
                      
    _priceLb.text = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_rowModel.score]];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(22);
        }];
        
        _timeLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(12);
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(21);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(dividinghHeight);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
        _priceLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-15);
        }];
        
    }
    return self;
}

+(instancetype)interfralDetailCellWithTableView:(UITableView *)tableView{
    static NSString * CellID = @"KDSIntergralDetailCellID";
    KDSIntergralDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    return cell;
}
@end
