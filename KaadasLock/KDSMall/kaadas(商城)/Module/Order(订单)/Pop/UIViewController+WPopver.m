//
//  UIViewController+WPopver.m
//  Demo
//
//  Created by 王皇保 on 2019/6/18.
//  Copyright © 2019 WellsCai. All rights reserved.
//

#import "UIViewController+WPopver.h"
#import <objc/runtime.h>
static const char popoverAnimatorKey;

@implementation UIViewController (WPopver)

- (WPopAnimation *)popoverAnimator{
    return objc_getAssociatedObject(self, &popoverAnimatorKey);
}
- (void)setPopoverAnimator:(WPopAnimation *)popoverAnimator{
    objc_setAssociatedObject(self, &popoverAnimatorKey, popoverAnimator, OBJC_ASSOCIATION_RETAIN) ;
}


- (void)yc_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(YCCompleteHandle)completion{
    self.popoverAnimator = [WPopAnimation popoverAnimatorWithStyle:YCPopoverTypeActionSheet completeHandle:completion];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    [self.popoverAnimator setBottomViewHeight:height];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)yc_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(YCCompleteHandle)completion{
    self.popoverAnimator = [WPopAnimation popoverAnimatorWithStyle:YCPopoverTypeAlert completeHandle:completion];
    [self.popoverAnimator setCenterViewSize:size];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
