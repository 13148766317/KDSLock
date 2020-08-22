//
//  KDSMyTeamCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyTeamCell.h"

@interface KDSMyTeamCell ()
@property (nonatomic,strong)NSMutableArray   * labelArray;
@end

@implementation KDSMyTeamCell
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    if (_dict == nil) {
        return;
    }
     NSString * labelTitle1 = [NSString stringWithFormat:@"%@\n直接下级(人)",[KDSMallTool checkISNull:_dict[@"data"][@"directOneCount"]]];
    UILabel * label1 = (UILabel *)_labelArray[0];
    label1.attributedText = [KDSMallTool attributedString:labelTitle1 dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(labelTitle1.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];

    NSString * labelTitle2 = [NSString stringWithFormat:@"%@\n间接下级(人)",[KDSMallTool checkISNull:_dict[@"data"][@"directTwoCount"]]];
    UILabel * label2 = (UILabel *)_labelArray[1];
    label2.attributedText = [KDSMallTool attributedString:labelTitle2 dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(labelTitle2.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];

   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        _labelArray = [NSMutableArray array];
        
        UIButton * myTeamBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [myTeamBgButton addTarget:self action:@selector(myteamBgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:myTeamBgButton];
        
        //我的团队
        UILabel * titleLB = [KDSMallTool createbBoldLabelString:@"我的团队" textColorString:@"#333333" font:15];
        [self.contentView addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(18);
        }];
        
        //右箭头
        UIImageView * rightArrow = [[UIImageView alloc]init];
        rightArrow.image = [UIImage imageNamed:@"icon_list_more"];
        [self.contentView addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(titleLB.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14));
        }];
        
        //分割线
        UIView * lineView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(titleLB.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //设置frame
        [myTeamBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.mas_equalTo(0);
            make.bottom.mas_equalTo(lineView.mas_bottom);
        }];
        
        
        NSArray * labelTitleArray = @[@"0\n直接下级(人)",@"0\n间接下级(人)"];
        
        CGFloat labelMargin = 10;
        CGFloat labelWidth  = (KSCREENWIDTH - 3 * labelMargin) / 2.0;
        CGFloat labelHeight  = 80;
        for (int i = 0; i < 2; i++) {
            UILabel * label = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:21];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = i;
            label.userInteractionEnabled = YES;
            NSString * titleString = labelTitleArray[i];
            label.attributedText = [KDSMallTool attributedString:titleString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(1, titleString.length - 1) lineSpacing:5 alignment:NSTextAlignmentCenter];
            UITapGestureRecognizer * labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapClick:)];
            [label addGestureRecognizer:labelTap];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).mas_offset(labelMargin + i *( labelMargin + labelWidth));
                make.top.mas_equalTo(lineView.mas_bottom).mas_offset(11);
                make.size.mas_equalTo(CGSizeMake(labelWidth, labelHeight));
            }];
            [_labelArray addObject:label];
            
        }
        
        UILabel * firstLabel = [_labelArray firstObject];
        
        //竖直分割线
        UIView * verticalLine = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:verticalLine];
        [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(firstLabel.mas_top);
            make.bottom.mas_equalTo(firstLabel.mas_bottom);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(dividinghHeight);
        }];
        
        //底部分割
        UIView * bottomDividingView = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:bottomDividingView];
        [bottomDividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(firstLabel.mas_bottom).mas_equalTo(10);
            make.height.mas_offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0).priorityLow();
        }];
        
    }
    return self;
}

-(void)labelTapClick:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(myTeamCellTapClick:)]) {
        [_delegate myTeamCellTapClick:tap.view.tag];
    }
}

-(void)myteamBgButtonClick{
    if ([_delegate respondsToSelector:@selector(myTeamCellEvent)]) {
        [_delegate myTeamCellEvent];
    }
}

+(instancetype)myTeamCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMyTeamCellID";
    KDSMyTeamCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}



@end
