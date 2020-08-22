//
//  KDSHomeMoreAlertCell.m
//  kaadas
//
//  Created by 中软云 on 2019/8/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeMoreAlertCell.h"

@interface KDSHomeMoreAlertCell ()
@property (nonatomic,strong)UIImageView   * iconView;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UIView        * dividing;
@end

@implementation KDSHomeMoreAlertCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(16, 18));
        }];
        
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"ffffff" font:9];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(11);
            make.centerY.mas_equalTo(self.iconView.mas_centerY);
        }];
        
        
        _dividing = [KDSMallTool createDividingLineWithColorstring:@"#989898"];
        [self.contentView addSubview:_dividing];
        [_dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
    }
    return self;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLb.text = _titleStr;
}
-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    _iconView.image = [UIImage imageNamed:_imageStr];
}

-(void)setLastCell:(BOOL)lastCell{
    _lastCell = lastCell;
    _dividing.hidden = _lastCell;
}

+(instancetype)homeMoreWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSHomeMoreAlertCellID";
    KDSHomeMoreAlertCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
