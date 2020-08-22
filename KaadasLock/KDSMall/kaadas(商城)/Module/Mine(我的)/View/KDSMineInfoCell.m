//
//  KDSMineInfoCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMineInfoCell.h"

@interface KDSMineInfoCell ()
//头像
@property (nonatomic,strong)UIImageView   * iconImageView;
//昵称
@property (nonatomic,strong)UILabel   * nickName;
//职位
@property (nonatomic,strong)UILabel   * positionLabel;
//二维码
@property (nonatomic,strong)UIImageView   * QRCodeImageview;
@end

@implementation KDSMineInfoCell
//
#pragma mark - 消息提醒事件
-(void)msgClockButtonClick{
    if ([_delegate respondsToSelector:@selector(mineInfoCellEventType:)]) {
        [_delegate mineInfoCellEventType:KDSMineInfoEvent_message];
    }
}

#pragma mark - 设置事假
-(void)setButtonClick{
    if ([_delegate respondsToSelector:@selector(mineInfoCellEventType:)]) {
        [_delegate mineInfoCellEventType:KDSMineInfoEvent_setting];
    }
}

#pragma mark - 头像点击
-(void)iconTapClick{
    if ([_delegate respondsToSelector:@selector(mineInfoCellEventType:)]) {
        [_delegate mineInfoCellEventType:KDSMineInfoEvent_icon];
    }
}

#pragma mark - 二维码点击
-(void)QRCodeTapClick{
    if ([_delegate respondsToSelector:@selector(mineInfoCellEventType:)]) {
        [_delegate mineInfoCellEventType:KDSMineInfoEvent_QRCode];
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
     
        //头像
        CGFloat iconHeigh = 60.0f;
        _iconImageView = [[UIImageView alloc]init];
//        _iconImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer * icontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapClick)];
//        [_iconImageView addGestureRecognizer:icontap];
         _iconImageView.image = [UIImage imageNamed:@"pic_head_mine"];
        _iconImageView.layer.cornerRadius = iconHeigh / 2;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(iconHeigh, iconHeigh));
        }];
        
        //分割线
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(26);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
        //昵称
        _nickName = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(19);
            make.top.mas_equalTo(self.iconImageView.mas_top).mas_offset(5);
        }];
        
        //职位
        _positionLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_positionLabel];
        [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickName.mas_left);
            make.bottom.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(-5);
        }];
        
//        //二维码
//        _QRCodeImageview = [[UIImageView alloc]init];
//        _QRCodeImageview.userInteractionEnabled = YES;
//        _QRCodeImageview.image = [UIImage imageNamed:@"icon_qrcode_mine"];
//        UITapGestureRecognizer * qrCodeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QRCodeTapClick)];
//        [_QRCodeImageview addGestureRecognizer:qrCodeTap];
//        _QRCodeImageview.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
//        [self.contentView addSubview:_QRCodeImageview];
//        [_QRCodeImageview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-17);
//            make.size.mas_equalTo(CGSizeMake(26, 26));
//            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
//        }];
        
        
        //消息提醒button
        UIButton * msgClockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [msgClockButton setImage:[UIImage imageNamed:@"icon_news_mine"] forState:UIControlStateNormal];
        [msgClockButton addTarget:self action:@selector(msgClockButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:msgClockButton];
        [msgClockButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
//            make.size.mas_equalTo(CGSizeMake(28, 28));
//            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(28, 28));
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        }];
        
        
        //设置button
        UIButton  * setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [setButton addTarget:self action:@selector(setButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [setButton setImage:[UIImage imageNamed:@"icon_set_mine"] forState:UIControlStateNormal];
        [self.contentView addSubview:setButton];
        [setButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(msgClockButton.mas_top);
            make.right.mas_equalTo(msgClockButton.mas_left).mas_offset(-20);
            make.width.mas_equalTo(msgClockButton.mas_width);
            make.height.mas_equalTo(msgClockButton.mas_height);
        }];
        
        
        [self refreshData];
        
    }
    return self;
}

-(void)refreshData{
    
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    //头像
    NSURL * iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",userModel.logo]];
     [_iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"pic_head_mine"]];
    //昵称
    _nickName.text = [KDSMallTool checkISNull:userModel.userName];
    //职位
    _positionLabel.text = [KDSMallTool checkISNull:userModel.levelCN];
//    //二维码
//    NSURL * QRCodeUrl = [NSURL URLWithString:[KDSMallTool checkISNull:userModel.qrImgUrl]];
//    [_QRCodeImageview sd_setImageWithURL:QRCodeUrl placeholderImage:[UIImage imageNamed:@""]];
}

+(instancetype)MineInfoWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMineInfoCellID";
    KDSMineInfoCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
