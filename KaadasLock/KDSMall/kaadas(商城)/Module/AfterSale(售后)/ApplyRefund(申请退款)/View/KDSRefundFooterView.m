//
//  KDSRefundFooterView.m
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSRefundFooterView.h"
#import "KDSTextView.h"
#import "BHPhotoBrowser.h"

@interface KDSRefundFooterView ()<UITextViewDelegate,BHPhotoBrowserDelegate>
@property (nonatomic,strong)UIView           * bgView;
@property (nonatomic,strong)BHPhotoBrowser   * photoBrowser;
@property (nonatomic,strong)KDSTextView      * textView;
@end

@implementation KDSRefundFooterView

-(NSString *)text{
    return _textView.text;
}

-(void)photoBrowserImageArray:(NSArray *)imageArray{
    NSLog(@"imageArray: %@",imageArray);
    _imageArray = imageArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //b问题描述title
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        UILabel * titleLb = [KDSMallTool createLabelString:@"问题描述" textColorString:@"#333333" font:15];
        [self addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(29);
        }];
        
        //浅灰背景
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-15);
        }];
        
        CGFloat photoMargin = 20;
        CGFloat maxCol = 3;
        CGFloat photoWidth = 60.0f;//(KSCREENWIDTH - 20 - photoMargin * (maxCol - 1)) / maxCol;
        _photoBrowser = [[BHPhotoBrowser alloc]init];
        _photoBrowser.photosMaxCol = maxCol;
        _photoBrowser.photoMargin = photoMargin;
        _photoBrowser.photoWidth = photoWidth;
        _photoBrowser.photoHeight = photoWidth;
        _photoBrowser.delegate = self;
        _photoBrowser.imagesMaxCountWhenWillCompose = 3;
        _photoBrowser.addImage = [UIImage imageNamed:@"icon_camera_add"];
        [_bgView addSubview:_photoBrowser];
        [_photoBrowser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(photoWidth);
        }];
        
        //输入框
        _textView = [[KDSTextView alloc]init];
        _textView.placeholderCorlor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
//       _textView.placeholder = @"请输入正文,字数小于1000字";
        _textView.font = [UIFont systemFontOfSize:15];
        // _textView.leftSpacing = 10;
        _textView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _textView.delegate = self;
        _textView.placeholderCorlor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        [_bgView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.photoBrowser.mas_top).mas_offset(-10);
        }];
        
//        [_textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}


//- (void)textViewDidChange:(UITextView *)textView {
//    if (textView.text.length > 10) {
//        textView.text = [textView.text substringToIndex:10];
//    }
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"text"]) {
//
//    }
//}
@end
