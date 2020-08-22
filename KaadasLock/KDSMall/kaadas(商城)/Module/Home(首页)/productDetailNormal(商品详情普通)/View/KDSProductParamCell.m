//
//  KDSProductParamCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductParamCell.h"

@interface KDSProductParamCell ()
@property (nonatomic,strong)UILabel   * titleLb;
@property (nonatomic,strong)UILabel   * detailLb;
@end

@implementation KDSProductParamCell
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    _titleLb.attributedText = [KDSMallTool attributedString:_dict[@"name"] lineSpacing:8];
    
    _detailLb.attributedText = [KDSMallTool attributedString:_dict[@"value"] lineSpacing:8];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _detailLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        _detailLb.numberOfLines = 0;
        [self.contentView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(120);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-40);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];
        
//        _detailLb.backgroundColor = [UIColor redColor];
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        _titleLb.numberOfLines = 0;
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(80);
            make.centerY.mas_equalTo(self.detailLb.mas_centerY);
        }];
      
//        _titleLb.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

+(instancetype)productParamCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductParamCellID";
    KDSProductParamCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
