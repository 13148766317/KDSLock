//
//  QZButton.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZButton.h"

@implementation QZButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.layer.cornerRadius = 5.0f;
//        self.layer.masksToBounds = YES;
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,KSCREENWIDTH,50);
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:106/255.0 blue:120/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:243/255.0 green:106/255.0 blue:95/255.0 alpha:1.0].CGColor];
//        gl.locations = @[@(0.0),@(1.0f)];
//        [self.layer addSublayer:gl];
        
        
//        self.layer.cornerRadius = 5.0f;
//        self.layer.masksToBounds = YES;
//        CAGradientLayer * gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0, 0, KSCREENWIDTH, 50);
//        gl.startPoint = CGPointMake(0.0, 0.5);
//        gl.endPoint = CGPointMake(0.5,0.5);
//        gl.colors =  @[(__bridge id)[UIColor hx_colorWithHexRGBAString:@"#333333"].CGColor,(__bridge id)[UIColor hx_colorWithHexRGBAString:@"#333333"].CGColor];
//        gl.locations = @[@(0.5),@(1.0)];
//        [self.layer addSublayer:gl];
        
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
    }
    return self;
}

@end
