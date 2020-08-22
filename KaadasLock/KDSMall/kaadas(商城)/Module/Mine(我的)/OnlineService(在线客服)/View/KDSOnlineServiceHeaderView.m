//
//  KDSOnlineServiceHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/7/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOnlineServiceHeaderView.h"

@interface KDSOnlineServiceHeaderView ()
@property (nonatomic,strong)UIImageView   * leftImageView;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UILabel       * desLb;
@property (nonatomic,strong)UIButton      * rightButton;
@property (nonatomic,strong)UIButton      * arrowButton;
@end

@implementation KDSOnlineServiceHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _leftImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftImageView];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-20);
        }];
        
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(21);
            make.top.mas_equalTo(self.leftImageView.mas_top);
        }];
        
        _desLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_desLb];
        [_desLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.bottom.mas_equalTo(self.leftImageView.mas_bottom);
        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.layer.cornerRadius = 15;
        _rightButton.layer.masksToBounds = YES;
        [_rightButton addTarget:self action:@selector(callButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightButton setTitle:@"拨打" forState:UIControlStateNormal];
        _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        
        [self.contentView addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        //箭头
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowButton setImage:[UIImage imageNamed:@"icon_spread_down"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"icon_spread_up"] forState:UIControlStateSelected];
        [_arrowButton addTarget:self action:@selector(arrowButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_arrowButton];
        [_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
    }
    return self;
}

#pragma mark - 打电话
-(void)callButtonClick{
    if ([_delegate respondsToSelector:@selector(onlineServiceHeaderViewButtonType:section:buttonSelect:)]) {
        [_delegate onlineServiceHeaderViewButtonType:KDSOnlineServiceCall section:_section buttonSelect:_rightButton.selected];
    }
}

#pragma mark - 下箭头
-(void)arrowButtonClick{
    _arrowButton.selected = !_arrowButton.selected;
   
    if ([_delegate respondsToSelector:@selector(onlineServiceHeaderViewButtonType:section:buttonSelect:)]) {
        [_delegate onlineServiceHeaderViewButtonType:KDSOnlineServiceQRCode section:_section buttonSelect:_arrowButton.selected];
    }

}

-(void)setArrowSelect:(BOOL)arrowSelect{
    _arrowSelect = arrowSelect;
    _arrowButton.selected = _arrowSelect;
    if (_arrowButton.selected) {
        _desLb.text = @"长按保存图片";
    }
    
}
-(void)setSection:(NSInteger)section{
    _section = section;
    if (_section == 0) {
        _rightButton.hidden = NO;
        _arrowButton.hidden = YES;
        [_rightButton setTitle:@"拨打" forState:UIControlStateNormal];
    }else if(_section == 3){
        _rightButton.hidden = YES;
        _arrowButton.hidden = NO;
    }else{
        _rightButton.hidden = NO;
        _arrowButton.hidden = YES;
        [_rightButton setTitle:@"复制" forState:UIControlStateNormal];
    }
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    _leftImageView.image = [UIImage imageNamed:[KDSMallTool checkISNull:_dict[@"image"]]];
    _titleLb.text = [KDSMallTool checkISNull:dict[@"title"]];
    _desLb.text = [KDSMallTool checkISNull:dict[@"des"]];
}


+(instancetype)onlineSericeHeaderWithTableView:(UITableView *)tableView{
    static NSString * headerViewID = @"KDSOnlineServiceHeaderViewID";
    KDSOnlineServiceHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

@end
