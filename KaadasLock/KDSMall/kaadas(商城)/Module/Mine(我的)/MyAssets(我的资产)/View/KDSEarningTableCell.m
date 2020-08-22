//
//  KDSEarningTableCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningTableCell.h"

@interface KDSEarningTableCell ()
//时间
@property (nonatomic,strong)UILabel      * timeLabel;

//金额
@property (nonatomic,strong)UILabel      * sumLabel;
//收益类型
@property (nonatomic,strong)UILabel      * enterningTypeLB;
//结余
@property (nonatomic,strong)UILabel      * remainingLabel;
@end

@implementation KDSEarningTableCell

-(void)setDayModel:(KDSEarningDayModel *)dayModel{
    _dayModel = dayModel;
    if ([KDSMallTool checkObjIsNull:_dayModel]) {
        return;
    }
    //时间
    _timeLabel.text = [KDSMallTool checkISNull:_dayModel.daytime];
    
    //结余
    _remainingLabel.text = [KDSMallTool checkISNull:_dayModel.balance];
    
    if ([_dayModel.commissionType isEqualToString:@"getMoney"]) {//提现
        //收益金额
        _sumLabel.text = [NSString stringWithFormat:@"- %@",[KDSMallTool checkISNull:_dayModel.money]];
        _sumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#41B982"];
        
    }else if ([_dayModel.commissionType isEqualToString:@"moneyTransferFees"]){//手续费
        //收益金额
        _sumLabel.text = [NSString stringWithFormat:@"- %@",[KDSMallTool checkISNull:_dayModel.money]];
         _sumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#41B982"];
        
    }else if([_dayModel.commissionType isEqualToString:@"directOne"]){//直接收益
        //收益金额
        _sumLabel.text = [NSString stringWithFormat:@"+ %@",[KDSMallTool checkISNull:_dayModel.money]];
        _sumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#F36A5F"];
        
    }else if([_dayModel.commissionType isEqualToString:@"directTwo"]){//间接收益
        //收益金额
        _sumLabel.text = [NSString stringWithFormat:@"+ %@",[KDSMallTool checkISNull:_dayModel.money]];
        _sumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#F36A5F"];
    }else if([_dayModel.commissionType isEqualToString:@"pearlReward"]){//介绍收益
        //收益金额
        _sumLabel.text = [NSString stringWithFormat:@"+ %@",[KDSMallTool checkISNull:_dayModel.money]];
        _sumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#F36A5F"];
    }
    //收益类型
    _enterningTypeLB.text = [NSString stringWithFormat:@"%@",_dayModel.commissionTypeCN];
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        //时间
        _timeLabel = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(21);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-20).priorityLow();
        }];
        
        
        //收益金额
        _sumLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:18];
        [self.contentView addSubview:_sumLabel];
        [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).multipliedBy(0.7);
            make.bottom.mas_equalTo(self.timeLabel.mas_centerY).mas_offset(-2);
        }];
        
        //收益类型
        _enterningTypeLB = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_enterningTypeLB];
        [_enterningTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sumLabel.mas_left);
            make.top.mas_equalTo(self.timeLabel.mas_centerY).mas_offset(4);
        }];
        
        //结余
        _remainingLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_remainingLabel];
        [_remainingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        //分线
        UIView  * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    return self;
}

+(instancetype)earningCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSEarningTableCellID";
    KDSEarningTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
