//
//  KDSMyQRCodeDetailView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/15.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyQRCodeDetailView.h"
#import "CustomSheet.h"

@interface KDSMyQRCodeDetailView  ()
@property (nonatomic,strong)UIView       * bgView;
//头像
@property (nonatomic,strong)UIImageView   * iconImageView;
//昵称
@property (nonatomic,strong)UILabel       * nickLabel;
//长按图片保存到相册label
@property (nonatomic,strong)UILabel       * longPressSaveLabel;
@end

@implementation KDSMyQRCodeDetailView

-(void)bgViewLongPress:(UILongPressGestureRecognizer*)gesture{
   
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
         NSLog(@"截图");
        __weak typeof(self)weakSelf = self;
        CustomSheet *sheetV = [[CustomSheet alloc]initWithHeadView:nil cellArray:@[@"保存图片"] cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
            UIImage * image =  [self snapshot:weakSelf.bgView];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
        } cancelBlock:^{
            
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
    }
  
    
}
- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSString*message =@"成功保存到相册";
    if(error) {
        message = [error description];
    }
//    [KDSProgressHUD showSuccess:message toView:self.view completion:^{
//    }];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
        //长按图片保存到相册label
        _longPressSaveLabel = [KDSMallTool createLabelString:@"长按图片保存到相册" textColorString:@"#333333" font:15];
        _longPressSaveLabel.textAlignment = NSTextAlignmentCenter;
        _longPressSaveLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [self addSubview:_longPressSaveLabel];
        [_longPressSaveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self addSubview:_bgView];
        //添加长按手势
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewLongPress:)];
        longPress.minimumPressDuration = 0.8;
        longPress.numberOfTouchesRequired = 1;
        [_bgView addGestureRecognizer:longPress];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.longPressSaveLabel.mas_top).mas_offset(-5);
        }];
        
        //头像
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
//        _iconImageView.image = [UIImage imageNamed:@"pic_head_list"];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.logo] placeholderImage:[UIImage imageNamed:@"pic_head_list"]];
        [_bgView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_centerX).mas_offset(-40);
            make.top.mas_equalTo(21);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        //昵称
        _nickLabel = [KDSMallTool createLabelString:[KDSMallTool checkISNull:userModel.userName] textColorString:@"#333333" font:15];
        [_bgView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        }];
        
        //二维码
        _QRCodeImageView = [[UIImageView alloc]init];
//        _QRCodeImageView.image = [UIImage imageNamed:@"icon_qrcode_mine"];
        [_QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:userModel.qrImgUrl]] placeholderImage:[UIImage imageNamed:@"icon_qrcode_mine"]];
        _QRCodeImageView.userInteractionEnabled = YES;
        [_bgView addSubview:_QRCodeImageView];
        [_QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(56);
            make.right.mas_equalTo(-56);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(self.QRCodeImageView.mas_width);
        }];
  
    }
    return self;
}

@end
