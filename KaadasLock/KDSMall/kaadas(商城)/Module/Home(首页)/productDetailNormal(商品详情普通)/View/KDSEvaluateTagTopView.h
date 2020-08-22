//
//  KDSEvaluateTagTopView.h
//  kaadas
//
//  Created by 中软云 on 2019/7/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KDSEvaluateTagTopViewDelegate <NSObject>
-(void)evaluateTagHeaderViewButtonClick:(NSInteger)buttonTag;
@end

@interface KDSEvaluateTagTopView : UIView
@property (nonatomic,weak)id <KDSEvaluateTagTopViewDelegate> delegate;
@property (nonatomic,strong)NSArray         * titleArray;
@property (nonatomic,assign)NSInteger         selectIndex;
@end

NS_ASSUME_NONNULL_END
