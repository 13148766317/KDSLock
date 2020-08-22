//
//  KDSHomeMoreItemCell.m
//  kaadas
//
//  Created by 中软云 on 2019/8/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeMoreItemCell.h"

@interface KDSHomeMoreItemCell  ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)NSArray       * dataArray;
@end

@implementation KDSHomeMoreItemCell

-(void)buttonItemClick:(JXLayoutButton *)button{
    if ([_delegate respondsToSelector:@selector(homeMoreItemCellButtonClick:)]) {
        [_delegate homeMoreItemCellButtonClick:button.tag];
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dataArray:(NSArray *)dataArray{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _dataArray = dataArray;
        
        UIView * topDividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:topDividingView];
        [topDividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(15);
        }];
        
        CGFloat scrollViewH = 109;
        _scrollView  = [[UIScrollView alloc]init];
        [self.contentView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topDividingView.mas_bottom);
            make.right.left.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(KSCREENWIDTH);
            make.height.mas_equalTo(scrollViewH);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
    
        CGFloat buttonH = scrollViewH;

        CGFloat buttonMargin = 5;
        CGFloat buttonW =  (KSCREENWIDTH - 3 * (buttonMargin)) / 4;
        for (int i = 0; i < _dataArray.count; i++) {
            JXLayoutButton * button = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setImage:[UIImage imageNamed:_dataArray[i]] forState:UIControlStateNormal];
            [button setTitle:_dataArray[i] forState:UIControlStateNormal];
            button.layoutStyle = JXLayoutButtonStyleUpImageDownTitle;
            button.midSpacing = 10;
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:UIControlStateNormal];
            [_scrollView addSubview:button];
            [button addTarget:self action:@selector(buttonItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(0);
                make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
                make.left.mas_equalTo(0).mas_equalTo(i * (buttonW + buttonMargin));
            }];
            
        }
        
        _scrollView.contentSize = CGSizeMake(buttonW * _dataArray.count, scrollViewH);
        
    }
    return self;
}

+(instancetype)homeMoreItemWithTableView:(UITableView *)tableView dataArray:(NSArray *)dataArray{
    static NSString * cellID = @"KDSHomeMoreItemCellID";
    KDSHomeMoreItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID dataArray:dataArray];
    }
    return cell;
}


@end
