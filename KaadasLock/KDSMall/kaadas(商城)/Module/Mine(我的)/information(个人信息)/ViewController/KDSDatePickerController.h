//
//  KDSDatePickerController.h
//  kaadas
//
//  Created by hjy on 2018/7/13.
//  Copyright © 2018年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WSDatePickerBlock)(NSString * dateString);
@interface KDSDatePickerController : UIViewController
@property (nonatomic,copy)WSDatePickerBlock    datePickerBlock;
-(void)show;
@end
