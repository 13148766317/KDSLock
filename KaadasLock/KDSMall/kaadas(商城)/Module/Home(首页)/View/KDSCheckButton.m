//
//  KDSCheckButton.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCheckButton.h"

@implementation KDSCheckButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor hx_colorWithHexRGBAString:@"333333"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleH = 15;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = (contentRect.size.height - titleH) /2;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = 13;
    CGFloat imageH = imageW;
    CGFloat imageY = (contentRect.size.height - imageH) / 2.0;
    CGFloat imageX = contentRect.size.width - imageW;
    
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
