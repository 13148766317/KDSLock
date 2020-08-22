//
//  QZAccountTextFieldView.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/13.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+Length.h"
NS_ASSUME_NONNULL_BEGIN

@interface QZAccountTextFieldView : UIView
//输入做大的个数
@property (nonatomic,assign)NSInteger  maxCharacters;
//获取输入的内容
@property (nonatomic,copy)NSString * text;
//键盘类型
@property (nonatomic,assign)UIKeyboardType     keyBoardType;
@property (nonatomic,strong)UITextField      * textField;
//成为第一响应者
-(void)responder;
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
