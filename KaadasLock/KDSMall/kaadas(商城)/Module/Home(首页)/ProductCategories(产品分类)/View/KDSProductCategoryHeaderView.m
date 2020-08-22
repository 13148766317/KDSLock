//
//  KDSProductCategoryHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductCategoryHeaderView.h"
#import "KDSCategoryChildModel.h"
@interface KDSProductCategoryHeaderView ()
//@property (nonatomic,strong)JXLayoutButton   * button;
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView    * bottonLineView;
@property (nonatomic,strong)UIButton   * selectButton;
@end

@implementation KDSProductCategoryHeaderView


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
            _bottonLineView.frame = CGRectMake(0, CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 2);
        }
    }
    
    _scrollView.contentSize = CGSizeMake(scrollContentW, 45);

}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    
    UIButton * button = [_scrollView viewWithTag:selectIndex];
    [UIView animateWithDuration:0.25 animations:^{
        _bottonLineView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 2);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)buttonClick:(UIButton *)button{
    
    button.selected = YES;
    _selectButton.selected = NO;
    _selectButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        _bottonLineView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 2);
    } completion:^(BOOL finished) {
        
    }];
    
//    NSLog(@"%@",button);
    if ([_delegate respondsToSelector:@selector(productCategiryButtonClick:)]) {
        [_delegate productCategiryButtonClick:button.tag];
    }
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(KSCREENWIDTH , 0);
        _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    
        _bottonLineView = [KDSMallTool createDividingLineWithColorstring:@"#ca2128"];
        [_scrollView addSubview:_bottonLineView];
        
//        JXLayoutButton * button = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
//        button.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
//        button.midSpacing = 8;
//        [button setTitle:@"全部" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:21];
//        [button setImage:[UIImage imageNamed:@"icon_spread_product_list"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:button];
//        _button = button;
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.left.mas_equalTo(15);
//            make.size.mas_equalTo(CGSizeMake(80, 35));
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5).priorityLow();
//        }];
    
        
    }
    return self;
}




+(instancetype)productCategoryHeaderViewWithTableView:(UITableView *)tableView{
    static NSString * headerViewID = @"KDSProductCategoryHeaderViewID";
    KDSProductCategoryHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

//-(void)buttonClick:(JXLayoutButton *)button{
//    if ([_delegate respondsToSelector:@selector(productCategiryButtonClick:)]) {
//        [_delegate productCategiryButtonClick:button];
//    }
//
//    [self setNeedsLayout];
//}
//-(void)layoutSubviews{
//    NSString *  buttonTitle = [_button titleForState:UIControlStateNormal];
//
//    CGFloat buttonTitleWidth = [KDSMallTool getStringWidth:buttonTitle font:21];
//
//    [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(buttonTitleWidth + 25, 35));
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5).priorityLow();
//    }];
//}
@end
