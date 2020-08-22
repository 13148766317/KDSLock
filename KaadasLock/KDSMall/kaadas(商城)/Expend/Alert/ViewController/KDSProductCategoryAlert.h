//
//  KDSProductCategoryController.h
//  kaadas
//
//  Created by 中软云 on 2019/5/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^KDSProductBlock)(NSInteger index);
@interface KDSProductCategoryAlert : UIViewController
+(instancetype)productCategoryShowDataArray:(NSArray *)dataArray Rect:(CGRect)rect  button:(UIButton *)button productBlock:(KDSProductBlock)productBlock;
@end

NS_ASSUME_NONNULL_END
