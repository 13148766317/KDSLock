//
//  KDSMyFootPrintBottomView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyFootPrintBottomView.h"

@interface KDSMyFootPrintBottomView ()
//全选button
@property (nonatomic,strong)UIButton   * allSelectButton;
//删除button
@property (nonatomic,strong)UIButton   * deleteButton;
@end

@implementation KDSMyFootPrintBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        
        //全选button
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateSelected];
        [_allSelectButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateSelected];
        [_allSelectButton setImage:[UIImage imageNamed:@"selectbox_nor"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"selectbox_select"] forState:UIControlStateSelected];
        _allSelectButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _allSelectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_allSelectButton addTarget:self action:@selector(allSelectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allSelectButton];
        [_allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
            make.width.mas_equalTo(70);
        }];
        
        
        //删除button
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_deleteButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ffffff"] forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        _deleteButton.layer.cornerRadius = 39 / 2;
        _deleteButton.layer.masksToBounds = YES;
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100, 39));
        }];
        
    }
    return self;
}

-(void)setAllSelectButtonState:(BOOL)allSelectButtonState{
    _allSelectButtonState = allSelectButtonState;
    _allSelectButton.selected = _allSelectButtonState;
}

#pragma mark - 全选点击事件
-(void)allSelectButtonClick{
    _allSelectButton.selected = !_allSelectButton.selected;
    if ([_delegate respondsToSelector:@selector(myfootPrintBottomViewEvent:isAllSelect:)]) {
        [_delegate myfootPrintBottomViewEvent:KDSMyFootPrintBottomViewEvent_allSelect isAllSelect:_allSelectButton.selected];
    }
}
#pragma mark - 删除点击事件
-(void)deleteButtonClick{
    if ([_delegate respondsToSelector:@selector(myfootPrintBottomViewEvent:isAllSelect:)]) {
        [_delegate myfootPrintBottomViewEvent:KDSMyFootPrintBottomViewEvent_delete isAllSelect:_allSelectButton.selected];
    }
}
@end
