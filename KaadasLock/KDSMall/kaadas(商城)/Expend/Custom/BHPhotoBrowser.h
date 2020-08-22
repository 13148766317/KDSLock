//
//  BHPhotoBrowser.h
//  王宝弘
//
//  Created by 王宝弘 on 2019/6/17.
//  Copyright © 2019 王宝弘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHCustomButton.h"

@protocol BHPhotoBrowserDelegate <NSObject>

-(void)photoBrowserImageArray:(NSArray *_Nullable)imageArray;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BHPhotoBrowser : UIView
@property (nonatomic,weak)id <BHPhotoBrowserDelegate> delegate;
//每行最多显示多少个
@property (nonatomic,assign)CGFloat              photosMaxCol;
//默认的宽度
@property (nonatomic,assign)CGFloat               photoWidth;
//默认的高度
@property (nonatomic,assign)CGFloat               photoHeight;
@property (nonatomic,strong)UIImage             * addImage;
@property (nonatomic,strong)NSMutableArray      * imageArray;
@property (nonatomic,strong)BHCustomButton      * addButton;
/** 当图片上传前，最多上传的张数，默认为9 */
@property (nonatomic, assign) NSInteger imagesMaxCountWhenWillCompose;
//图片之间的j间隔   默认间隔5
@property (nonatomic,assign)CGFloat     photoMargin;
@end

NS_ASSUME_NONNULL_END
