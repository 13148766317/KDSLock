//
//  KDSProductServiceButton.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductServiceButton.h"
static CGFloat imageWidth = 15;
@implementation KDSProductServiceButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat x = 0;
    CGFloat w = imageWidth;
    CGFloat h = w;
    CGFloat y = (contentRect.size.height - h ) /2.0;
    return  CGRectMake(x, y, w, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat x = imageWidth + 5;
    CGFloat w = contentRect.size.width - x - 10;
    CGFloat h = contentRect.size.height;
    CGFloat y = 0;
    return  CGRectMake(x, y, w, h);
}

@end
