//
//  KDSProductSegmentView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^KDSProductSegmentButton)(NSInteger index);
typedef void (^KDSProductSegmentBtn)(NSInteger index ,BOOL isClickButton);
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductSegmentView : UIView
-(instancetype)initWithTitleArray:(NSArray *)titleArray;
//记录控制滚动的角标
@property (nonatomic,assign)NSInteger              selectIndexViewController;
//button点击回调
@property (nonatomic,copy)KDSProductSegmentButton  segmentButton;
@property (nonatomic,copy)KDSProductSegmentBtn     segmentBtn;
//隐藏滑块
@property (nonatomic,assign)BOOL                   hiddenBottomScrollView;
//文字大小
@property (nonatomic,assign)CGFloat                textFont;
@end

NS_ASSUME_NONNULL_END
