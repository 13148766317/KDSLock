//
//  QZEmptyButton.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/4/4.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZEmptyButton.h"

@interface QZEmptyButton  ()
@property (nonatomic,strong)UIImageView * buttonImageView;
@end


@implementation QZEmptyButton

-(void)setHighlighted:(BOOL)highlighted{}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#9E9E9E" ] forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}




-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageH = self.frame.size.height / 3;
    CGFloat imageW = imageH;
    CGFloat imageX = (self.frame.size.width - imageW ) / 2.0;
    CGFloat iamgeY = self.frame.size.height / 2 - imageH;
    self.imageView.frame = CGRectMake(imageX, iamgeY, imageW, imageH);
    
    
    CGFloat titleX = 10;
    CGFloat titleY = self.frame.size.height / 2 + 10;
    CGFloat titleH = 25;
    CGFloat titleW = KSCREENWIDTH - 2 * titleX;
    self.titleLabel.frame = CGRectMake(titleX,titleY , titleW, titleH);
}


@end
