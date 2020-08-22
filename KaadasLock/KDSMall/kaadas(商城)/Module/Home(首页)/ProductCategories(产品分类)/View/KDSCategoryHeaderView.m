//
//  KDSCategoryHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/6/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCategoryHeaderView.h"
#import "KDSCategoryChildModel.h"

@interface KDSCategoryHeaderView ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView         * bottonLineView;
@property (nonatomic,strong)UIButton       * selectButton;
@property (nonatomic,strong)NSMutableArray   * buttonArray;
@end

@implementation KDSCategoryHeaderView

-(void)setCategoryArray:(NSMutableArray *)categoryArray{
    _categoryArray = categoryArray;
    
    NSMutableArray * titleArray = [NSMutableArray array];
    
    for (int i = 0; i < _categoryArray.count; i++) {
        KDSCategoryChildModel * model = _categoryArray[i];
        [titleArray addObject:model.name];
    }
    
    [self addButton:titleArray];
}

-(void)addButton:(NSArray *)array{
    
    CGFloat scrollContentW = 0;
    
    for (int i = 0; i < array.count; i++) {
        
        CGFloat buttonH = 43;
        CGFloat buttonW = [KDSMallTool getStringWidth:array[i] font:15] + 20;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"333333"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(scrollContentW, 0, buttonW, buttonH);
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        scrollContentW += buttonW;
        [_scrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _selectButton = button;
//            _bottonLineView.frame = CGRectMake(0, CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 2);
            CGFloat width = 20;
            CGFloat height = 2;
            CGFloat x = (CGRectGetWidth(button.frame) - width ) / 2;
            CGFloat y = CGRectGetMaxY(button.frame);
            _bottonLineView.frame = CGRectMake(x, y,  width, height);
        }
        [self.buttonArray addObject:button];
    }
    _scrollView.contentSize = CGSizeMake(scrollContentW, 45);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(KSCREENWIDTH , 0);
        _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(self.mas_bottom).priorityLow();
        }];
        
        _bottonLineView = [KDSMallTool createDividingLineWithColorstring:@"#ca2128"];
        [_scrollView addSubview:_bottonLineView];
    }
    return self;
}

#pragma mark - setter
-(void)setSelectIndexViewController:(NSInteger)selectIndexViewController{
    _selectIndexViewController = selectIndexViewController;
    
    if (_selectIndexViewController > _buttonArray.count) {
        return;
    }
    
    UIButton * selectButton = _buttonArray[_selectIndexViewController];
    [self buttonClick:selectButton];
    
}
-(void)buttonClick:(UIButton *)button{
    
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    NSLog(@"selected: %d",button.selected);
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat width = 20;
        CGFloat height = 2;
        CGFloat x = CGRectGetMinX(button.frame) + (CGRectGetWidth(button.frame) - 20) / 2;
        CGFloat y = CGRectGetMaxY(button.frame);
        _bottonLineView.frame = CGRectMake(x, y,  width, height);
    } completion:^(BOOL finished) {
        
    }];

    if ([_delegate respondsToSelector:@selector(productCategiryButtonClick:)]) {
        [_delegate productCategiryButtonClick:button.tag];
    }

    CGRect buttonRect      =  button.frame;
    CGSize scrollViewSize  =  _scrollView.contentSize;
    if ((buttonRect.origin.x + buttonRect.size.width / 2 > KSCREENWIDTH / 2) && (buttonRect.origin.x + buttonRect.size.width / 2 + KSCREENWIDTH / 2 > scrollViewSize.width)) {
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

-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
