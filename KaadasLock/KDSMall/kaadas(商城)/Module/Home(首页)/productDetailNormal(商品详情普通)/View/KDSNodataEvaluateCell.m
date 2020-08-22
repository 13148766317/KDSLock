//
//  KDSNodataEvaluateCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNodataEvaluateCell.h"

@interface KDSNodataEvaluateCell ()
@property (nonatomic,strong)UIImageView   * noDataImageView;
@property (nonatomic,strong)UILabel        * noDataLabel;
@end

@implementation KDSNodataEvaluateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _noDataImageView = [[UIImageView alloc]init];
        _noDataImageView.image = [UIImage imageNamed:@"icon_judge_detail"];
        [self.contentView addSubview:_noDataImageView];
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(31, 31));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(50);
        }];
        
        _noDataLabel = [KDSMallTool createLabelString:@"暂无商品评价~" textColorString:@"666666" font:15];
        [self.contentView addSubview:_noDataLabel];
        [_noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.noDataImageView.mas_bottom).mas_offset(25);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-50).priorityLow();
        }];
    }
    return self;
}

+(instancetype)nodataEvaluateWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSNodataEvaluateCellID";
    KDSNodataEvaluateCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
