//
//  KDSMyAssetsCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyAssetsCell.h"

@interface KDSMyAssetsCell ()
//累计收益
@property (nonatomic,strong)UILabel   * totalEarningsLB;
//今日收益
@property (nonatomic,strong)UILabel   * todayEarningLB;
//本月收益
@property (nonatomic,strong)UILabel   * monthEarningLB;
//可提现余额
@property (nonatomic,strong)UILabel   * getMoneyLabel;


@end

@implementation KDSMyAssetsCell

-(void)setAssetsModel:(KDSMyAssetsModel *)assetsModel{
    _assetsModel = assetsModel;
    if ([KDSMallTool checkObjIsNull:_assetsModel]) {
        return;
    }
    
    //累计收益
    NSString * totalEarningString = [NSString stringWithFormat:@"￥%@\n 累计收益",[KDSMallTool checkISNull:_assetsModel.allMoney]];

    NSMutableAttributedString * totalEarningAtt = [[NSMutableAttributedString alloc]initWithString:totalEarningString];
    [totalEarningAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, 1)];
    [totalEarningAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(1, [KDSMallTool checkISNull:_assetsModel.allMoney].length)];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10; // 调整行间距
    [totalEarningAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, totalEarningString.length)];
    _totalEarningsLB.attributedText = totalEarningAtt;
    
    
    
    //今日收益
    NSString * todayEarningString  = [NSString stringWithFormat:@"今日收益:￥%@",[KDSMallTool checkISNull:_assetsModel.todayMoney]];
    
    NSMutableAttributedString * todayAttribut = [[NSMutableAttributedString alloc]initWithString:todayEarningString];
    [todayAttribut addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(5, 1)];
//    [todayAttribut addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"333333"] range:NSMakeRange(5, 1)];
    [todayAttribut addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, [KDSMallTool checkISNull:_assetsModel.todayMoney].length)];
//    [todayAttribut addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"333333"] range:NSMakeRange(6, [KDSMallTool checkISNull:_assetsModel.todayMoney].length)];
    _todayEarningLB.attributedText = todayAttribut;
    
    //本月收益
    NSString *  monthEarningString = [NSString stringWithFormat:@"本月收益:￥%@",[KDSMallTool checkISNull:_assetsModel.monthMoney]];
    
    NSMutableAttributedString * monthEarnAtt = [[NSMutableAttributedString alloc]initWithString:monthEarningString];
    [monthEarnAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(5, 1)];
    [monthEarnAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(6, [KDSMallTool checkISNull:_assetsModel.monthMoney].length)];
     _monthEarningLB.attributedText = monthEarnAtt;
    
    //可提现
    NSString * getMoneyString = [NSString stringWithFormat:@"￥%@\n可提现余额",[KDSMallTool checkISNull:_assetsModel.balance]];

    NSMutableAttributedString * getMoneyAtt = [[NSMutableAttributedString alloc]initWithString:getMoneyString];
    [getMoneyAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 1)];
    [getMoneyAtt addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] range:NSMakeRange(0, 1)];
    [getMoneyAtt addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] range:NSMakeRange(1, [KDSMallTool checkISNull:_assetsModel.balance].length)];
    [getMoneyAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:21] range:NSMakeRange(1, [KDSMallTool checkISNull:_assetsModel.balance].length)];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 10; // 调整行间距
    [getMoneyAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, getMoneyString.length)];
    _getMoneyLabel.attributedText = getMoneyAtt;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //顶部分割线
        UIView * topDividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:topDividing];
        [topDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        
        //累计收益
        _totalEarningsLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        _totalEarningsLB.numberOfLines = 0;
        [self.contentView addSubview:_totalEarningsLB];
        [_totalEarningsLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.top.mas_equalTo(topDividing.mas_bottom).mas_offset(28);
        }];
        
        //明细button
        JXLayoutButton * earningButton = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
        earningButton.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
        earningButton.midSpacing = 5;
        [earningButton setTitle:@"明细" forState:UIControlStateNormal];
        earningButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [earningButton setImage:[UIImage imageNamed:@"icon_more_myproperty"] forState:UIControlStateNormal];
        [earningButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#4992ff"] forState:UIControlStateNormal];
        [earningButton addTarget:self action:@selector(earningButtonClick) forControlEvents:UIControlEventTouchUpInside];
       
        [self.contentView addSubview:earningButton];
        [earningButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(self.totalEarningsLB.mas_top).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(55, 40));
        }];
        
        //今日收益
        _todayEarningLB = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_todayEarningLB];
        [_todayEarningLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.totalEarningsLB.mas_left).mas_offset(4);
            make.top.mas_equalTo(self.totalEarningsLB.mas_bottom).mas_offset(28);
        }];
        
        //本月收益
        _monthEarningLB = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_monthEarningLB];
        [_monthEarningLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.todayEarningLB.mas_top);
        }];
        
        //分割线
        UIView * lineView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.todayEarningLB.mas_bottom).mas_offset(28);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
        //可提现余额
        _getMoneyLabel = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        _getMoneyLabel.numberOfLines = 0;
        [self.contentView addSubview:_getMoneyLabel];
        [_getMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_left);
            make.top.mas_equalTo(lineView.mas_bottom).mas_offset(28);
        }];
        
        
        //去提现
        UIButton * getMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getMoneyButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        getMoneyButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [getMoneyButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ffffff"] forState:UIControlStateNormal];
        [getMoneyButton setTitle:@"去提现" forState:UIControlStateNormal];
        [getMoneyButton addTarget:self action:@selector(getMoneyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:getMoneyButton];
        
        [getMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.getMoneyLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 33));
        }];
        
        //底部分割
        UIView * bottomDividingView = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:bottomDividingView];
        [bottomDividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.getMoneyLabel.mas_bottom).mas_equalTo(28);
            make.height.mas_offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0).priorityLow();
        }];
        
    }
    return self;
}

#pragma mark - 明细点击事件
-(void)earningButtonClick{
    if ([_delegate respondsToSelector:@selector(myAssetsCellEvent:)]) {
        [_delegate myAssetsCellEvent:KDSMyAssetsEvent_earning];
    }
}

#pragma mark - 提现点击事件
-(void)getMoneyButtonClick{
    if ([_delegate respondsToSelector:@selector(myAssetsCellEvent:)]) {
        [_delegate myAssetsCellEvent:KDSMyAssetsEvent_getMoney];
    }
}

+(instancetype)myAssetsCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMyAssetsCellID";
    KDSMyAssetsCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
