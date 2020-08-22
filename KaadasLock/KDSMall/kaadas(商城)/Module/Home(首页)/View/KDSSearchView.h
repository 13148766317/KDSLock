//
//  KDSSearchView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSHomeBadgeButton.h"

typedef NS_ENUM(NSInteger,KDSSearchButtonType) {
    KDSSearchButtonType_search,//搜索
    KDSSearchButtonType_more,   //更多
     KDSSearchButtonType_shopCart//购物车
};

@protocol KDSSearchViewDelegate <NSObject>
-(void)searchViewButtonClick:(KDSSearchButtonType)buttonType;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSSearchView : UIView
@property (nonatomic,weak)id <KDSSearchViewDelegate> delegate;
@property (nonatomic,assign)CGFloat     bgAlphaScale;
//更多
@property (nonatomic,strong)KDSHomeBadgeButton   * moreButton;
//购物车
@property (nonatomic,strong)KDSHomeBadgeButton   * shopCartButton;

@end

NS_ASSUME_NONNULL_END
