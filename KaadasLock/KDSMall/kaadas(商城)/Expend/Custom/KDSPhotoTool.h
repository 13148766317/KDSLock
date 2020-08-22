//
//  QZPhotoTool.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/28.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinishPickingPhotosHandle)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto);
typedef void(^FinishPickingMediaWithimage)(UIImage * image);

@interface KDSPhotoTool : NSObject

+(instancetype)sharedInstance;
#pragma mark 系统相册
-(void)photoPickerControllerSourceTypePhotoLibraryWithViewController:(UIViewController *)VC  maxImagesCount:(NSInteger)maxImagesCount didFinishPickingPhotosHandle:(FinishPickingPhotosHandle)didFinishPickingPhotosHandle;
#pragma mark 拍照
-(void)photoPickerControllerSourceTypeCameraWithViewController:(UIViewController *)VC  didFinishPickingMediaWithimage:(FinishPickingMediaWithimage)didFinishPickingMediaWithimage;

@end

NS_ASSUME_NONNULL_END
