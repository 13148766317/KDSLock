//
//  KDSProductDetailBottomView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSProductDetailBottomViewDelegate <NSObject>

-(void)productDetailBottomViewViewType:(KDSProductDetailBottomType)viewType buttonType:(KDSProductBottomButtonType)buttonType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSProductDetailBottomView : UIView
//
@property (nonatomic,weak)id <KDSProductDetailBottomViewDelegate> delegate;
@property (nonatomic,strong)UIButton         * rightButton;
-(instancetype)initWithType:(KDSProductDetailBottomType)type;
@property (nonatomic,assign)BOOL       collectState;
@end

NS_ASSUME_NONNULL_END
