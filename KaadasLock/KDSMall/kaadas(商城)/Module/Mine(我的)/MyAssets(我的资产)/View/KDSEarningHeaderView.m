//
//  KDSEarningHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningHeaderView.h"

@interface KDSEarningHeaderView ()
//时间
@property (nonatomic,strong)UILabel   * timeLabel;
@end

@implementation KDSEarningHeaderView

-(void)setMonthModel:(KDSEarningMonthModel *)monthModel{
    _monthModel = monthModel;
    if ([KDSMallTool checkObjIsNull:_monthModel]) {
        return;
    }
    
    //时间
    _timeLabel.text = [KDSMallTool checkISNull:_monthModel.date];
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        //时间
        _timeLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(25);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];
        
        //结余
        UILabel * balanceLabel = [KDSMallTool createLabelString:@"结余" textColorString:@"#666666" font:15];
        [self.contentView addSubview:balanceLabel];
        [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_top);
            make.right.mas_equalTo(-15);
        }];
    }
    return self;
}

+(instancetype)earningHeaderWithTableView:(UITableView *)tableView{
    static NSString * headerViewID = @"KDSEarningHeaderViewID";
    KDSEarningHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    
    return headerView;
}


@end
