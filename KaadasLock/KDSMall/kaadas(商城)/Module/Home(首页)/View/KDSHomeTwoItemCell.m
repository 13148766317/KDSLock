//
//  KDSHomeTwoItemCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeTwoItemCell.h"
#import "KDSSecondPartModel.h"
#import "KDSClockView.h"
#import "KDSBargainListModel.h"

@interface KDSHomeTwoItemCell ()
<
KDSClockViewDlegate
>
@property (nonatomic,strong)NSMutableArray   * itemButtonArray;
@end

@implementation KDSHomeTwoItemCell

-(void)clockView:(KDSClockView *)clockView State:(BOOL)state{
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (clockView.tag == 3000) {//第一个定时器
                UIButton    * button         = _itemButtonArray[0];
                UIImageView * clockImageView = [button viewWithTag:1000];
                UILabel     * timeLimitLabel = [button viewWithTag:2000];
                UIImageView * endImageView   = [button viewWithTag:400];
                endImageView.hidden = YES;
                if (_productType == KDSProduct_group) {
                    if (state) {
//                        clockView.hidden = NO;
//                        endImageView.hidden = YES;
//                        timeLimitLabel.text = @"限时";
//                        timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                        KDSSecondPartRowModel * model =  _array[0];
                        if ([model.status isEqualToString:@"activity_product_end"]) {
                            endImageView.hidden = NO;
                            clockImageView.hidden = NO;
                            clockView.hidden = YES;
                            timeLimitLabel.hidden = NO;
                            timeLimitLabel.text = @"活动已结束";
                            timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
                        }else{
                            endImageView.hidden = YES;
                            clockImageView.hidden = NO;
                            clockView.hidden = NO;
                            timeLimitLabel.hidden = NO;
                            timeLimitLabel.text = @"限时";
                            timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                        }
                    }else{//结束
                        clockView.hidden = YES;
                        endImageView.hidden = NO;
                        timeLimitLabel.text = @"活动已结束";
                        timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
                    }
                }else{
                    endImageView.hidden = YES;
                    clockImageView.hidden = YES;
                    timeLimitLabel.hidden = YES;
                    clockView.hidden = YES;
                }
            }else{//第二个定时器
                UIButton    * button         = _itemButtonArray[1];
                UIImageView * clockImageView = [button viewWithTag:1001];
                UILabel     * timeLimitLabel = [button viewWithTag:2001];
                UIImageView * endImageView   = [button viewWithTag:401];
                endImageView.hidden = YES;
                if (_productType == KDSProduct_group) {
                    if (state) {
//                        clockView.hidden = NO;
//                        endImageView.hidden = YES;
//                        timeLimitLabel.text = @"限时";
//                        timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                        KDSSecondPartRowModel * model =  _array[1];
                        if ([model.status isEqualToString:@"activity_product_end"]) {
                            endImageView.hidden = NO;
                            clockImageView.hidden = NO;
                            clockView.hidden = YES;
                            timeLimitLabel.hidden = NO;
                            timeLimitLabel.text = @"活动已结束";
                            timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
                        }else{
                            endImageView.hidden = YES;
                            clockImageView.hidden = NO;
                            clockView.hidden = NO;
                            timeLimitLabel.hidden = NO;
                            timeLimitLabel.text = @"限时";
                            timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                            clockView.timer = [KDSMallTool checkISNull:model.endTime];
                        }
                    }else{//结束
                        clockView.hidden = YES;
                        endImageView.hidden = NO;
                        timeLimitLabel.text = @"活动已结束";
                        timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
                    }
                }else{
                    endImageView.hidden = YES;
                    clockImageView.hidden = YES;
                    timeLimitLabel.hidden = YES;
                    clockView.hidden = YES;
                }
            }
        });

}

-(void)setArray:(NSArray *)array{
    _array = array;
    for (int i = 0; i < _array.count; i++) {
        KDSSecondPartRowModel * model = _array[i];
        UIButton * button = (UIButton *)_itemButtonArray[i];
        UIImageView *  pictureImageView = [button viewWithTag:100 + i];
        NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model.logo]]];
        [pictureImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_wh]];

        UILabel * titleLb = [button viewWithTag:200 + i];
        titleLb.text = model.name;

        //
        UILabel * priceLB = [button viewWithTag:300 + i];
        NSString * priceString = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:model.price]];
        priceLB.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
        
        UIImageView * endImageView = [button viewWithTag:400 + i];
        
        //闹钟
        UIImageView * clockImageView = [button viewWithTag:1000 + i];
        //限时
        UILabel * timeLimitLabel = [button viewWithTag:2000 + i];
        //时间
        KDSClockView * clockView = [button viewWithTag:3000+i];
        endImageView.hidden = YES;
        
        if (_productType == KDSProduct_group) {
            if ([model.status isEqualToString:@"activity_product_end"]) {
                endImageView.hidden = NO;
                clockImageView.hidden = NO;
                clockView.hidden = YES;
                timeLimitLabel.hidden = NO;
                timeLimitLabel.text = @"活动已结束";
                timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
            }else{
                endImageView.hidden = YES;
                clockImageView.hidden = NO;
                clockView.hidden = NO;
                timeLimitLabel.hidden = NO;
                timeLimitLabel.text = @"限时";
                timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                clockView.timer = [KDSMallTool checkISNull:model.endTime];
            }
            [pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(clockView.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(pictureImageView.mas_width);
            }];
        }else{
            endImageView.hidden = YES;
            clockImageView.hidden = YES;
            timeLimitLabel.hidden = YES;
            clockView.hidden = YES;
            [pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(pictureImageView.mas_width);
            }];
        }
    }
    
}

