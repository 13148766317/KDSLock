//
//  KDSIconTableCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSIconTableCell.h"

@interface KDSIconTableCell ()

@end

@implementation KDSIconTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(30);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-25).priorityLow();
        }];
        
        
        CGFloat iconHeight = 50.0f;
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"pic_head_mine"];
        _iconImageView.layer.cornerRadius = iconHeight / 2;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowImageView.mas_left).mas_offset(-20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(iconHeight, iconHeight));
        }];
        
    }
    return self;
}

+(instancetype)iconCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSIconTableCellID";
    KDSIconTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}



@end
