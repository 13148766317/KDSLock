//
//  KDSProductIntroduceCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductIntroduceCell.h"
@interface KDSProductIntroduceCell ()
@property (nonatomic,strong)UILabel   * titleLB;
@property (nonatomic,strong)UILabel   * detailLb;
@end
@implementation KDSProductIntroduceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLB = [KDSMallTool createLabelString:@"选择" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-19).priorityLow();
            make.width.mas_equalTo(30);
        }];
        
      
        //右箭头 14 25
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"icon_more_circle_detail"];
        [self.contentView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(19, 19));
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _detailLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:12];
        [self.contentView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLB.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(arrowImageView.mas_left).mas_offset(-10);
        }];
        //底部分割线
        UIView * bottomDividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:bottomDividing];
        [bottomDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
        
    }
    return self;
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLB.text = _titleString;
}

-(void)setDetailString:(NSString *)detailString{
    _detailString = detailString;
    _detailLb.text = _detailString;
}

+(instancetype)ProductIntroducCelleWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductIntroduceCellID";
    KDSProductIntroduceCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
