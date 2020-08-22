//
//  QZPhotoTool.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/28.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSPhotoTool.h"

@interface KDSPhotoTool ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIViewController           * viewController;
@property (nonatomic,copy) FinishPickingMediaWithimage   finshPickingMediawithImage;

@end

static KDSPhotoTool * _sharedInstance = nil;

@implementation KDSPhotoTool

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[KDSPhotoTool alloc]init];
    });
    return _sharedInstance;
}

#pragma mark -系统相册
-(void)photoPickerControllerSourceTypePhotoLibraryWithViewController:(UIViewController *)VC  maxImagesCount:(NSInteger)maxImagesCount didFinishPickingPhotosHandle:(FinishPickingPhotosHandle)didFinishPickingPhotosHandle{
    _viewController = VC;
    TZImagePickerController * imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:maxImagesCount delegate:nil];
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowTakePicture  = NO;
    imagePickerVC.statusBarStyle =  UIStatusBarStyleDefault;
    imagePickerVC.naviBgColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
    imagePickerVC.naviTitleColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    imagePickerVC.barItemTextColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    if (maxImagesCount == 1) {
        imagePickerVC.showSelectBtn = NO;
        imagePickerVC.allowCrop = YES;
        imagePickerVC.cropRect = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width)/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    }
    imagePickerVC.naviTitleFont = [UIFont systemFontOfSize:18];
    
    imagePickerVC.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
    };
    [_viewController presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - 拍照
-(void)photoPickerControllerSourceTypeCameraWithViewController:(UIViewController *)VC  didFinishPickingMediaWithimage:(FinishPickingMediaWithimage)didFinishPickingMediaWithimage{
    _viewController = VC;
    _finshPickingMediawithImage = didFinishPickingMediaWithimage;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [KDSProgressHUD showFailure:@"该设备不支持拍照" toView:_viewController.view completion:^{}];
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.allowsEditing = YES;
    [imagePickerController view];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [_viewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        image =  [self imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width / 7, image.size.height/7)];
    }
    _finshPickingMediawithImage(image);
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 裁剪图片
-(UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
#pragma mark 保存图片调用方法
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error == nil) {
        NSLog(@"图片保存成功");
    }else{
        NSLog(@"图片保存失败");
    }
    
}

@end
