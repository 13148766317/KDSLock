//
//  KDSOnlineServiceQCodeCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOnlineServiceQCodeCell.h"
#import "CustomSheet.h"

@interface KDSOnlineServiceQCodeCell ()

@property (nonatomic,strong)UIImageView   * QRCodeImageView;
@end

@implementation KDSOnlineServiceQCodeCell
-(void)bgViewLongPress:(UILongPressGestureRecognizer*)gesture{
    
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
        NSLog(@"截图");
        __weak typeof(self)weakSelf = self;
        CustomSheet *sheetV = [[CustomSheet alloc]initWithHeadView:nil cellArray:@[@"保存图片"] cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
            UIImage * image =  [self snapshot:weakSelf.QRCodeImageView];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
        } cancelBlock:^{
            
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _QRCodeImageView = [[UIImageView alloc]init];
        _QRCodeImageView.userInteractionEnabled = YES;
        //添加长按手势
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewLongPress:)];
        longPress.minimumPressDuration = 0.8;
        longPress.numberOfTouchesRequired = 1;
        [_QRCodeImageView addGestureRecognizer:longPress];
        [self.contentView addSubview:_QRCodeImageView];
        [_QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(160, 160));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        UILabel * desLb= [KDSMallTool createLabelString:@"扫一扫上面的二维码图案，添加客服微信" textColorString:@"#999999" font:12];
        desLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:desLb];
        [desLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.QRCodeImageView.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
    }
    return self;
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
        [KDSProgressHUD showSuccess:message toView:nil completion:^{
        }];
}
-(void)setQrCode:(NSString *)qrCode{
    _qrCode = qrCode;
    [_QRCodeImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:[KDSMallTool checkISNull:_qrCode]]] placeholderImage:[UIImage imageNamed:@""]];
}

+(instancetype)onlineServiceQCodeCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSOnlineServiceQCodeCellID";
    KDSOnlineServiceQCodeCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
