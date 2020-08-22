//
//  KDSOrderMessageCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOrderMessageCell.h"

@interface KDSOrderMessageCell ()
//时间
@property (nonatomic,strong)UILabel   * timeLabel;
//title
@property (nonatomic,strong)UILabel   * titleLb;
//详情
@property (nonatomic,strong)UILabel   * detailLabel;
@end

@implementation KDSOrderMessageCell

-(void)whiteButtonClick{
    if ([_delegate respondsToSelector:@selector(orderMessageCellCheckDetailButtonClick:)]) {
        [_delegate orderMessageCellCheckDetailButtonClick:_indexPath];
    }
}

-(void)setRowModel:(KDSMessageRowModel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    //时间
    _timeLabel.text =  [KDSMallTool checkISNull:_rowModel.senderDate];//[KDSTool timestampSwitchTime:([[KDSMallTool checkISNull:_rowModel.senderDate] integerValue]/1000) andFormatter:@"YYYY-MM-dd"];
    
    //title
    _titleLb.text = [KDSMallTool checkISNull:_rowModel.title];
    
    
    //设置文本的行间距
    NSString * detailStr =[KDSMallTool checkISNull:_rowModel.content];
    NSMutableAttributedString * detailAttribut = [[NSMutableAttributedString alloc]initWithString:detailStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; // 调整行间距
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
        }];


        [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(20);
        }];

        //分割线
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(whiteBgView.mas_left);
            make.top.mas_equalTo(whiteBgView.mas_bottom);
            make.right.mas_equalTo(whiteBgView.mas_right);
            make.height.mas_equalTo(dividinghHeight);
        }];


        UIButton * whiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [whiteButton addTarget:self action:@selector(whiteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        whiteButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:whiteButton];
        [whiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dividing.mas_left);
            make.right.mas_equalTo(dividing.mas_right);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(dividing.mas_bottom);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0).priorityLow();
        }];

        //查看详情
        UILabel * checkDetailLb = [KDSMallTool createLabelString:@"查看详情" textColorString:@"#666666" font:15];
        [whiteButton addSubview:checkDetailLb];
        [checkDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(whiteButton.mas_centerY);
        }];

        //右箭头
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [whiteButton addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(whiteButton.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14 ));
        }];
        
        
    }
    return self;
}

+(instancetype)orderMessageCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSOrderMessageCellID";
    KDSOrderMessageCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
