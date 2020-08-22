//
//  KDSProductCategoryCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/30.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductCategoryCell.h"

@interface KDSProductCategoryCell ()
@property (nonatomic,strong)UILabel   * titleLB;
@end

@implementation KDSProductCategoryCell

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLB.text  = _titleStr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLB = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:18];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    return self;
}

+(instancetype)productCategoryCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductCategoryCellID";
    KDSProductCategoryCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}



@end
