//
//  QZPWDTextfildview.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/14.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QZPWDTextfildview : UIView
//密码默认隐藏
@property (nonatomic,assign)BOOL  openPassword;
//输入做大的个数
@property (nonatomic,assign)NSInteger  maxCharacters;
@property (nonatomic,copy)NSString * text;
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
