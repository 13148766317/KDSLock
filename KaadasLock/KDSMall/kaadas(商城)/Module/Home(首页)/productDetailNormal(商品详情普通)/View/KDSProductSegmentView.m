//
//  KDSProductSegmentView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductSegmentView.h"
static CGFloat linewidth = 2;
@interface KDSProductSegmentView ()
@property (nonatomic,strong)UIView   *  bottomScrollView;
//选中的button
@property (nonatomic,strong)UIButton        *  selectButton;
@property (nonatomic,strong)NSMutableArray  *  buttonArray;
//记录是否点击button 默认YES
@property (nonatomic,assign)BOOL               isClickButton;
@end

@implementation KDSProductSegmentView

-(void)layoutSubviews{
    CGFloat buttonWidth = (self.frame.size.width  - linewidth) / self.buttonArray.count;
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton * button = (UIButton *)self.buttonArray[i];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-2);
            make.left.mas_equalTo(0).mas_offset(i *(buttonWidth + linewidth));
            make.width.mas_equalTo(buttonWidth);
        }];
    }
    
    [_bottomScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.selectButton.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(4.0);
        make.width.mas_equalTo(28.0);
    }];
}

-(instancetype)initWithTitleArray:(NSArray *)titleArray{
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _hiddenBottomScrollView = NO;
        _buttonArray = [NSMutableArray array];
        
        for (int i = 0; i < titleArray.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [button addTarget:self action:@selector(segmentButonclick:) forControlEvents:UIControlEventAllEvents
             ];
            button.tag = i;
            [self addSubview:button];
           
            //设置第一个button为选中状态 并记录
            if (i == 0) {
                button.selected = YES;
                _selectButton = button;
            }
            //存储button
            [_buttonArray addObject:button];
        }
        
        //滑块控件
        _bottomScrollView = [[UIView alloc]init];
//        _bottomScrollView.layer.cornerRadius = 4.0 / 2.0;
//        _bottomScrollView.layer.masksToBounds = YES;
        _bottomScrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [self addSubview:_bottomScrollView];
        
        _isClickButton = YES;
    }
    return self;
}
-(void)setTextFont:(CGFloat)textFont{
    _textFont = textFont;
    for (UIButton * button in _buttonArray) {
        button.titleLabel.font = [UIFont systemFontOfSize:_textFont];
    }
}

#pragma mark - setter
-(void)setSelectIndexViewController:(NSInteger)selectIndexViewController{
    _selectIndexViewController = selectIndexViewController;
    if (_selectIndexViewController > _buttonArray.count) {
        return;
    }
    _isClickButton = NO;
    UIButton * selectButton = _buttonArray[_selectIndexViewController];
    [self segmentButonclick:selectButton];
    
}

-(void)setHiddenBottomScrollView:(BOOL)hiddenBottomScrollView{
    _hiddenBottomScrollView = hiddenBottomScrollView;
    _bottomScrollView.hidden = YES;
}

#pragma mark - 图文 视频点击事件
-(void)segmentButonclick:(UIButton *)button{
    //判断是否重复点击  是则返回
//    if (_selectButton == button) {
//        return;
//    }
    
    //取消之前button的选中状态
    _selectButton.selected = NO;
    //设置新button为选中状态
    button.selected = YES;
    //记录新选中的button
    _selectButton = button;
    //设置滑块的位置
    [_bottomScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(4.0);
        make.width.mas_equalTo(28.0);
    }];
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (_isClickButton) {
        NSInteger index = -1;
        switch (button.tag) {
            case 0:
                index = 0;
                break;
            case 1:
                index = 1;
                break;
            case 2:
                index = 2;
                break;
            default:
                break;
        }
        //调用回调
        if (self.segmentButton) {
            self.segmentButton(index);
        }
        
        if (self.segmentBtn) {
            self.segmentBtn(index, _isClickButton);
        }
        
    }
    
    _isClickButton = YES;
    
}


@end
