//
//  KDSActivityMessageCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSActivityMessageCell.h"

@interface KDSActivityMessageCell ()
//时间
@property (nonatomic,strong)UILabel   * timeLabel;
//产品图片
@property (nonatomic,strong)UIImageView   * productImageView;
//title
@property (nonatomic,strong)UILabel   * titleLb;
//详情
@property (nonatomic,strong)UILabel   * detailLabel;
//活动结束图片覆盖层
@property (nonatomic,strong)UIView   * activityEndBgView;
//活动结束
@property (nonatomic,strong)UILabel   * activityEdnLb;
@end

@implementation KDSActivityMessageCell


-(void)setRowModel:(KDSMessageRowModel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //时间
    _timeLabel.text = [KDSTool timestampSwitchTime:([[KDSMallTool checkISNull:_rowModel.senderDate] integerValue]/1000) andFormatter:@"YYYY-MM-dd"];
    //产品图片
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.logo]] placeholderImage:[UIImage imageNamed:placeholder_w]];
    //title
    _titleLb.text = [KDSMallTool checkISNull:_rowModel.title];
    
    _detailLabel.text = [KDSMallTool checkISNull:_rowModel.content];
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
       
        //产品图片
        _productImageView = [[UIImageView alloc]init];
        _productImageView.userInteractionEnabled = YES;
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.clipsToBounds = YES;
        _productImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [whiteBgView addSubview:_productImageView];
        [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(9);
            make.right.mas_equalTo(-9);
            make.height.mas_equalTo(self.productImageView.mas_width).multipliedBy(0.5);
        }];
        
        //活动结束图片覆盖层
        _activityEndBgView = [[UIView alloc]init];
        _activityEndBgView.hidden = YES;
        _activityEndBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
        _activityEndBgView.alpha = 0.9;
        [_productImageView addSubview:_activityEndBgView];
        [_activityEndBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.productImageView);
        }];
        
        //活动结束label
        _activityEdnLb = [KDSMallTool createLabelString:@"活动结束" textColorString:@"#ffffff" font:18];
        _activityEdnLb.hidden = YES;
        [_productImageView addSubview:_activityEdnLb];
        [_activityEdnLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.productImageView);
        }];
        
        
        //title
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        _titleLb.numberOfLines = 0;
        [whiteBgView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.productImageView.mas_bottom).mas_offset(20);
        }];
        
        //详情
//        NSString * detailStr = @"您好，您有一个新的订单有一个新的订单有一...";
        _detailLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
//        _detailLabel.numberOfLines = 0;
        [whiteBgView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.titleLb.mas_right);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(18);
            make.bottom.mas_equalTo(whiteBgView.mas_bottom).mas_offset(-20);
        }];
        
//        NSMutableAttributedString * detailAttribut = [[NSMutableAttributedString alloc]initWithString:detailStr];
//
//        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineSpacing = 10; // 调整行间距
//
//        [detailAttribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailStr.length)];
//        _detailLabel.attributedText = detailAttribut;
        
        
        [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0).priorityLow();
        }];
    }
    return self;
}

+(instancetype)activityMessageCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSActivityMessageCellID";
    KDSActivityMessageCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
