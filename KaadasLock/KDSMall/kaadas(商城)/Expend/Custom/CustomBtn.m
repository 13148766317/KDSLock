//
//  CustomBtn.m
//  自定义按钮文字和图片的位置
//
//  Created by Apple on 2019/3/25.
//  Copyright © 2019年 zhangbin. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

-(instancetype)initWithBtnFrame:(CGRect)btnFrame btnType:(CustomBtnTitleAndImageType)btnType titleAndImageSpace:(CGFloat)btnSpace imageSizeWidth:(CGFloat)btnImageWidth imageSizeHeight:(CGFloat)btnImageHeight{
    if (self = [super initWithFrame:btnFrame]) {
        self.customBtnType = btnType;
        self.btnSpace = btnSpace;
        self.imgWidth = btnImageWidth;
        self.imgHeight = btnImageHeight;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    CGFloat imageWith = self.imgWidth?self.imgWidth:self.imageView.frame.size.width;
    CGFloat imageHeight = self.imgHeight?self.imgHeight:self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    switch (self.customBtnType) {
        case ButtonImageOriginal: {// 原始位置
            
            // 如下三句代码，不影响原有按钮图片的X，Y值，也不单独操作CGSize。通过CGRect实现修改按钮图片的宽高。
            CGRect frame = self.imageView.frame;
            frame.size = CGSizeMake(self.imgWidth?self.imgWidth:imageWith, self.imgHeight?self.imgHeight:imageHeight);
            self.imageView.frame = frame;
        }
            break;
        case ButtonImageLeft: {// 图片在左
            
            imageEdgeInsets = UIEdgeInsetsMake(0, - self.btnSpace * 0.5, 0, self.btnSpace * 0.5);
            labelEdgeInsets = UIEdgeInsetsMake(0,  self.btnSpace * 0.5, 0, - self.btnSpace * 0.5);
            // 如下三句代码，不影响原有按钮图片的X，Y值，也不单独操作CGSize。通过CGRect实现修改按钮图片的宽高。
            CGRect frame = self.imageView.frame;
            frame.size = CGSizeMake(self.imgWidth?self.imgWidth:imageWith, self.imgHeight?self.imgHeight:imageHeight);
            self.imageView.frame = frame;
            
            
        }
            break;
        case ButtonImageRight: {// 图片在右
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+ self.btnSpace * 0.5, 0, -labelWidth- self.btnSpace * 0.5);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith- self.btnSpace * 0.5, 0, imageWith+ self.btnSpace * 0.5);
            // 如下三句代码，不影响原有按钮图片的X，Y值，也不单独操作CGSize。通过CGRect实现修改按钮图片的宽高。
            CGRect frame = self.imageView.frame;
            frame.size = CGSizeMake(self.imgWidth?self.imgWidth:imageWith, self.imgHeight?self.imgHeight:imageHeight);
            self.imageView.frame = frame;
        }
            break;
        case ButtonImageTop: {// 图片在上
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight- self.btnSpace * 0.5, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-self.btnSpace * 0.5, 0);
            
            
            
            // 如下三句代码，不影响原有按钮图片的X，Y值，也不单独操作CGSize。通过CGRect实现修改按钮图片的宽高。
            CGRect frame = self.imageView.frame;
            frame.size = CGSizeMake(self.imgWidth?self.imgWidth:imageWith, self.imgHeight?self.imgHeight:imageHeight);
            self.imageView.frame = frame;
            
        }
            break;
        case ButtonImageBottom: {// 图片在下
            
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.btnSpace * 0.5, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight- self.btnSpace * 0.5, -imageWith, 0, 0);
            // 如下三句代码，不影响原有按钮图片的X，Y值，也不单独操作CGSize。通过CGRect实现修改按钮图片的宽高。
            CGRect frame = self.imageView.frame;
            frame.size = CGSizeMake(self.imgWidth?self.imgWidth:imageWith, self.imgHeight?self.imgHeight:imageHeight);
            self.imageView.frame = frame;
            
        }
            break;
            
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
