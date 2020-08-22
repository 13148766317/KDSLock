//
//  UIViewController+ImagePicker.h
//  Rent3.0
//
//  Created by Apple on 2019/3/6.
//  Copyright © 2019年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImagePickerCompletionHandler)(NSData *imageData, UIImage *image);

@interface UIViewController (ImagePicker)
- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;
- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)imageSize CompletionHandler:(ImagePickerCompletionHandler)completionHandler;

@end
