//
//  QZInvitationTextFieldView.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/23.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//分割线的位置
typedef NS_ENUM(NSInteger,QZDividingLinePosition){
    QZDividingLine_NO, //无分割线
    QZDividingLine_TOP ,//上
    QZDividingLine_BOTTOM ,//下
    QZDividingLine_ALL    //上 、下
};


@interface QZInvitationTextFieldView : UIView
@property (nonatomic,strong)UITextField      * textField;
@property (nonatomic,copy)NSString           * text;
//是否可编辑输入文本
@property (nonatomic,assign)BOOL               edit;
//文本颜色
@property (nonatomic,copy)NSString           * textColor;
//文本大小
@property (nonatomic,assign)CGFloat           font;
//title颜色
@property (nonatomic,copy)NSString          * titleColor;

-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder linePositon:(QZDividingLinePosition)position;
@end

NS_ASSUME_NONNULL_END