-(void)setBargainArray:(NSArray *)bargainArray{
    _bargainArray = bargainArray;
    for (int i = 0; i < 2; i++) {
        
        UIButton * button = (UIButton *)_itemButtonArray[i];
        if (_bargainArray.count > i) {
            KDSBargainListRowModel * model = _bargainArray[i];
            button.hidden = NO;
            UIImageView *  pictureImageView = [button viewWithTag:100 + i];
            NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model.logo]]];
            [pictureImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_wh]];
            
            //
            UILabel * titleLb = [button viewWithTag:200 + i];
            titleLb.text = model.name;
    
            //
            UILabel * priceLB = [button viewWithTag:300 + i];
            NSString * priceString = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:model.maxPrice]];
            priceLB.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
            
            UIImageView * endImageView = [button viewWithTag:400 + i];
            endImageView.hidden = YES;
            
            [pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(pictureImageView.mas_width);
            }];
        }else{
            button.hidden = YES;
        }
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
            [itemButton addTarget:self action:@selector(homeItemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:itemButton];

            //闹钟图片
            UIImageView * clockImageView = [[UIImageView alloc]init];
            clockImageView.hidden = YES;
            clockImageView.tag = 1000 + i;
            clockImageView.image = [UIImage imageNamed:@"icon_stopwatch_black"];
            [itemButton addSubview:clockImageView];
            [clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(23);
                make.size.mas_equalTo(CGSizeMake(14, 14 * 31 / 26));
            }];
            
            //限时
            UILabel * timeLimitLabel = [KDSMallTool createLabelString:@"限时" textColorString:@"#333333" font:12];
            timeLimitLabel.hidden = YES;
            timeLimitLabel.tag = 2000 + i;
            [itemButton addSubview:timeLimitLabel];
            [timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(clockImageView.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(clockImageView.mas_centerY);
            }];
            
            //时间
            KDSClockView * clockView = [[KDSClockView alloc]init];
            clockView.hidden = YES;
            clockView.delegate = self;
            clockView.tag = 3000 + i;
            [itemButton addSubview:clockView];
            [clockView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(timeLimitLabel.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(timeLimitLabel.mas_centerY);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(30);
            }];
            

            UIImageView *  pictureImageView = [[UIImageView alloc]init];
            pictureImageView.tag = 100 + i;
            pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
            pictureImageView.clipsToBounds = YES;
            pictureImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
            [itemButton addSubview:pictureImageView];
            [pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(clockView.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(pictureImageView.mas_width);
            }];
         
            UILabel * titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:16];
            titleLb.textAlignment = NSTextAlignmentCenter;
            titleLb.tag = 200 + i;
            [itemButton addSubview:titleLb];
            [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(pictureImageView.mas_bottom).mas_offset(20);

                make.left.mas_equalTo(itemButton.mas_left).mas_offset(15);
                make.right.mas_equalTo(itemButton.mas_right).mas_offset(-15);
            }];

            UILabel * priceLB = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
            priceLB.tag = 300 + i;
            [itemButton addSubview:priceLB];
            [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(14);
                make.centerX.mas_equalTo(itemButton.mas_centerX);
                make.bottom.mas_equalTo(itemButton.mas_bottom).mas_offset(-27);
            }];

            //结束图片
            UIImageView * endImageView = [[UIImageView alloc]init];
            endImageView.tag = 400 + i;
            endImageView.hidden = YES;
            endImageView.image = [UIImage imageNamed:@"pic_close_home"];
            [itemButton addSubview:endImageView];
            [endImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(45, 45 * 60 / 71));
            }];
            
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0).mas_offset(i * (itemButtonMargin + itemWidth));
                make.top.mas_equalTo(topMargin);
                make.width.mas_equalTo(itemWidth);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
            }];
            
            [_itemButtonArray  addObject:itemButton];
        }
        
    }
    return self;
}

-(void)homeItemButtonClick:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(homeTwoItemCellButtonClick:buttonTag:productType:)]) {
        [_delegate homeTwoItemCellButtonClick:_indexPath buttonTag:button.tag productType:_productType];
    }
}

+(instancetype)homeTwoItemWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSHomeTwoItemCellID";
    KDSHomeTwoItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
