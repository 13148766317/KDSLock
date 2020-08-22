//
//  WxLoginController.h
//  kaadas
//
//  Created by Apple on 2019/6/18.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDataLoadController.h"
typedef void (^LoginBlock)(void);
@interface WxLoginController : BaseDataLoadController
@property(nonatomic ,copy)LoginBlock loginBlock;

@end

