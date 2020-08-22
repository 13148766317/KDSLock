//
//  KDSPWDTextView.h
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSPWDTextView : UIView
@property (nonatomic,strong)UITextField   * textField;
@property (nonatomic,copy)NSString      * text;
-(instancetype)initWithTitle:(NSString *)title palceHolder:(NSString *)placeHolder;
@end

NS_ASSUME_NONNULL_END
