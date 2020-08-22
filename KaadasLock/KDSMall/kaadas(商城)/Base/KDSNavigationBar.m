//
//  KDSNavigationBar.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSNavigationBar.h"
#import "KDSBackButton.h"

@interface KDSNavigationBar ()
//返回button
//@property (nonatomic,strong)KDSBackButton   * backButton;
@property (nonatomic,strong)UIButton   * backButton;
//中间标题
@property (nonatomic,strong)UILabel         * centerTitleLabel;
//分割线
@property (nonatomic,strong)UIView          * dividingView;
@end

@implementation KDSNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _hiddenBackButton = NO;
        _backImage = [UIImage imageNamed:@"icon_return"];
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        
        //返回button
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //省略号靠右侧
        _backButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        _backButton.backgroundColor = [UIColor redColor];
        [_backButton setImage:_backImage forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

        _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_backButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"333333"] forState:UIControlStateNormal];
        
        [self addSubview:_backButton];
//        _backButton.backgroundColor = [UIColor redColor];
        
        //中间标题title
        _centerTitleLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [self addSubview:_centerTitleLabel];
        [_centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(isIPHONE_X ? 20 : 10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        _dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:_dividingView];
        [_dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(dividinghHeight);
        }];

    }
    return self;
}


-(void)setRightItem:(UIControl *)rightItem{
    [_rightItem removeFromSuperview];
    _rightItem = rightItem;
    [self addSubview:_rightItem];
  
}

-(void)setTitleView:(UIView *)titleView{
    [_titleView removeFromSuperview];
    _titleView = titleView;
    [self addSubview:_titleView];
}

#pragma mark - 返回事件
-(void)backClick{
    [_tagrget performSelectorOnMainThread:_action withObject:nil waitUntilDone:YES];
}

-(void)setHiddenBackButton:(BOOL)hiddenBackButton{
    _hiddenBackButton = hiddenBackButton;
    _backButton.hidden = _hiddenBackButton;
    [self layoutIfNeeded];
}

-(void)setBackTitle:(NSString *)backTitle{
    _backTitle = backTitle;
    [_backButton setTitle:_backTitle forState:UIControlStateNormal];
    [self setNeedsLayout];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _centerTitleLabel.text = _title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _centerTitleLabel.textColor = titleColor;
}

-(void)layoutSubviews{
    if (_hiddenBackButton) {
        [_backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.bottom.mas_equalTo(-4);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else{
        NSString * buttonTitle = [_backButton titleForState:UIControlStateNormal];
        BOOL isHaveTitle = [KDSMallTool checkISNull:buttonTitle].length;
        
        CGFloat buttonW = 0;
        if (isHaveTitle) {
            buttonW = [KDSMallTool getStringWidth:buttonTitle font:18] + (_backImage ?  45 : 15);
            if (buttonW > KSCREENWIDTH - 70) {
                buttonW = KSCREENWIDTH - 70;
                _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            }
        }else{
            buttonW = 40;
        }
        
        [_backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.bottom.mas_equalTo(-4);
            make.size.mas_equalTo(CGSizeMake(buttonW, 35));
        }];
        
        
    }
    
    if (_rightItem) {
        CGRect itemRect = CGRectZero;
        if (CGRectEqualToRect(self.rightItem.bounds, CGRectZero)) {
            itemRect = CGRectMake(0, 0, 40, 35);
        }else{
            itemRect = _rightItem.bounds;
        }
        
        [_rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-4);
            make.size.mas_equalTo(CGSizeMake(itemRect.size.width, itemRect.size.height));
        }];
    }
    
    
    if (_titleView) {
        CGRect titleViewRect = CGRectZero;
        if (CGRectEqualToRect(self.titleView.bounds, CGRectZero)) {
            titleViewRect = CGRectMake(0, 0, 0, 0);
        }else{
            titleViewRect = _titleView.bounds;
        }
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
//            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-8);
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(isIPHONE_X ? 22 : 10);
            make.size.mas_equalTo(titleViewRect.size);
        }];
    }
    
}

- (void)setBackImageEdgeInsets:(UIEdgeInsets)backImageEdgeInsets{
    _backImageEdgeInsets = backImageEdgeInsets;
    _backButton.imageEdgeInsets = _backImageEdgeInsets;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _dividingView.backgroundColor = lineColor;
}


-(void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    if (_backImage) {
        [_backButton setImage:_backImage forState:UIControlStateNormal];
    }else{
        [_backButton setImage:nil forState:UIControlStateNormal];
    }
    [self layoutSubviews];
}

@end
