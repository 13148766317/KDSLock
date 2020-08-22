//
//  KDSMessageCenterCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMessageCenterCell.h"

@interface KDSMessageCenterCell ()
@property (nonatomic,strong)UIImageView   * iconView;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UILabel       * numberLabel;
@end

@implementation KDSMessageCenterCell


#pragma mark - setter
//-(void)setTitleString:(NSString *)titleString{
//    _titleString = titleString;
//    _titleLb.text = _titleString;
//}
//
//#pragma mark - setter
//-(void)setImageString:(NSString *)imageString{
//    _imageString = imageString;
//    _iconView.image = [UIImage imageNamed:_imageString];
//}


-(void)setModel:(KDSSytemMsgNumModel *)model{
    _model = model;
    if ([KDSMallTool checkObjIsNull:_model]) {
        return;
    }
    
    _titleLb.text = [KDSMallTool checkISNull:_model.title];
    
    NSString *messageType =  [KDSMallTool checkISNull:_model.messageType];
    
    NSString * imageStr = @"";
    if ([messageType isEqualToString:@"message_type_activity"]) {//活动消息
        imageStr = @"icon_activity_mine_message";
    }else if ([messageType isEqualToString:@"message_type_indent"]){//订单消息
        imageStr = @"icon_goods_mine_message";
    }else if ([messageType isEqualToString:@"message_type_system"]){//系统消息
        imageStr = @"icon_system_mine_message";
    }
    _iconView.image = [UIImage imageNamed:imageStr];
    
    //数字提醒
    if (_model.number <=0 ) {
        _numberLabel.hidden = YES;
    }else{
        _numberLabel.hidden = NO;
        _numberLabel.text = [NSString stringWithFormat:@"%ld",_model.number];
    }
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //图片
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        
        //标题
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        //右箭头
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [self.contentView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14 ));
        }];
        
       //数字提醒
        CGFloat numberLabelW = 20;
        _numberLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"FFFFFF" font:12];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
        _numberLabel.layer.cornerRadius = numberLabelW / 2;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.hidden = YES;
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowImageView.mas_left).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(numberLabelW, numberLabelW));
        }];
        
        //分割线
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(11);
            make.right.mas_equalTo(-11);
            make.bottom.mas_equalTo(0);
            make.height.mas_offset(dividinghHeight);
        }];
        
    }
    return self;
}

+(instancetype)messageCenterCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMessageCenterCellID";
    KDSMessageCenterCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
