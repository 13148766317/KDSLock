//
//  KDSMyPostSegmentView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyPostSegmentView.h"
static CGFloat linewidth = 2;

@interface KDSMyPostSegmentView ()
@property (nonatomic,strong)UIView   *  bottomScrollView;
//选中的button
@property (nonatomic,strong)UIButton        *  selectButton;
@property (nonatomic,strong)NSMutableArray  *  buttonArray;
@end

@implementation KDSMyPostSegmentView

-(instancetype)initWithTitleArray:(NSArray *)titleArray{
    if (self = [super init]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _hiddenBottomScrollView = NO;
        _buttonArray = [NSMutableArray array];
        
        CGFloat buttonWidth = (KSCREENWIDTH  - linewidth) / titleArray.count;
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
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.left.mas_equalTo(0).mas_offset(i *(buttonWidth + linewidth));
                make.width.mas_equalTo(buttonWidth);
            }];
            
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
        _bottomScrollView.layer.cornerRadius = 4.0 / 2.0;
        _bottomScrollView.layer.masksToBounds = YES;
        _bottomScrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [self addSubview:_bottomScrollView];
        [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.selectButton.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-4);
            make.height.mas_equalTo(4.0);
            make.width.mas_equalTo(25.0);
        }];
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
    if (_selectButton == button) {
        return;
    }
    
    //取消之前button的选中状态
    _selectButton.selected = NO;
    //设置新button为选中状态
    button.selected = YES;
    //记录新选中的button
    _selectButton = button;
    //设置滑块的位置
    [_bottomScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-4);
        make.height.mas_equalTo(3.0);
        make.width.mas_equalTo(25.0);
    }];
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    NSInteger index = -1;
    switch (button.tag) {
        case 0:
            index = 0;
            break;
        case 1:
            index = 1;
            break;
        default:
            break;
    }
    //调用回调
    if (self.segmentButton) {
        self.segmentButton(index);
    }
    
    
}

//#pragma mark - 画分线
//- (void)drawRect:(CGRect)rect{
//    [[UIColor hx_colorWithHexRGBAString:@"#ECECEC"] set];
//
//    UIBezierPath * path = [UIBezierPath bezierPath];
//
//    CGFloat lineHeight = rect.size.height / 2;
//    [path moveToPoint:CGPointMake((rect.size.width - linewidth) / 2.0, (rect.size.height - lineHeight ) / 2.0)];
//    [path addLineToPoint:CGPointMake((rect.size.width - linewidth) / 2.0, (rect.size.height - lineHeight ) / 2.0 + lineHeight)];
//    [path stroke];
//
//}
@end
