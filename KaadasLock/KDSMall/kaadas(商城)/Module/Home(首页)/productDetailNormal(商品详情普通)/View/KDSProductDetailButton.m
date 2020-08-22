//
//  KDSProductDetailButton.m
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailButton.h"
//static CGFloat imageH  = 30;

@interface KDSProductDetailButton ()
@property (nonatomic,strong)UILabel   * badgeLabel;
@end

@implementation KDSProductDetailButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel = [KDSMallTool createLabelString:@"99" textColorString:@"#ffffff" font:8];
        _badgeLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
        _badgeLabel.userInteractionEnabled = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.hidden = YES;
        [self addSubview:_badgeLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rect = self.frame;
    CGFloat badgeW = 15;
    CGFloat badgeH = badgeW;
    CGFloat badgeX = rect.size.width / 2 ;;
    CGFloat badgeY = 2;
  
    _badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    _badgeLabel.layer.cornerRadius = badgeW /2;
    _badgeLabel.layer.masksToBounds = YES;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat x = 0;
    CGFloat y = contentRect.size.height * 0.6;
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.3;
    
    return  CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w = contentRect.size.height * 0.38;
    CGFloat h = w;
    CGFloat x = (contentRect.size.width - w) / 2;
    CGFloat y = contentRect.size.height * 0.6 - h - 2;
    

    return  CGRectMake(x, y, w, h);
}

@end
