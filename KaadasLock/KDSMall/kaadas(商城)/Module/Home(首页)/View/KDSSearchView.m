//
//  KDSSearchView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSearchView.h"

@interface KDSSearchView ()
@property (nonatomic,strong)UIButton      * bgButton;
@property (nonatomic,strong)UIImageView   * searchImageView;
@property (nonatomic,strong)UILabel       * placeholderLabel;

@property (nonatomic,strong)UIView        * bgView;
//底部分割线
@property (nonatomic,strong)UIView   * dividing;
@end

@implementation KDSSearchView

-(void)setBgAlphaScale:(CGFloat)bgAlphaScale{
    _bgAlphaScale = bgAlphaScale;
    
    if (_bgAlphaScale > 0.6) {
        _bgButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#e6e6e6"];
//        _moreButton.selected = YES;
        _dividing.hidden = NO;
    }else{
        _bgButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
//        _moreButton.selected = NO;
        _dividing.hidden = YES;
    }
    
    _bgView.alpha = _bgAlphaScale;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _bgView.alpha = 0.0f;
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        //更多
        _moreButton = [KDSHomeBadgeButton buttonWithType: UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"更多_黑"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(newsMsgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-5);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(self.moreButton.mas_height);
        }];
        
        //购物车
        _shopCartButton = [KDSHomeBadgeButton buttonWithType: UIButtonTypeCustom];
        [_shopCartButton addTarget:self action:@selector(shopCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_shopCartButton setImage:[UIImage imageNamed:@"购物车_黑"] forState:UIControlStateNormal];
        [self addSubview:_shopCartButton];
        [_shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.moreButton.mas_left).mas_offset(-8);
            make.size.mas_equalTo(self.moreButton);
            make.centerY.mas_equalTo(self.moreButton.mas_centerY);
        }];
        
        
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        [_bgButton addTarget:self action:@selector(bgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.alpha = 0.8;
        [self addSubview:_bgButton];
        [_bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.shopCartButton.mas_left).mas_offset(-15);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-5);
        }];
        
        //搜索图片
        _searchImageView = [[UIImageView alloc]init];
        _searchImageView.image = [UIImage imageNamed:@"icon_home_search"];
        [self addSubview:_searchImageView];
        [_searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgButton.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.bgButton.mas_centerY);
            make.height.mas_equalTo(self.bgButton.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.searchImageView.mas_height);
        }];

        //
        _placeholderLabel = [KDSMallTool createLabelString:@"搜索产品" textColorString:@"#999999" font:15];
        [self addSubview:_placeholderLabel];
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.searchImageView.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(self.searchImageView.mas_centerY);
        }];
//
//        //提醒
//        _newsMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_newsMsgButton addTarget:self action:@selector(newsMsgButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [_newsMsgButton setImage:[UIImage imageNamed:@"icon_home_news"] forState:UIControlStateNormal];
//        [_newsMsgButton setImage:[UIImage imageNamed:@"icon_home_news_black"] forState:UIControlStateSelected];
//        [self addSubview:_newsMsgButton];
//        [_newsMsgButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.bgButton.mas_right).mas_offset(8);
//            make.centerY.mas_equalTo(self.bgButton.mas_centerY);
//            make.size.mas_equalTo(CGSizeMake(35, 35));
//        }];
//
        _dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        _dividing.hidden = YES;
        [self addSubview:_dividing];
        [_dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
    }
    return self;
}
#pragma mark - 搜索点击事件
-(void)bgButtonClick{
    if ([_delegate respondsToSelector:@selector(searchViewButtonClick:)]) {
        [_delegate searchViewButtonClick:KDSSearchButtonType_search];
    }
}

#pragma mark - 更多点击事件
-(void)newsMsgButtonClick{
    if ([_delegate respondsToSelector:@selector(searchViewButtonClick:)]) {
        [_delegate searchViewButtonClick:KDSSearchButtonType_more];
    }
}

-(void)shopCartButtonClick{
    if ([_delegate respondsToSelector:@selector(searchViewButtonClick:)]) {
        [_delegate searchViewButtonClick:KDSSearchButtonType_shopCart];
    }
}

@end
