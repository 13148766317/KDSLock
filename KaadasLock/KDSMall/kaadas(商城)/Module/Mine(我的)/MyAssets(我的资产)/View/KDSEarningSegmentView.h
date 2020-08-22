//
//  KDSEarningSegmentView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSEarningSegmentViewDelegate <NSObject>

-(void)earningSegmentButtonClick:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface KDSEarningSegmentView : UIView
@property (nonatomic,weak)id <KDSEarningSegmentViewDelegate> delegate;
-(instancetype)initWithTitleArray:(NSArray *)titleArray;
@end

NS_ASSUME_NONNULL_END
