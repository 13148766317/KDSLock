//
//  BHPhotoView.m
//  王宝弘
//
//  Created by 宝弘 on 2019/6/19.
//  Copyright © 2019年 王宝弘. All rights reserved.
//

#import "BHPhotoView.h"
#import "BHCustomButton.h"
@interface BHPhotoView ()
@property(nonatomic,strong)BHCustomButton * deleteButton;

@end
//icon_del_pic
@implementation BHPhotoView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _deleteButton = [BHCustomButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"deleteimage"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_deleteButton];
    }
    return self;
}

-(void)deleteButtonClick{
    if ([_delegate respondsToSelector:@selector(bhphotoViewDeleteClick:)]) {
        [_delegate bhphotoViewDeleteClick:_deleteButton.tag];
    }
}

-(void)setTag:(NSInteger)tag{
    [super setTag:tag];
    _deleteButton.tag =tag;
}

-(void)layoutSubviews{
    CGFloat deleteW = 30;
    CGFloat deleteH = deleteW;
    CGFloat deleteX = self.frame.size.width - deleteW;
    CGFloat deleteY = 0;
    _deleteButton.frame = CGRectMake(deleteX, deleteY, deleteW, deleteH);
}

@end
