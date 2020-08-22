//
//  KDSTextView.h
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSTextView : UITextView
//占位文字
@property (nonatomic,copy)NSString      *  placeholder;
//占位文字颜色
@property (nonatomic,strong)UIColor     *  placeholderCorlor;
//文字左间距 默认5
@property(nonatomic,assign)CGFloat         leftSpacing;

@end

NS_ASSUME_NONNULL_END
