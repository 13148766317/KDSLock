//
//  BSOrderStatusView.m
//  BuyAndSend
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import "TopBarView.h"
@interface TopBarView()
@property (nonatomic, strong)NSMutableArray *buttonArray;
/// 横线
@property (nonatomic, strong) UIView *lineView;
/// 当前索引
@property (nonatomic, assign) NSInteger currentIndex;

@end
@implementation TopBarView
#pragma mark - private function
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor{
    //按钮创建
    NSInteger count = titleArray.count;
    CGFloat buttonX =0; //btn起始位置
//    CGFloat btnW = 75; //btn宽
//    CGFloat btnMargin = (self.frame.size.width - buttonX*2- btnW *count)/(count-1);   //btn间距
    CGFloat btnMargin =  5;//
    CGFloat btnW = (KSCREENWIDTH - 2 * 5 - (titleArray.count - 1) * btnMargin ) / titleArray.count ; //btn宽
    
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button .frame =CGRectMake(buttonX + i*btnW +i*btnMargin, 0, btnW, self.frame.size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:normalColor forState:UIControlStateNormal];
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
        button.tag = i;
        
        [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        if (i == 0) {
            button.selected = YES;
        }
    }
    self.currentIndex = 0;
    if (lineColor) {    //线条
        self.lineView.frame = CGRectMake(buttonX, self.frame.size.height-2,btnW, 2);
        self.lineView.backgroundColor = lineColor;
    }
}
/// 创建button
- (UIButton *)createButtonByIndex:(NSInteger)index
                normalColor:(UIColor *)normalColor
              selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag = index;
    [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
    /// 第一个默认选中
    if (index == 0) {
        button.selected = YES;
    }
    return button;
}

//状态切换
- (void)buttonTouchEvent:(UIButton *)button{
    if (button.tag == self.currentIndex) {
        return;
    }
    //代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(statusViewSelectIndex:)]) {
        [self.delegate statusViewSelectIndex:button.tag];
    }
//    if (!_isScroll) {
        [self changeTag:button.tag];
//    }
}
-(void)changeTag:(NSInteger)tag
{
    // 选择当前的状态
    self.currentIndex = tag;
    UIButton *button  = self.buttonArray[tag];
    button.selected   = YES;
    // 关闭上一个选择状态
    for (int i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex) {
            
            UIButton *button = self.buttonArray[i];
            button.selected = NO;
        }
    }
    // 移动横线到对应的状态
    if (self.lineView) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.lineView.frame;
//            float origin = self.frame.size.width / self.buttonArray.count*tag;
//            frame.origin.x      = origin;
            frame.origin.x = button.frame.origin.x;
            self.lineView.frame = frame;
        }];
    }
}
#pragma mark - 懒加载
- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

//下面滑动的横线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return _lineView;
}

@end
