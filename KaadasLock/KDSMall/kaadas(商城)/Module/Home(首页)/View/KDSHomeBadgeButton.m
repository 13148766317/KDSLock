//
//  KDSHomeBadgeButton.m
//  kaadas
//
//  Created by 中软云 on 2019/7/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeBadgeButton.h"

@interface KDSHomeBadgeButton ()
@property (nonatomic,strong)UILabel   * badgeLb;
@end

@implementation KDSHomeBadgeButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _badgeLb = [KDSMallTool createLabelString:@"" textColorString:@"ffffff" font:9];
        _badgeLb.textAlignment =NSTextAlignmentCenter;
        _badgeLb.alpha = 0.9;
        _badgeLb.hidden = YES;
        [_badgeLb sizeToFit];
        _badgeLb.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [self addSubview:_badgeLb];
        
    }
    return self;
}

-(void)setBadgeNumber:(NSInteger)badgeNumber{
    _badgeNumber = badgeNumber;
    if (_badgeNumber == 0) {
        _badgeLb.hidden = YES;
    }else{
        _badgeLb.hidden = NO;
        _badgeLb.text = [NSString stringWithFormat:@"%ld",_badgeNumber];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat badgeLbW = self.frame.size.width / 2.5;
    CGFloat badgeLbH = badgeLbW;
    CGFloat badgeLbX = self.frame.size.width - badgeLbW - 3;
    CGFloat badgeLbY = 3;
    self.badgeLb.frame = CGRectMake(badgeLbX, badgeLbY, badgeLbW, badgeLbH);
    self.badgeLb.layer.cornerRadius = badgeLbW/ 2;
    self.badgeLb.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#F7F7F7"].CGColor;
    self.badgeLb.layer.borderWidth = 1;
    self.badgeLb.layer.masksToBounds = YES;
    
}


@end
