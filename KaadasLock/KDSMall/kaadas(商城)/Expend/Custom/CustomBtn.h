//
//  CustomBtn.h
//  自定义按钮文字和图片的位置
//
//  Created by Apple on 2019/3/25.
//  Copyright © 2019年 zhangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomBtnTitleAndImageType) {
    ButtonImageOriginal,// 原始位置。图片在左
    ButtonImageLeft, // 图片在左
    ButtonImageRight, // 图片在右
    ButtonImageTop, // 图片在上
    ButtonImageBottom, // 图片在下
};
@interface CustomBtn : UIButton
- (instancetype)initWithBtnFrame:(CGRect)btnFrame btnType:(CustomBtnTitleAndImageType)btnType titleAndImageSpace:(CGFloat)btnSpace imageSizeWidth:(CGFloat)btnImageWidth imageSizeHeight:(CGFloat)btnImageHeight;

@property (nonatomic, assign) CustomBtnTitleAndImageType customBtnType;
@property (nonatomic, assign) CGFloat btnSpace;

@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;

@end
