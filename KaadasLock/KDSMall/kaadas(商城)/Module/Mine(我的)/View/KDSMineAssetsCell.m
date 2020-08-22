//
//  KDSMineAssetsCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
//我的资产

#import "KDSMineAssetsCell.h"
#import "KDSMineCellHeaderView.h"
@interface KDSMineAssetsCell ()

@property (nonatomic,strong)KDSMineCellHeaderView   * headerView;
@property (nonatomic,strong)NSMutableArray          * labelArray;
@end

@implementation KDSMineAssetsCell

-(void)assetButtonClick{
    if ([_delegate respondsToSelector:@selector(mineAssetsCellEvent:)]) {
        [_delegate mineAssetsCellEvent:KDSMineAssetsEvent_myAssets];
    }
}

-(void)labelTapClick:(UITapGestureRecognizer *)tap{

    KDSMineAssetsEventType type = -1;
    switch (tap.view.tag) {
        case 0:{//任务
            type =  KDSMineAssetsEvent_assignment;
        }
            break;
        case 1:{//优惠券
            type =  KDSMineAssetsEvent_discountCoupon;
        }
            break;
        case 2:{//积分
            type =  KDSMineAssetsEvent_integral;
        }
            break;
            
        default:
            break;
    }
    if (type < 0) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(mineAssetsCellEvent:)]) {
        [_delegate mineAssetsCellEvent:type];
    }
}

-(void)refreshData{
    
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    
    NSString * labelTitle = @"";
    //任务
    
    labelTitle = [NSString stringWithFormat:@"%@\n任务",[KDSMallTool checkISNull:userModel.taskNum].length <= 0 ? @"0" : [KDSMallTool checkISNull:userModel.taskNum]];
    UILabel * firstLabel = (UILabel *)_labelArray[0];
    firstLabel.attributedText = [KDSMallTool attributedString:labelTitle dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"333333"]} range:NSMakeRange(0, [KDSMallTool checkISNull:userModel.taskNum].length) lineSpacing:10 alignment:NSTextAlignmentCenter];
    
    //优惠券
    labelTitle = [NSString stringWithFormat:@"%@\n优惠券",[KDSMallTool checkISNull:userModel.couponNum].length <= 0 ? @"0" : [KDSMallTool checkISNull:userModel.couponNum]];
    UILabel * secondLabel = (UILabel *)_labelArray[1];
    secondLabel.attributedText = [KDSMallTool attributedString:labelTitle dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"333333"]} range:NSMakeRange(0, [KDSMallTool checkISNull:userModel.couponNum].length) lineSpacing:10 alignment:NSTextAlignmentCenter];
    //积分
    labelTitle = [NSString stringWithFormat:@"%@\n积分",[KDSMallTool checkISNull:userModel.score].length <= 0 ? @"0" : [KDSMallTool checkISNull:userModel.score]];
    UILabel * threeLabel = (UILabel *)_labelArray[2];
    threeLabel.attributedText = [KDSMallTool attributedString:labelTitle dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"333333"]} range:NSMakeRange(0, [KDSMallTool checkISNull:userModel.score].length) lineSpacing:10 alignment:NSTextAlignmentCenter];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _labelArray = [NSMutableArray array];
        
        _headerView = [[KDSMineCellHeaderView alloc]init];
        [_headerView addTarget:self action:@selector(assetButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _headerView.text = @"我的资产";
        [self.contentView addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        CGFloat labelMargin = 20.0f;
        CGFloat labelWidth = (KSCREENWIDTH - 2 * labelMargin)/3.0;
        CGFloat labelHeight = 90.0f;
        CGFloat  labelX = 0;
        CGFloat labelY  = 10;
     
        for (int i = 0; i < 3; i++ ) {
    
            UILabel * label = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
            label.userInteractionEnabled = YES;
            label.tag = i;
            UITapGestureRecognizer * labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapClick:)];
            [label addGestureRecognizer:labelTap];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
          
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(labelX).mas_offset(i * (labelMargin + labelWidth));
                make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(labelY);
                make.size.mas_equalTo(CGSizeMake(labelWidth, labelHeight));
            }];
            
            [_labelArray addObject:label];
        }
        
        
        UILabel * firstLabel = [_labelArray firstObject];
        
        //分线
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(firstLabel.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
    }
    return self;
}

+(instancetype)mineAssetsCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMineAssetsCellID";
    KDSMineAssetsCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
