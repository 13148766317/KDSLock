//
//  YCPopoverAnimator.h
//  YCTransitionAnimation
//
//  Created by 蔡亚超 on 2018/5/17.
//  Copyright © 2018年 WellsCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPopMacro.h"

@interface WPopAnimation : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property(nonatomic,assign)CGRect       presentedFrame;
+ (instancetype)popoverAnimatorWithStyle:(YCPopoverType )popoverType completeHandle:(YCCompleteHandle)completeHandle;

- (void)setCenterViewSize:(CGSize)size;
- (void)setBottomViewHeight:(CGFloat)height;

@end
