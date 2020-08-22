//
//  KDSBackButton.m
//  kaadas
//
//  Created by 中软云 on 2019/6/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBackButton.h"

@interface KDSBackButton ()
@property (nonatomic,strong)UIButton      * backButton;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UIImage       * backImage;
@property (nonatomic,copy)NSString        * backTitle;
@end

@implementation KDSBackButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor  = [UIColor purpleColor];
        [self addSubview:_backButton];
        _titleLb = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:18];
        
        [self addSubview:_titleLb];
        
    }
    return self;
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    self.backImage = image;
}

-(void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    if (_backImage) {
        [_backButton setImage:_backImage forState:UIControlStateNormal];
    }
    [self layoutSubviews];
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    _backTitle = title;
    if (_backTitle) {
        _titleLb.text = _backTitle;
    }
    [self layoutSubviews];
}

-(void)setBackTitle:(NSString *)backTitle{
    _backTitle = backTitle;
    _titleLb.text = [KDSMallTool checkISNull:_backTitle];
    [self layoutSubviews];
}

//所有的事件都要交给父控件处理
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    [super hitTest:point withEvent:event];
    return self;
}

-(void)layoutSubviews{
    if (_backImage) {//如果有图片
        _backButton.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        _titleLb.frame = CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
    }else{//没有图片
        _titleLb.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
    }
    
    
}

@end
