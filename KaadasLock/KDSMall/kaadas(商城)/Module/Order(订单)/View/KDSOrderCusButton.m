//
//  KDSOrderButton.m
//  kaadas
//
//  Created by 中软云 on 2019/7/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOrderCusButton.h"

CGFloat imageWidth = 7.0f;

@implementation KDSOrderCusButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = [KDSMallTool getStringWidth:[self titleForState:UIControlStateNormal] font:18];
    CGFloat titleH = 25.0f;
    CGFloat titleY = contentRect.size.height - titleH;
    
    
    CGFloat w = imageWidth;
    CGFloat h = imageWidth;
    CGFloat y = titleY + 10;
    CGFloat x = (contentRect.size.width - (titleW + imageWidth))/2 + titleW + 2;
    
    return CGRectMake(x, y, w, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = [KDSMallTool getStringWidth:[self titleForState:UIControlStateNormal] font:18];
    CGFloat titleX = (contentRect.size.width - (titleW + imageWidth))/2;
    CGFloat titleH = 25.0f;
    CGFloat titleY = (contentRect.size.height - titleH)/2;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
