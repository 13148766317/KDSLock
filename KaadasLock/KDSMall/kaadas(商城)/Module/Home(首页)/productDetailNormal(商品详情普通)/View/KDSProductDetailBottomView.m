//
//  KDSProductDetailBottomView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailBottomView.h"

#import "KDSProductDetailButton.h"
static  CGFloat leftBgscale = 0.40;

@interface KDSProductDetailBottomView ()
//类型
@property (nonatomic,assign)KDSProductDetailBottomType     bottomType;
//左侧背景
@property (nonatomic,strong)UIView                  * leftBgView;
@property (nonatomic,strong)NSMutableArray          * buttonArray;

//右侧背景
@property (nonatomic,strong)UIView            * rightBgView;
//加入购物车
@property (nonatomic,strong)UIButton          * addCartButton;
//立即购买
@property (nonatomic,strong)UIButton          * buyButton;

//
//@property (nonatomic,strong)UIButton         * rightButton;
@end

@implementation KDSProductDetailBottomView

-(instancetype)initWithType:(KDSProductDetailBottomType)type{
    if (self = [super init]) {
        _buttonArray = [NSMutableArray array];
        
        _bottomType = type;
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        
        
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //左侧背景----------
        _leftBgView = [[UIView alloc]init];
        [self addSubview:_leftBgView];
        [_leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.mas_width).multipliedBy(leftBgscale);
            
        }];
        //左侧
        
        NSArray * titleArray = nil;
        NSArray * imageArray = nil;
        if (_bottomType == KDSProductDetail_noraml) {
            titleArray = @[@"客服",@"收藏",@"购物车"];
            imageArray = @[@"icon_custom_detail",@"icon_collect_detail",@"icon_cart_detail"];
        }else{
            titleArray = @[@"客服",@"购物车"];
            imageArray = @[@"icon_custom_detail",@"icon_cart_detail"];
        }
        
        
        
        for (int i = 0; i< titleArray.count; i++) {
            KDSProductDetailButton * button = [KDSProductDetailButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            if (i == 1 && _bottomType == KDSProductDetail_noraml) {
                [button setImage:[UIImage imageNamed:@"icon_collected_detail"] forState:UIControlStateSelected];
            }
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_leftBgView addSubview:button];
            [_buttonArray addObject:button];
           
        }
        
        //右侧背景-----------
        _rightBgView = [[UIView alloc]init];
        [self addSubview:_rightBgView];
        [_rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftBgView.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.top.bottom.mas_equalTo(self);
        }];
        
        //加入购物车
        CGFloat rightItemMargin = 10;
        CGFloat rightItemW  = (KSCREENWIDTH * (1-leftBgscale)- 2 * rightItemMargin) / 2;
        CGFloat rightItemH  = 39;
        _addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCartButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#56B3FF"];
        _addCartButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_rightBgView addSubview:_addCartButton];
        _addCartButton.hidden = YES;
        [_addCartButton addTarget:self action:@selector(addCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_addCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.rightBgView.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.rightBgView.mas_bottom).mas_offset(-5);
            make.left.mas_equalTo(rightItemMargin);
            make.width.mas_equalTo(rightItemW);
        }];
        
        //加入购物车左边圆角
        UIBezierPath * addCartMaskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rightItemW, rightItemH) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(rightItemW, rightItemH)];
        CAShapeLayer * addCartLayer = [[CAShapeLayer alloc]init];
        addCartLayer.frame = CGRectMake(0, 0, rightItemW, rightItemH);
        addCartLayer.path = addCartMaskPath.CGPath;
        _addCartButton.layer.mask = addCartLayer;
        
        
        //立即购买
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_rightBgView addSubview:_buyButton];
        _buyButton.hidden = YES;
        [_buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.rightBgView.mas_centerY);
            make.right.mas_equalTo(-rightItemMargin);
            make.size.mas_equalTo(CGSizeMake(rightItemW, rightItemH));
        }];
        
        //立即购买右边圆角
        UIBezierPath * buyMaskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rightItemW, rightItemH) byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(rightItemH, rightItemH)];
        CAShapeLayer * buyMaskLayer = [[CAShapeLayer alloc]init];
        buyMaskLayer.frame = CGRectMake(0, 0, rightItemW, rightItemH);
        buyMaskLayer.path = buyMaskPath.CGPath;
        _buyButton.layer.mask = buyMaskLayer;
        
        
        
        CGFloat rightButtonX = 25;
        CGFloat rightButtonH = 39;
        CGFloat rightButtonW = (KSCREENWIDTH * (1-leftBgscale) - 2 * rightButtonX);
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_rightBgView addSubview:_rightButton];
        _rightButton.layer.cornerRadius = rightButtonH / 2;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.hidden = YES;
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rightButtonX);
            make.centerY.mas_equalTo(self.rightBgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(rightButtonW, rightButtonH));
        }];
        
        switch (_bottomType) {
            case KDSProductDetail_noraml:{//普通
                _rightButton.hidden = YES;
                _addCartButton.hidden = NO;
                _buyButton.hidden = NO;
            }
                break;
            case KDSProductDetail_seckill:{//秒杀
                _rightButton.hidden = NO;
                _addCartButton.hidden = YES;
                _buyButton.hidden = YES;
                [_rightButton setTitle:@"立即购买" forState:UIControlStateNormal];
            }
                break;
            case KDSProductDetail_group:{//拼团
                _rightButton.hidden = NO;
                _addCartButton.hidden = YES;
                _buyButton.hidden = YES;
                [_rightButton setTitle:@"" forState:UIControlStateNormal];
            }
                break;
            case KDSProductDetail_crowdfunding:{//众筹
                _rightButton.hidden = NO;
                _addCartButton.hidden = YES;
                _buyButton.hidden = YES;
                [_rightButton setTitle:@"支持项目" forState:UIControlStateNormal];
            }
                break;
                
            case KDSProductDetail_bargain:{//砍价
                _rightButton.hidden = NO;
                _addCartButton.hidden = YES;
                _buyButton.hidden = YES;
                [_rightButton setTitle:@"发起砍价" forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
       
    }
    return self;
}

#pragma mark -
-(void)rightButtonClick{
    KDSProductBottomButtonType  buttonType = -1;
    switch (_bottomType) {
        case KDSProductDetail_group:{//拼团
            buttonType = KDSProductBottom_group;
        }
            break;
        case KDSProductDetail_crowdfunding:{//众筹
            buttonType = KDSProductBottom_crowdfunding;
        }
            break;
        case KDSProductDetail_seckill:{//秒杀
             buttonType = KDSProductBottom__seckill;
        }
            break;
        case KDSProductDetail_bargain:{//砍价
            buttonType = KDSProductBottom_bargain;
        }
            break;
        default:
            break;
    }
    if (buttonType < 0) {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(productDetailBottomViewViewType:buttonType:)]) {
        [_delegate productDetailBottomViewViewType:_bottomType buttonType:buttonType];
    }
    
}

