//
//  KDSMineUnlockAmountCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//待解锁金额

#import "KDSMineUnlockAmountCell.h"

@interface KDSMineUnlockAmountCell ()
//金额
@property (nonatomic,strong)UILabel   * priceLabel;
//待解锁金额(元)
@property (nonatomic,strong)UILabel   * unlockLabel;
//推荐次数label
@property (nonatomic,strong)UILabel   * recommendLabel;
//邀请好友button
@property (nonatomic,strong)UIButton  * invitationButton;
@end

@implementation KDSMineUnlockAmountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //金额
        NSString * priceString = @"1400/2000";
        NSMutableAttributedString * priceAttribut = [[NSMutableAttributedString alloc]initWithString:priceString];
        [priceAttribut addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:21] range:NSMakeRange(0, 4)];
        [priceAttribut addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#000000"] range:NSMakeRange(0, 4)];
        _priceLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        _priceLabel.attributedText = priceAttribut;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(33);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        //问号
        UIButton * questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [questionButton addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
        [questionButton setImage:[UIImage imageNamed:@"icon_detail_myproperty"] forState:UIControlStateNormal];
        [self.contentView addSubview:questionButton];
        [questionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(18);
        }];
        
        //待解锁金额(元)
        _unlockLabel = [KDSMallTool createLabelString:@"待解锁金额(元)" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_unlockLabel];
        [_unlockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(12);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        //推荐次数label  推荐5次消费，解锁全部金额
        _recommendLabel = [KDSMallTool createLabelString:@"推荐5次消费，解锁全部金额" textColorString:@"#ca2128" font:12];
        [self.contentView addSubview:_recommendLabel];
        [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.unlockLabel.mas_bottom).mas_offset(24);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        //邀请好友button
        _invitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_invitationButton addTarget:self action:@selector(invitationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _invitationButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        _invitationButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_invitationButton setTitle:@"去邀请好友" forState:UIControlStateNormal];
        [self.contentView addSubview:_invitationButton];
        [_invitationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.recommendLabel.mas_bottom).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(120, 35));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        
        //分线
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.invitationButton.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }
    return self;
}

-(void)questionClick{
    if ([_delegate respondsToSelector:@selector(mineUnlockAmountCellEventClick:)]) {
        [_delegate mineUnlockAmountCellEventClick:KDSUnlockAmount_question];
    }
}

-(void)invitationButtonClick{
    if ([_delegate respondsToSelector:@selector(mineUnlockAmountCellEventClick:)]) {
        [_delegate mineUnlockAmountCellEventClick:KDSUnlockAmount_invitation];
    }
}


+(instancetype)mineUnlockAmountCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMineUnlockAmountCellID";
    KDSMineUnlockAmountCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
