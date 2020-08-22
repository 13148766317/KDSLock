//
//  KDSProductEvaluteBottomView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KDSProductBottomViewDelegate <NSObject>

-(void)productEvaluateBottemViewButtonClick:(KDSProductEvaluateButtonType)type;
@end
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductEvaluteBottomView : UIView
@property(nonatomic,weak) id <KDSProductBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
