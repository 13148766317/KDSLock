//
//  KDSInviteFriendCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSInviteFriendCell.h"

@interface KDSInviteFriendCell ()
//头像
@property (nonatomic,strong)UIImageView   * iconImageView;
//昵称
@property (nonatomic,strong)UILabel   * nickNameLb;
//手机号
@property (nonatomic,strong)UILabel   * phoneLabel;
//时间
@property (nonatomic,strong)UILabel   * timeLabel;
@end

@implementation KDSInviteFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //头像
        CGFloat iconWidth = 40.0f;
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = iconWidth / 2;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"pic_head_list"];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(27);
            make.size.mas_equalTo(CGSizeMake(iconWidth, iconWidth));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-25).priorityLow();
        }];
        
        //昵称
        _nickNameLb = [KDSMallTool createbBoldLabelString:@"张三" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_nickNameLb];
        [_nickNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(25);
            make.top.mas_equalTo(self.iconImageView.mas_top);
        }];
        //手机号
        _phoneLabel = [KDSMallTool createLabelString:@"13826535971" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickNameLb.mas_right).mas_offset(30);
            make.bottom.mas_equalTo(self.nickNameLb.mas_bottom);
        }];
        
        //时间
        _timeLabel = [KDSMallTool createLabelString:@"2018-09-09 10:20:32  邀请加入" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickNameLb.mas_left);
            make.bottom.mas_equalTo(self.iconImageView.mas_bottom);
        }];
        
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    return self;
}

+(instancetype)inviteFriendCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSInviteFriendCellID";
    KDSInviteFriendCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
