//
//  KDSCrowdfundingTwoCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
// 今日众筹

#import "KDSCrowdfundingTwoCell.h"
#import "KDSCheckButton.h"
#import "KDSHomeProgressView.h"

#import "KDSSecondPartModel.h"

@interface KDSCrowdfundingTwoCell ()
@property (nonatomic,strong)NSMutableArray   * itemButtonArray;
@end

@implementation KDSCrowdfundingTwoCell

-(void)setArray:(NSArray *)array{
    _array = array;
    
    for (int i = 0; i < _array.count; i++) {
        KDSSecondPartRowModel * model1 = (KDSSecondPartRowModel *)_array[i];
        
        UIButton * button = (UIButton *)_itemButtonArray[i];
        
        //产品名称
        UILabel * titleLb = [button viewWithTag:100 + i];
        titleLb.text = [KDSMallTool checkISNull:model1.name];
        
        //价格
        UILabel * priceLb = [button viewWithTag:200 + i];
        NSString * priceString = [NSString stringWithFormat:@"￥%@",model1.price];
        priceLb.attributedText =  [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
        
        //图片
        UIImageView *  photoImageView = [button viewWithTag:300 + i];
        [photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model1.logo]]] placeholderImage:[UIImage imageNamed:placeholder_h]];
        
        //进度条
        KDSHomeProgressView * progressView = [button viewWithTag:400 +i];
        progressView.rowModel = model1;
        
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _itemButtonArray = [NSMutableArray array];
        
        CGFloat topMargin        = 5;
        CGFloat itemButtonMargin = 5;
        CGFloat itemWidth        = (KSCREENWIDTH- itemButtonMargin )/ 2.0;
        
        for (int i = 0; i < 2; i++) {
            UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.tag = i;
            itemButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
            [itemButton addTarget:self action:@selector(crowdFundingItemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:itemButton];
            
            
            //图片
            UIImageView *  photoImageView = [[UIImageView alloc]init];
            photoImageView.contentMode = UIViewContentModeScaleAspectFill;
            photoImageView.clipsToBounds = YES;
            photoImageView.tag = 300 + i;
            [itemButton addSubview:photoImageView];
            [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(15);
                make.height.mas_equalTo(photoImageView.mas_width);
            }];
            
            //产品名称
            UILabel * titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:16];
            titleLb.tag = 100 + i;
            [itemButton addSubview:titleLb];
            [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(photoImageView.mas_bottom).mas_offset(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            
            //价格
            UILabel * priceLb = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
            priceLb.tag = 200 + i;
            [itemButton addSubview:priceLb];
            [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLb.mas_left);
                make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(15);
            }];
            
            //进度条
            KDSHomeProgressView * progressView = [[KDSHomeProgressView alloc]init];
            progressView.tag = 400 + i;
            [itemButton addSubview:progressView];
            [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLb.mas_left);
                make.top.mas_equalTo(priceLb.mas_bottom).mas_offset(27);
                make.right.mas_equalTo(-15);
                make.bottom.mas_equalTo(itemButton.mas_bottom).mas_offset(-15);
            }];

            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).mas_offset(i * (itemButtonMargin + itemWidth));
                make.top.mas_equalTo(topMargin);
                make.width.mas_equalTo(itemWidth);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
            }];
            
            
//            //产品名称
//            UILabel * titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:18];
//            titleLb.tag = 100 + i;
//            [itemButton addSubview:titleLb];
//            [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(15);
//                make.top.mas_equalTo(56);
//                make.width.mas_equalTo(itemButton.mas_width).multipliedBy(0.45);
//            }];
//
//            //价格
//            UILabel * priceLb = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
//            priceLb.tag = 200 + i;
//            [itemButton addSubview:priceLb];
//            [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(titleLb.mas_left);
//                make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(5);
//            }];
//
//            //立即查看
//            KDSCheckButton *  checkButton = [KDSCheckButton buttonWithType:UIButtonTypeCustom];
//            [checkButton setTitle:@"立即查看" forState:UIControlStateNormal];
//            [checkButton setImage:[UIImage imageNamed:@"icon_home_more_big"] forState:UIControlStateNormal];
//            [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchDown];
//            [itemButton addSubview:checkButton];
//            [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(priceLb.mas_left);
//                make.top.mas_equalTo(priceLb.mas_bottom).mas_offset(29);
//                make.size.mas_equalTo(CGSizeMake(75, 30));
//            }];
//
//            //图片
//            UIImageView *  photoImageView = [[UIImageView alloc]init];
//            photoImageView.contentMode = UIViewContentModeScaleAspectFill;
//            photoImageView.clipsToBounds = YES;
//            photoImageView.tag = 300 + i;
//            [itemButton addSubview:photoImageView];
//            [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(itemButton.mas_centerX).mas_offset(5);
//                make.right.mas_equalTo(-5);
//                make.top.mas_equalTo(40);
//
//                make.height.mas_equalTo(120);
//            }];
//
//            //进度条
//            KDSHomeProgressView * progressView = [[KDSHomeProgressView alloc]init];
//            progressView.tag = 400 + i;
//            [itemButton addSubview:progressView];
//            [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(titleLb.mas_left);
//                make.top.mas_equalTo(checkButton.mas_bottom).mas_offset(65);
//                make.right.mas_equalTo(-15);
//                make.bottom.mas_equalTo(itemButton.mas_bottom).mas_offset(-30);
//            }];
//
//            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(0).mas_offset(i * (itemButtonMargin + itemWidth));
//                make.top.mas_equalTo(topMargin);
//                make.width.mas_equalTo(itemWidth);
//                make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
//            }];
        
            [_itemButtonArray addObject:itemButton];
        }
        
    }
    return self;
}

#pragma mark -
-(void)crowdFundingItemButtonClick:(UIButton *)button{
    
    if ([_delegate respondsToSelector:@selector(crowdfundingTwoCellButtonClick:buttonTag:)]) {
        [_delegate crowdfundingTwoCellButtonClick:_indexPath buttonTag:button.tag];
    }
    
    NSLog(@"%@\n%@\n%@\n%@\n",[button viewWithTag:100],[button viewWithTag:200],[button viewWithTag:300],[button viewWithTag:400]);
}

-(void)checkButtonClick:(KDSCheckButton *)btn{
    UIButton * superButton = (UIButton *)[btn superview];
    if ([_delegate respondsToSelector:@selector(crowdfundingTwoCellCheckButtonClick:buttonTag:)]) {
        [_delegate crowdfundingTwoCellCheckButtonClick:_indexPath buttonTag:superButton.tag];
    }
    NSLog(@"%ld",(long)[btn superview].tag);
}

+(instancetype)crowdfundingTwoCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSCrowdfundingTwoCellID";
    KDSCrowdfundingTwoCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
