//
//  BHPhotoView.h
//  王宝弘
//
//  Created by 宝弘 on 2019/6/19.
//  Copyright © 2019年 王宝弘. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHPhotoViewDelete <NSObject>

-(void)bhphotoViewDeleteClick:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BHPhotoView : UIImageView
@property(nonatomic,weak) id <BHPhotoViewDelete> delegate;
@end

NS_ASSUME_NONNULL_END
