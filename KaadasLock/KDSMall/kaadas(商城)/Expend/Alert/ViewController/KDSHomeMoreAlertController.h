//
//  KDSHomeMoreAlertController.h
//  kaadas
//
//  Created by 中软云 on 2019/8/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeMoreClickBlock) (NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeMoreAlertController : UIViewController
+(instancetype)homeMoreShowView:(UIView *)view homeMoreClickBlock:(HomeMoreClickBlock)homeMoreClickBlock;
@end

NS_ASSUME_NONNULL_END
