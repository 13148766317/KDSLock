//
//  KDSEvaluateTagHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/6/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEvaluateTagHeaderView.h"

@interface KDSEvaluateTagHeaderView ()
@property (nonatomic,strong)UIScrollView     * scrollView;
@property (nonatomic,strong)NSMutableArray   * buttonArray;
@property (nonatomic,strong)UIButton         * selectButton;
@end

@implementation KDSEvaluateTagHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _selectIndex = 0;
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delaysContentTouches = false;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(KSCREENWIDTH , 0);
        _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(70);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    //移除数组中的子控件
    [self.buttonArray removeAllObjects];
    //移除之前控件
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    //重新创建控件
    for (int i = 0; i < titleArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitle:_titleArray[i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#FFFFFF"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.userInteractionEnabled = YES;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        switch (i) {
            case 0:{
                button.selected = YES;
                _selectButton = button;
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
            }
                break;
            case 1:
            case 2:{
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F6EDE3"];
            }
                break;
                
            case 3:{
                button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F0F0F0"];
            }
                break;
            default:
                break;
        }
        [_scrollView addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    [self layoutSubviews];
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    if (_selectIndex >= self.buttonArray.count) {
        return;
    }
    
    UIButton * button = self.buttonArray[_selectIndex];
    [self buttonClick:button];
}

#pragma mark - button点击事件
-(void)buttonClick:(UIButton *)button{
    
    
    button.selected = YES;
    button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    if (_selectButton.tag == 3) {
         _selectButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F0F0F0"];
    }else{
         _selectButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F6EDE3"];
    }
    _selectButton.selected = NO;
    _selectButton = button;
    _selectButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    //调用代理
    if ([_delegate respondsToSelector:@selector(evaluateTagHeaderViewButtonClick:)]) {
        [_delegate evaluateTagHeaderViewButtonClick:button.tag];
    }
    
    if (_scrollView.contentSize.width < KSCREENWIDTH) {
        return;
    }
    CGRect buttonRect      =  button.frame;
    CGSize scrollViewSize  =  _scrollView.contentSize;
    if ((buttonRect.origin.x + buttonRect.size.width / 2 > KSCREENWIDTH / 2)) {
        if (buttonRect.origin.x + buttonRect.size.width / 2 + KSCREENWIDTH / 2 > scrollViewSize.width) {
            [_scrollView setContentOffset:CGPointMake(scrollViewSize.width - KSCREENWIDTH, 0) animated:YES];
        }else{
            [_scrollView setContentOffset:CGPointMake(buttonRect.origin.x + buttonRect.size.width / 2 - KSCREENWIDTH / 2, 0) animated:YES];
        }
    }
    else{
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
#pragma mark -  重新布局
-(void)layoutSubviews{
    
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(KSCREENWIDTH, self.frame.size.height);
    //记录scrollview的滚动范围
    CGFloat scrollContentW = 0;
    //button的高度
    CGFloat buttonH = 33;
    
    CGFloat buttonY = (self.frame.size.height - buttonH) / 2;
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton * button = (UIButton *)self.buttonArray[i];
        //        button.backgroundColor = [UIColor purpleColor];
        //根据文字计算button的宽度
        CGFloat buttonW = [KDSMallTool getStringWidth:_titleArray[i] font:15] + 20;
        button.frame = CGRectMake(scrollContentW + 15 , buttonY, buttonW, buttonH);
        scrollContentW += buttonW + 15;
    }
    _scrollView.contentSize = CGSizeMake(scrollContentW + 5, self.frame.size.height);
    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * returnView =   [super hitTest:point withEvent:event];
    
    //判断下点在不在窗口上
    if ([self pointInside:point withEvent:event]) {
        int count = (int)_scrollView.subviews.count;
        
        for (int i = count - 1; i >= 0; i--) {
            //获取子控件
            UIView * childView = _scrollView.subviews[i];
            CGPoint childPoint = [self convertPoint:point toView:childView];
            UIView * fitView = [childView hitTest:childPoint withEvent:event];
            //如果点在子控件上 返回该子控件
            if (fitView) {
                return fitView;
            }
        }
        
        return _scrollView;
    }
    
    return returnView;
}

#pragma mark - 懒加载
-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

+(instancetype)evaluateTagHeaderViewWithTableView:(UITableView *)tableView {
    static NSString * headerViewID = @"KDSEvaluateTagHeaderViewID";
    
    KDSEvaluateTagHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

@end
