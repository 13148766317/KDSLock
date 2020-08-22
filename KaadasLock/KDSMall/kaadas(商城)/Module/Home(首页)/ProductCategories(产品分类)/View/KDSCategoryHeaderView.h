//
//  KDSCategoryHeaderView.h
//  kaadas
//
//  Created by 中软云 on 2019/6/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KDSProductCategoryHeaderViewDelegate <NSObject>

-(void)productCategiryButtonClick:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface KDSCategoryHeaderView : UIView
@property (nonatomic,strong)NSMutableArray   * categoryArray;
@property (nonatomic,weak)id <KDSProductCategoryHeaderViewDelegate> delegate;

//记录控制滚动的角标
@property (nonatomic,assign)NSInteger              selectIndexViewController;

@end

NS_ASSUME_NONNULL_END
