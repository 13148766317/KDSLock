//
//  KDSHomeBannerView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@protocol KDSHomeBannerViewDelegate <NSObject>
-(void)homeBannerViewSelectItemAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSHomeBannerView : UIView
@property (nonatomic,weak)id <KDSHomeBannerViewDelegate> delegate;
@property (nonatomic,strong)SDCycleScrollView * bannerView;
@property (nonatomic,strong)NSArray   * bannerArray;
@property (nonatomic,strong)NSArray   * imageUrlArray;
@end

NS_ASSUME_NONNULL_END
