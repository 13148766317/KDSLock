//
//  KDSCrowdfundingOneCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
// 今日众筹

#import "KDSCrowdfundingOneCell.h"
#import "KDSCheckButton.h"
#import "KDSHomeProgressView.h"

#import "KDSSecondPartModel.h"

@interface KDSCrowdfundingOneCell ()
//产品名称
@property (nonatomic,strong)UILabel          * titleLb;
//价格
@property (nonatomic,strong)UILabel          * priceLb;
//立即查看
@property (nonatomic,strong)KDSCheckButton   * checkButton;
//图片
@property (nonatomic,strong)UIImageView      * photoImageView;
//进度条
@property (nonatomic,strong)KDSHomeProgressView   * progressView;
@end

@implementation KDSCrowdfundingOneCell

-(void)setArray:(NSArray *)array{
    _array  = array;
    KDSSecondPartRowModel * model =  [_array firstObject];
    
    //产品名称
    _titleLb.text = [KDSMallTool checkISNull:model.name];
    
    //价格
    NSString * priceString = [NSString stringWithFormat:@"￥%@",model.price];
    _priceLb.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
    
    //图片
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model.logo]]];
    [_photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_wh]];
    
    //进度条
    _progressView.rowModel = model;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //产品名称
        _titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:18];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(56);
            make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.45);
            make.height.mas_equalTo(30);
        }];
        
        //价格
        _priceLb = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
        [self.contentView addSubview:_priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left).mas_offset(1);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(20);
        }];
        
        //立即查看
        _checkButton = [KDSCheckButton buttonWithType:UIButtonTypeCustom];
        [_checkButton setTitle:@"立即查看" forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(oneItemCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
        [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.priceLb.mas_left);
            make.top.mas_equalTo(self.priceLb.mas_bottom).mas_offset(19);
            make.size.mas_equalTo(CGSizeMake(75, 30));
        }];
        
        //图片
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        [self.contentView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(KSCREENWIDTH / 2 - 30);
            make.top.mas_equalTo(self.titleLb.mas_top).mas_offset(-26);
            make.height.mas_equalTo(self.photoImageView.mas_width);
        }];
        
        //进度条
        _progressView = [[KDSHomeProgressView alloc]init];
        [self.contentView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_left);
            make.top.mas_equalTo(self.checkButton.mas_bottom).mas_offset(45);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30).priorityMedium();
        }];
    
    
    }
    return self;
}

#pragma mark - 立即查看事件
-(void)oneItemCheckButtonClick{
    NSLog(@"item one 立即查看");
}


+(instancetype)crowdfundingOneCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSCrowdfundingOneCellID";
    KDSCrowdfundingOneCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
