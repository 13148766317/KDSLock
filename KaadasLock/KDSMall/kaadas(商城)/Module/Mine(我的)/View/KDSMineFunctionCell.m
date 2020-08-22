//
//  KDSMineFunctionCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMineFunctionCell.h"
#import "KDSOrderButton.h"

@interface KDSMineFunctionCell ()
@property (nonatomic,strong)NSMutableArray   * buttonArray;
@end

@implementation KDSMineFunctionCell

-(void)buttonClick:(KDSOrderButton *)button{
    if ([_delegate respondsToSelector:@selector(mineFunctionCellButtonClick:)]) {
        [_delegate mineFunctionCellButtonClick:button.tag];
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _buttonArray = [NSMutableArray array];
        
        NSArray * buttonImageArray = @[@"icon_bargain_mine",@"icon_post_mine",@"icon_collect_mine",@"icon_tracks_mine",@"icon_store_mine",@"icon_bargain_mine",@"icon_customer_mine",@"icon_feedback_mine"];
        NSArray * buttonTitleArray = @[@"砍价",@"我的帖子",@"我的收藏",@"浏览足迹",@"附近门店",@"设备管理",@"在线客服",@"反馈中心"];
        NSInteger coloum = 4;
        CGFloat buttonMargin = 10.0;
        CGFloat buttonW = (KSCREENWIDTH - buttonMargin *(coloum - 1)) / coloum;
        CGFloat buttonH = buttonW * 0.9;
        for (int i = 0; i < 8; i++) {
            KDSOrderButton * button = [KDSOrderButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:buttonImageArray[i]] forState:UIControlStateNormal];
            button.tag = i;
            [self.contentView addSubview:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0).mas_offset(15 + (i / coloum) * ( buttonH + 10));
                make.left.mas_equalTo(0).mas_offset((i % coloum) * ( buttonW + buttonMargin));
                make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
                if (i == 7) {
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10).priorityLow();
                }
            }];
            
        }
        
    }
    return self;
}

+(instancetype)mineFunctionCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMineFunctionCellID";
    KDSMineFunctionCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