#pragma mark - 加入购物车点击事件
-(void)addCartButtonClick{
    if ([_delegate respondsToSelector:@selector(productDetailBottomViewViewType:buttonType:)]) {
        [_delegate productDetailBottomViewViewType:_bottomType buttonType:KDSProductBottom_addCart];
    }
}
#pragma mark - 立即购买  点击事件
-(void)buyButtonClick{
    if ([_delegate respondsToSelector:@selector(productDetailBottomViewViewType:buttonType:)]) {
        [_delegate productDetailBottomViewViewType:_bottomType buttonType:KDSProductBottom_buy];
    }
}

-(void)setCollectState:(BOOL)collectState{
    _collectState = collectState;
    
    UIButton * collectButton = (UIButton *)_buttonArray[1];
    collectButton.selected = _collectState;
}

#pragma mark - 客服 收藏 购物车  点击事件
-(void)buttonClick:(KDSProductDetailButton *)button{
    KDSProductBottomButtonType  buttonType = -1;
    switch (button.tag) {
        case 0:{
            buttonType = KDSProductBottom_service;//客服
        }
            break;
        case 1:{
            if (_bottomType == KDSProductDetail_noraml) {
                buttonType = KDSProductBottom_collect;//收藏
                button.selected = !button.selected;
            }else{
                 buttonType = KDSProductBottom_shopCart;//购物车
            }
           
        }
            break;
        case 2:{
            buttonType = KDSProductBottom_shopCart;//购物车
            
        }
            break;
            
            
        default:
            break;
    }
    
    if (buttonType < 0) {
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(productDetailBottomViewViewType:buttonType:)]) {
        [_delegate productDetailBottomViewViewType:_bottomType buttonType:buttonType];
    }
    
}

-(void)layoutSubviews{
    
    CGFloat leftBgWidth = self.frame.size.width * leftBgscale;
    CGFloat buttonMargin  = 0;
    CGFloat buttonX = buttonMargin;
    CGFloat buttonY = 0;
    CGFloat buttonW = (leftBgWidth - buttonMargin * (_buttonArray.count + 1)) / _buttonArray.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int i = 0; i < _buttonArray.count; i++) {
        KDSProductDetailButton * button = (KDSProductDetailButton *)_buttonArray[i];
        button.frame = CGRectMake(buttonX + (i * (buttonW + buttonMargin)), buttonY, buttonW, buttonH);
    }
}


@end
