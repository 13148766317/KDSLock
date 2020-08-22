//
//  QZRightArrowButton.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZRightArrowButton.h"

//图片的宽度
static const CGFloat imageWidth = 7.0f;
//图片和文字的间隔
static const CGFloat margin     = 5.0f;
//文字
static  NSString * text    = @"已有账号，去登录";

@implementation QZRightArrowButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#CA2128"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon_rightarrow_login"] forState:UIControlStateNormal];
        self.titleLabel.font =[UIFont systemFontOfSize:15];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    13 X 25
    CGFloat w = imageWidth;
    CGFloat h = w * 25 / 13;
    CGFloat x = contentRect.size.width - w - margin;
    CGFloat y = (contentRect.size.height - h ) / 2;
    return CGRectMake(x, y, w, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat w = [KDSMallTool getStringWidth:text font:15];
    CGFloat h = 20.0f;
    CGFloat y = (contentRect.size.height - h )/ 2;
    CGFloat x = contentRect.size.width - imageWidth - 2 * margin - w -5;
    return CGRectMake(x, y, w, h);
}

@end
