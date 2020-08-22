//
//  BHPhotoBrowser.m
//  王宝弘
//
//  Created by 王宝弘 on 2019/6/17.
//  Copyright © 2019 王宝弘. All rights reserved.
//

#import "BHPhotoBrowser.h"
#import "BHPhotoView.h"
#import "KDSPhotoTool.h"
#import "CustomSheet.h"

@interface BHPhotoBrowser ()
<
BHPhotoViewDelete
>
//边界范围
@property (nonatomic,assign)UIEdgeInsets      edgeInsets;
//行之间的距离
@property (nonatomic,assign)CGFloat           minimumLineSpacing;
//列之间的距离
@property (nonatomic,assign)CGFloat           minimumInteritemSpacing;

@end


@implementation BHPhotoBrowser

@synthesize imageArray = _imageArray;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //初始化数据
        [self initData];
    }
    return self;
}

-(void)setPhotoWidth:(CGFloat)photoWidth{
    _photoWidth = photoWidth;
    self.imageArray = self.imageArray;
    
    [self layoutSubviews];
}

-(void)setPhotoHeight:(CGFloat)photoHeight{
    _photoHeight = photoHeight;
    self.imageArray = self.imageArray;
    [self layoutSubviews];
}

#pragma mark -  初始化默认数据
-(void)initData{

    _photosMaxCol = 3;
    _photoWidth   = 70;
    _photoHeight  = 70;
    _imagesMaxCountWhenWillCompose = 9;
    _photoMargin  = 5;
}

#pragma mark - 图片数组setter方法
-(void)setImageArray:(NSMutableArray *)imageArray{
    
    //图片大于规定的数据(取设置的张数)
    if (imageArray.count > self.imagesMaxCountWhenWillCompose) {
        NSRange range = NSMakeRange(0, self.imagesMaxCountWhenWillCompose);
        NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:range];
        imageArray = [NSMutableArray arrayWithArray:[imageArray objectsAtIndexes:set]];
    }
    
    _imageArray = imageArray;
    //移除添加button
    [self.addButton removeFromSuperview];
    NSInteger imageCount = imageArray.count;
    //移除子控件
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //创建控件
    while (_imageArray.count > self.subviews.count) {
        BHPhotoView * imageView = [[BHPhotoView alloc]init];
        imageView.delegate = self;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
    
    //设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        BHPhotoView * imageView = self.subviews[i];
        imageView.tag = i;
        if (i < imageCount) {
            imageView.hidden = NO;
            imageView.image = self.imageArray[i];
        }else{
            imageView.hidden = YES;
        }
    }
    //重新布局
    [self layoutSubviews];
    
    if ([_delegate respondsToSelector:@selector(photoBrowserImageArray:)]) {
        [_delegate photoBrowserImageArray:_imageArray];
    }
}

-(void)layoutSubviews{
    
    NSInteger maxCol = self.photosMaxCol;
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView * imageView = self.subviews[i];
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        imageView.frame = CGRectMake(col * (self.photoWidth + self.photoMargin),  row * (self.photoHeight + self.photoMargin), self.photoWidth, self.photoHeight);
    }
    
    if (self.imageArray.count < self.imagesMaxCountWhenWillCompose) {
        [self addSubview:self.addButton];
        self.addButton.frame = CGRectMake((self.imageArray.count % maxCol) * (self.photoWidth + self.photoMargin),(self.imageArray.count / maxCol) * (self.photoHeight + self.photoMargin), _photoWidth, _photoHeight);
//        if (self.imageArray.count == 0) { // 数组为空
//            self.bounds = self.addButton.bounds;
//        }
    }
}

#pragma mark -
-(void)bhphotoViewDeleteClick:(NSInteger)tag{
    [self.imageArray removeObjectAtIndex:tag];
    self.imageArray = self.imageArray;
}

#pragma mark - 懒加载  图片imageView
-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark -  懒加载 添加图片button
-(BHCustomButton *)addButton{
    if (_addButton == nil) {
        _addButton = [BHCustomButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"pic_add_contact"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(void)setAddImage:(UIImage *)addImage{
    _addImage = addImage;
    if (_addImage) {
        [self.addButton setImage:_addImage forState:UIControlStateNormal];
    }
    
}

-(void)addButtonClick{
    
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    __weak typeof(self)weakSelf = self;
    CustomSheet *sheetV = [[CustomSheet alloc]initWithHeadView:nil cellArray:@[@"相册",@"拍照"] cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
        switch (index) {
            case 0:{//相册
                [[KDSPhotoTool sharedInstance] photoPickerControllerSourceTypePhotoLibraryWithViewController:[KDSMallTool getCurrentViewController:weakSelf] maxImagesCount:weakSelf.imagesMaxCountWhenWillCompose didFinishPickingPhotosHandle:^(NSArray<UIImage *> * _Nonnull photos, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
                    
                    [weakSelf.imageArray  addObjectsFromArray:photos];
                    weakSelf.imageArray = weakSelf.imageArray;
                }];
            }
                break;
            case 1:{//拍照
                [[KDSPhotoTool sharedInstance] photoPickerControllerSourceTypeCameraWithViewController:[KDSMallTool getCurrentViewController:weakSelf] didFinishPickingMediaWithimage:^(UIImage * _Nonnull image) {
                    NSLog(@"相册%@",image);
                    [weakSelf.imageArray addObject:image];
                    weakSelf.imageArray = weakSelf.imageArray;
                }];
                
            }
                break;
            default:
                break;
        }
        
    } cancelBlock:^{
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
}


@end
