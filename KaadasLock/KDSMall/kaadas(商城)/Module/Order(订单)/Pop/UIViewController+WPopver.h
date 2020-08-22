//
//  UIViewController+WPopver.h
//  Demo
//
//  Created by 王皇保 on 2019/6/18.
//  Copyright © 2019 WellsCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPopMacro.h"
#import "WPopAnimation.h"


@interface UIViewController (WPopver)
@property(nonatomic,strong)WPopAnimation        *popoverAnimator;

- (void)yc_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(YCCompleteHandle)completion;

- (void)yc_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(YCCompleteHandle)completion;


@end

