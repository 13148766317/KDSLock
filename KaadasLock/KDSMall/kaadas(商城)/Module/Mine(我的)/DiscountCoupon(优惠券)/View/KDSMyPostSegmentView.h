//
//  KDSMyPostSegmentView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^KDSMyPostSegmentButton)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface KDSMyPostSegmentView : UIView
-(instancetype)initWithTitleArray:(NSArray *)titleArray;
//记录控制滚动的角标
@property (nonatomic,assign)NSInteger              selectIndexViewController;
//button点击回调
@property (nonatomic,copy)KDSMyPostSegmentButton  segmentButton;
//隐藏滑块
@property (nonatomic,assign)BOOL                   hiddenBottomScrollView;
//文字大小
@property (nonatomic,assign)CGFloat                textFont;
@end

NS_ASSUME_NONNULL_END
