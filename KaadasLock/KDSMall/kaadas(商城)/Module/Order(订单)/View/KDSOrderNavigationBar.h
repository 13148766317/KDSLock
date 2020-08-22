//
//  KDSOrderNavigationBar.h
//  kaadas
//
//  Created by 中软云 on 2019/7/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSOrderCusButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSOrderNavigationBar : UIView

@property (nonatomic,strong)UIButton   * backButton;

@property (nonatomic,strong)KDSOrderCusButton * orderButton;

@end

NS_ASSUME_NONNULL_END
