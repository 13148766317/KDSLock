//
//  KDSMyFootPrintBottomView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KDSMyFootPrintBottomViewEvent){
    KDSMyFootPrintBottomViewEvent_allSelect,//全选
    KDSMyFootPrintBottomViewEvent_delete    //删除
};

@protocol KDSMyFootPrintBottomViewDelegate <NSObject>

-(void)myfootPrintBottomViewEvent:(KDSMyFootPrintBottomViewEvent)type isAllSelect:(BOOL)isAllSelect;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSMyFootPrintBottomView : UIView
@property (nonatomic,assign)BOOL     allSelectButtonState;
@property (nonatomic,weak)id <KDSMyFootPrintBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
