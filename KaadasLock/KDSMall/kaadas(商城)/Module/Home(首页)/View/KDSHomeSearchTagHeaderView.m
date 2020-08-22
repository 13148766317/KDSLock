//
//  KDSHomeSearchTagHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeSearchTagHeaderView.h"

@interface KDSHomeSearchTagHeaderView ()
@property (nonatomic,strong)NSMutableArray  *  tagButtonArray;
@property (nonatomic,assign)UIEdgeInsets       edginInsets;
//每行之间的间距
@property (nonatomic,assign)CGFloat            columnMargin;
//每列之间的间距
@property (nonatomic,assign)CGFloat            rowMargin;
//tag的高度
@property (nonatomic,assign)CGFloat            tagHeight;
//最后创建的taglabel
@property (nonatomic,strong)UIButton         *  lastTagButton;
@property (nonatomic,strong)UILabel          *  hotSearchLabel;
@end

@implementation KDSHomeSearchTagHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化默认值
        _edginInsets  = UIEdgeInsetsMake(20, 15, 5, 5);
        _columnMargin = 10;
        _rowMargin    = 10;
        _tagHeight    = 30;
        
        //热搜标签
        _hotSearchLabel = [KDSMallTool createLabelString:@"热门搜索" textColorString:@"#999999" font:18];
        [self addSubview:_hotSearchLabel];
        _hotSearchLabel.frame = CGRectMake(15, 40, 100, 30);
        
    }
    return self;
}

-(void)tagHeaderViewWithTableView:(UITableView *)tableView tagArray:(NSArray<NSString *> *)tagArray{
    //移除所有的控件
    for (UIButton  * button in self.tagButtonArray) {
        [button removeFromSuperview];
    }
    
    [self.tagButtonArray removeAllObjects];
    
    
    //X值
    CGFloat x     =  0;
    //y值
    CGFloat y     =  CGRectGetMaxY(_hotSearchLabel.frame) + _edginInsets.top;
    //宽
    CGFloat width =  0;
    //横向的最大X值
    CGFloat max_x =  _edginInsets.left;
    
    //for创建标签控件
    for (int i = 0; i < tagArray.count; i++) {
    
        UIButton * tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
        tagButton.layer.cornerRadius  = 5;
        tagButton.layer.masksToBounds = YES;
        [tagButton setTitle:tagArray[i] forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:UIControlStateNormal];
        tagButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [tagButton addTarget:self action:@selector(tabgButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagButton];
        [self.tagButtonArray addObject:tagButton];
        
         //计算标签的宽度  在原来宽度的基础上加上20
        width = [KDSMallTool getStringWidth:tagArray[i] font:14] + 20;
        //横向排布未超出屏幕
        if (max_x + width + _columnMargin < KSCREENWIDTH) {
            x = max_x;
            max_x = x + width + _columnMargin;
        }else{//横向排布超出m屏幕
            x = _edginInsets.left;
            y = CGRectGetMaxY(_lastTagButton.frame) + _rowMargin;
            max_x = x + width + _columnMargin;
        }
        
         tagButton.frame = CGRectMake(x, y, width, _tagHeight);
        _lastTagButton = tagButton;
    }
    
    //设置tableHeaderView的frame
    [tableView setTableHeaderView:self];
    tableView.tableHeaderView.frame = CGRectMake(0, 0, KSCREENWIDTH, _edginInsets.bottom + CGRectGetMaxY(_lastTagButton.frame));
}

#pragma mark - 标签button点击事件
-(void)tabgButtonClick:(UIButton *)button{
    NSLog(@"点击了  %@",[button titleForState:UIControlStateNormal]);
    if ([_delegate respondsToSelector:@selector(honeSearchTagClick:)]) {
        [_delegate honeSearchTagClick:[button titleForState:UIControlStateNormal]];
    }
}

-(NSMutableArray *)tagButtonArray{
    if (_tagButtonArray == nil) {
        _tagButtonArray = [NSMutableArray array];
    }
    return _tagButtonArray;
}

@end
