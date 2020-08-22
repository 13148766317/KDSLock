//
//  ShareSheetView.m
//  FMActionSheet
//
//  Created by David on 2017/7/17.
//  Copyright © 2017年 Subo. All rights reserved.
//

#import "ShareSheetView.h"
#import "WXApi.h"

@interface ShareSheetView ()
@property (strong, nonatomic) UIView *clearView;
//@property (strong, nonatomic) UIView *btnView;

@end
@implementation ShareSheetView
#define  showH 122
- (instancetype)initWithTitle:(NSString *)title
                  rightTitles:(NSString *)titlee
{
    
    if (self = [super init]) {
        
        self.contentView =[[UIView alloc]initWithFrame:CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, showH)];
        self.contentView.backgroundColor =[UIColor whiteColor];
        
//        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(15, 15, KSCREENWIDTH, 20)];
//        lab.font =[UIFont systemFontOfSize:15];
//        lab.text = @"分享到";
//        lab.textColor =[UIColor hx_colorWithHexRGBAString:@"#525252"];
//        lab.textAlignment = NSTextAlignmentLeft;
//        [self.contentView addSubview:lab];
//
        
        UIButton *liftBut =[UIButton buttonWithType:UIButtonTypeCustom];
        liftBut.frame = CGRectMake(22*KwidthSacle,24, 50,50);
        [liftBut setTitle:@"微信好友" forState:UIControlStateNormal];
        [liftBut setTitleColor:[UIColor  clearColor]forState:UIControlStateNormal];
        [liftBut addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [liftBut setBackgroundImage:[UIImage imageNamed:@"icon_wechat_share"] forState:UIControlStateNormal];
        liftBut.adjustsImageWhenHighlighted= NO;
        [self.contentView addSubview:liftBut];
        liftBut.tag = 0;
        
        UILabel *labl =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(liftBut.frame) - 10,CGRectGetMaxY(liftBut.frame)+10, 70,15)];
        labl.font =[UIFont systemFontOfSize:14];
        labl.text = title;
        labl.textColor =[UIColor hx_colorWithHexRGBAString:@"#666666"];
        labl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:labl];
        
        
        
        
        UIButton *midBut =[UIButton buttonWithType:UIButtonTypeCustom];
        midBut.frame = CGRectMake(CGRectGetMaxX(liftBut.frame)+44,24, 50,50);
        [midBut setTitle:@"朋友圈" forState:UIControlStateNormal];
        [midBut setTitleColor:[UIColor  clearColor]forState:UIControlStateNormal];
        [midBut addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [midBut setBackgroundImage:[UIImage imageNamed:@"icon_friend_share"] forState:UIControlStateNormal];
        midBut.adjustsImageWhenHighlighted= NO;
        [self.contentView addSubview:midBut];
        midBut.tag = 1;
        
        UILabel *labr =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(midBut.frame)- 10,CGRectGetMaxY(midBut.frame)+10, 70,15)];
        labr.font =[UIFont systemFontOfSize:14];
        labr.text = titlee;
        labr.textColor =[UIColor hx_colorWithHexRGBAString:@"#666666"];
        labr.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:labr];
        


        _clearView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
        _clearView.backgroundColor =[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        [_clearView addSubview:self];
        
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_clearView];
        [window insertSubview:self.contentView aboveSubview:_clearView];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_clearView addGestureRecognizer:tap];
        
    }
    
    return self;

}


- (void)show{
    [UIView animateWithDuration: 0.3 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y -= frame.size.height;
        [self.contentView setFrame:frame];
    } completion:^(BOOL finished) {
    }];

    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_clearView setAlpha:0];
                         [_clearView setUserInteractionEnabled:NO];
                         
                         CGRect frame = self.contentView.frame;
                         frame.origin.y += frame.size.height;
                         [self.contentView setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         [self.contentView removeFromSuperview];
                         [_clearView removeFromSuperview];
                         [self removeFromSuperview];
                         self.contentView = nil;
                         _clearView = nil;
                         
                     }];
}

-(void)shareAction:(UIButton*)sender
{
    
    [self dismiss];
    if (self.btnBlock) {
        self.btnBlock(sender.tag);
    }
}


@end
