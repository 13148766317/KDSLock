//
//  KDSSystemMessageCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSystemMessageCell.h"

@interface KDSSystemMessageCell ()
//时间
@property (nonatomic,strong)UILabel   * timeLabel;
//title
@property (nonatomic,strong)UILabel   * titleLb;
//详情
@property (nonatomic,strong)UILabel   * detailLabel;
@end

@implementation KDSSystemMessageCell

-(void)setRowModel:(KDSMessageRowModel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //时间
    _timeLabel.text = [KDSTool timestampSwitchTime:([[KDSMallTool checkISNull:_rowModel.senderDate] integerValue]/1000) andFormatter:@"YYYY-MM-dd"];
    
    //title
    _titleLb.text = [KDSMallTool checkISNull:_rowModel.title];
    
    //详情
    NSString * detailStr = [KDSMallTool checkISNull:_rowModel.content];
    NSMutableAttributedString * detailAttribut = [[NSMutableAttributedString alloc]initWithString:detailStr];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10; // 调整行间距
    
    [detailAttribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailStr.length)];
    _detailLabel.attributedText = detailAttribut;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        
        //时间
        _timeLabel = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        //白色背景
        UIView * whiteBgView = [[UIView alloc]init];
        whiteBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:whiteBgView];
        
        
        //title
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        _titleLb.numberOfLines = 0;
        [whiteBgView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(20);
        }];
        
        //详情
        _detailLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        _detailLabel.numberOfLines = 0;
        [whiteBgView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.titleLb.mas_right);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(18);
            make.bottom.mas_equalTo(whiteBgView.mas_bottom).mas_offset(-20);
        }];
      
        
        
        [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0).priorityLow();
        }];
        
        
    }
    return self;
}

+(instancetype)systemMessageCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSSystemMessageCellID";
    KDSSystemMessageCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
