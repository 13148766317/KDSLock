//
//  QZLoginTopView.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/13.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZLoginTopView.h"

@interface QZLoginTopView ()
@property (nonatomic,strong)UIImageView * logoImagevView;
@property (nonatomic,strong)UIImageView * circulararcImageView;
@end

@implementation QZLoginTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背景颜色
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,KSCREENWIDTH,KSCREENHEIGHT / 4);
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
////        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:106/255.0 blue:120/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:243/255.0 green:106/255.0 blue:95/255.0 alpha:1.0].CGColor];
//           gl.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
//        gl.locations = @[@(0.0),@(1.0f)];
//        [self.layer addSublayer:gl];

        
        //logo
        _logoImagevView = [[UIImageView alloc]init];
        _logoImagevView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImagevView.clipsToBounds = YES;
        _logoImagevView.image = [UIImage imageNamed:@"pic_login"];
        [self addSubview:_logoImagevView];
        
        [_logoImagevView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        //圆弧
//        _circulararcImageView = [[UIImageView alloc]init];
//        [self addSubview:_circulararcImageView];

    };
    return self;
}


-(void)layoutSubviews{
    
//    ////圆弧
//    UIImage * circluarImage = [UIImage imageNamed:@"上弧度"];
//    _circulararcImageView.image = circluarImage;
//    CGFloat x = -18;
//    CGFloat w = KSCREENWIDTH + 36;
//    CGFloat h = w * circluarImage.size.height / circluarImage.size.width;
//    CGFloat y = self.frame.size.height - h  + 23;
//    _circulararcImageView.frame =CGRectMake(x, y, w, h);
//    self.layer.masksToBounds = YES;
//
//    //logo
//    UIImage * logoImage = [UIImage imageNamed:@"pic_login"];
//    _logoImagevView.image = logoImage;
//    CGFloat logoHeight = self.frame.size.height - h - 60;
//    CGFloat logoWidth  = logoHeight * logoImage.size.width / logoImage.size.height;
//    [_logoImagevView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(logoWidth, logoHeight));
//        make.top.mas_equalTo(30 + 20);
//    }];
    
    
}


@end
