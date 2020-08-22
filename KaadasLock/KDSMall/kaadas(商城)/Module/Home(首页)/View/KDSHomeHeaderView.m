//
//  KDSHomeHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeHeaderView.h"

@interface KDSHomeHeaderView ()
@property (nonatomic,strong)UIButton   * bgButton;
//标题
@property (nonatomic,strong)UILabel   * titleLB;
//右箭头
@property (nonatomic,strong)UIImageView   * arrowImageView;
@end

@implementation KDSHomeHeaderView


-(void)bgButtonClick{
    
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgButton addTarget:self action:@selector(bgButtonEventClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bgButton];
        [_bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
      
        //标题
        _titleLB = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:21];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(41);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-20).priorityMedium();
        }];
        
        //右箭头
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"moreForMall"];
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.titleLB.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
       
    }
    return self;
}


#pragma mark - 背景点击事件
-(void)bgButtonEventClick{
    if ([_delegate respondsToSelector:@selector(homeHeaderViewBGClick:)]) {
        [_delegate homeHeaderViewBGClick:_section];
    }
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    //标题
    _titleLB.text = _titleString;
}

+(instancetype)homeHeaderViewWithTableView:(UITableView *)tableView{
    
        static NSString * headerViewID = @"KDSHomeHeaderViewID";
        KDSHomeHeaderView  * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
        if (headerView == nil) {
            headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
        }
        return headerView;
}

@end
