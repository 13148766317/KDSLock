//
//  KDSProductServiceCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductServeCell.h"

@interface KDSProductServeCell ()
@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel   * titleLb;
@property (nonatomic,strong)UILabel   * detailLb;
@end

@implementation KDSProductServeCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    _iconImageView.image = [UIImage imageNamed:_dict[@"image"]];
    _titleLb.text = _dict[@"title"];
    _detailLb.attributedText = [KDSMallTool attributedString:_dict[@"detail"] lineSpacing:8];
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"icon_brand_service"];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(15, 15 * 34 / 30));
            make.top.mas_equalTo(15);
        }];
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(20);
        }];
        
        
        _detailLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        _detailLb.numberOfLines = 0;
        [self.contentView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(15);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-20).priorityLow();
        }];
    }
    return self;
}

+(instancetype)productServeCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductServeCellID";
    KDSProductServeCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
