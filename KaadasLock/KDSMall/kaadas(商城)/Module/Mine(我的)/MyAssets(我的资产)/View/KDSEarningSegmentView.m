//
//  KDSEarningSegmentView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningSegmentView.h"

static CGFloat linewidth = 2;

@interface KDSEarningSegmentView ()

@property (nonatomic,strong)UIView          *  bottomScrollView;
//选中的button
@property (nonatomic,strong)UIButton        *  selectButton;
@property (nonatomic,strong)NSMutableArray  *  buttonArray;

@end

@implementation KDSEarningSegmentView

-(instancetype)initWithTitleArray:(NSArray *)titleArray{
    if (self = [super init]) {
        _buttonArray = [NSMutableArray array];
        
        CGFloat buttonMargin= 10.0f;
        CGFloat buttonWidth = (KSCREENWIDTH - (titleArray.count + 1) * buttonMargin) / titleArray.count;
        
        for (int i = 0; i < 4; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitle:titleArray[i] forState:UIControlStateSelected];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).mas_offset(buttonMargin + i * (buttonMargin + buttonWidth));
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(buttonWidth);
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
            }];
            
            //设置第一个button为选中状态 并记录
            if (i == 0) {
                button.selected = YES;
                _selectButton = button;
                _selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            //存储button
            [_buttonArray addObject:button];
        }
        
        //滑块控件
        _bottomScrollView = [[UIView alloc]init];
        _bottomScrollView.layer.cornerRadius = 6.0 / 2.0;
        _bottomScrollView.layer.masksToBounds = YES;
        _bottomScrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F36A5F"];
        [self addSubview:_bottomScrollView];
        [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.selectButton.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-3);
            make.height.mas_equalTo(6.0);
            make.width.mas_equalTo(25.0);
        }];
    }
    return self;
}

-(void)buttonClick:(UIButton *)button{
    //判断是否重复点击  是则返回
//    if (_selectButton == button) {
//        return;
//    }
    
    //取消之前button的选中状态
    _selectButton.selected = NO;
    _selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    //设置新button为选中状态
    button.selected = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //记录新选中的button
    _selectButton = button;
    //设置滑块的位置
    [_bottomScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-3);
        make.height.mas_equalTo(6.0);
        make.width.mas_equalTo(25.0);
    }];
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    
    if ([_delegate respondsToSelector:@selector(earningSegmentButtonClick:)]) {
        [_delegate earningSegmentButtonClick:button.tag];
    }
    
}

@end
