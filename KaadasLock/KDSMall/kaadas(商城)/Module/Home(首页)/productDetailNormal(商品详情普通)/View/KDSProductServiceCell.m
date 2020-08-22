//
//  KDSProductServiceCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductServiceCell.h"
#import "KDSProductServiceButton.h"

@interface KDSProductServiceCell ()
@property (nonatomic,strong)UILabel   * titleLB;
@end

@implementation KDSProductServiceCell
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLB.text = _titleString;
}
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
        
        CGFloat buttonx = 60;
        CGFloat buttonW = (KSCREENWIDTH - buttonx - 30)  / 3;
        NSArray * buttonTitleArray = @[@"预约安装",@"三年质量",@"品质认证"];
        for (int i = 0; i < buttonTitleArray.count; i++) {
            KDSProductServiceButton * button = [KDSProductServiceButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"icon_service_detail"] forState:UIControlStateNormal];
            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.userInteractionEnabled = YES;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [self.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLB.mas_right).mas_offset(15 + i * buttonW);
                make.height.mas_equalTo(35);
                make.centerY.mas_equalTo(self.contentView.mas_centerY);
                make.width.mas_equalTo(buttonW);
            }];
        }
        
    }
    return self;
}

-(void)buttonClick:(KDSProductServiceButton *)button{
    if([_delegate respondsToSelector:@selector(productServiceCellButtonClick:)]){
        [_delegate productServiceCellButtonClick:button.tag];
    }
}

+(instancetype)productServiceCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductServiceCellID";
    KDSProductServiceCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
