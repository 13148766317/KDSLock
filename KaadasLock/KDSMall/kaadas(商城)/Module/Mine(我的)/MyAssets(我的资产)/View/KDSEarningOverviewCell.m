//
//  KDSEarningOverviewCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningOverviewCell.h"
#import "KDSEarningSegmentView.h"
#import "KDSEarningDetailView.h"

@interface KDSEarningOverviewCell ()
<
KDSEarningSegmentViewDelegate
>
@property (nonatomic,strong)KDSEarningSegmentView   * segmentView;
@property (nonatomic,strong)KDSEarningDetailView    * earningDetailView;
@end

@implementation KDSEarningOverviewCell

-(void)setAssetsDetail:(KDSMyAssetsDetailModel *)assetsDetail{
    _assetsDetail = assetsDetail;
    if ([KDSMallTool checkObjIsNull:_assetsDetail]) {
        return;
    }
    
    //直接收益
//    NSArray * titleArray = @[@"0\n直接收益(元)",@"0\n间接收益(元)",@"0\n介绍收益(元)",@"0\n解锁收益(元)"];
   NSString * label0String = [NSString stringWithFormat:@"%.2f\n直接收益(元)",[_assetsDetail.earnLevelOne floatValue]];
   UILabel * label0 =   _earningDetailView.labelArray[0];
    label0.attributedText = [KDSMallTool attributedString:label0String dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(label0String.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];
   //间接收益
   NSString * label1String = [NSString stringWithFormat:@"%.2f\n间接收益(元",[_assetsDetail.earnLevelTwo floatValue]];
   UILabel * label1 =   _earningDetailView.labelArray[1];
    label1.attributedText = [KDSMallTool attributedString:label1String dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(label1String.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];
    //介绍收益
   NSString * label2String = [NSString stringWithFormat:@"%.2f\n介绍收益(元)",[_assetsDetail.earnBole floatValue]];
   UILabel * label2 =   _earningDetailView.labelArray[2];
    label2.attributedText = [KDSMallTool attributedString:label2String dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(label2String.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];
    
    //解锁收益
//    NSString * label3String = [NSString stringWithFormat:@"%.2f\n解锁收益(元)",[_assetsDetail.earnTeam floatValue]];
//    UILabel * label3 =   _earningDetailView.labelArray[3];
//    label3.attributedText = [KDSMallTool attributedString:label3String dict:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(label3String.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //title
        UILabel * titleLb = [KDSMallTool createbBoldLabelString:@"收益概览" textColorString:@"#333333" font:15];
        [self.contentView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(18);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-300).priorityLow();
        }];
        
        //问号button
        UIButton * questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [questionButton setImage:[UIImage imageNamed:@"icon_detail_myproperty"] forState:UIControlStateNormal];
        [self.contentView addSubview:questionButton];
        [questionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLb.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(titleLb.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        //分割线
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(18);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //分段控件
        _segmentView = [[KDSEarningSegmentView alloc]initWithTitleArray:@[@"今日",@"昨日",@"本月",@"今年"]];
        _segmentView.delegate = self;
        [self.contentView addSubview:_segmentView];
        [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dividingView.mas_bottom).mas_offset(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        
        _earningDetailView = [[KDSEarningDetailView alloc]init];
        [self.contentView addSubview:_earningDetailView];
        [_earningDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.segmentView.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(self.earningDetailView.mas_width).multipliedBy(0.6);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10).priorityLow();
        }];
        
    }
    return self;
}

-(void)earningSegmentButtonClick:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(earningOverViewCellSegmentButtonClick:)]) {
        [_delegate earningOverViewCellSegmentButtonClick:index];
    }
}

+(instancetype)earningOverViewWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSEarningOverviewCellID";
    KDSEarningOverviewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
