//
//  KDSOrderButton.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOrderButton.h"

@implementation KDSOrderButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat x = 0 ;
    CGFloat y = contentRect.size.height / 2 + 10;
    CGFloat w = contentRect.size.width;
    CGFloat h = 15;
    
    return CGRectMake(x, y, w, h);
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat w = 26;
    CGFloat h = w;
    CGFloat x = (contentRect.size.width - w ) /2.0;
    CGFloat y = contentRect.size.height / 2.0 - h;
    
     return CGRectMake(x, y, w, h);
}
@end
