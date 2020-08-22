//
//  KDSSeckillTwoItemCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
////限时秒杀

#import "KDSSeckillTwoItemCell.h"
#import "KDSClockView.h"
#import "KDSSecondPartModel.h"

@interface KDSSeckillTwoItemCell ()
<
KDSClockViewDlegate
>
@property (nonatomic,strong)NSMutableArray   * itemButtonArray;
@property (nonatomic,assign)double         durationInSeconds;
@end

@implementation KDSSeckillTwoItemCell

-(void)homeItemButtonClick:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(seckillTwoItemCellButtonClck:buttonTag:)]) {
        [_delegate seckillTwoItemCellButtonClck:_indexPath buttonTag:button.tag];
    }
}

-(void)clockView:(KDSClockView *)clockView State:(BOOL)state{
  
    dispatch_async(dispatch_get_main_queue(), ^{
        if (clockView.tag == 100) {//第一个定时器
            KDSSecondPartRowModel * rowModel = _array[0];
            UIButton * button = _itemButtonArray[0];
            UILabel *    timeLimitLabel =  [button viewWithTag:1000];
            UIImageView * endImageView  = [button viewWithTag:600];
            if (state) {
                
                if ([rowModel.status isEqualToString:@"activity_product_end"]) {
                    clockView.hidden = YES;
                    endImageView.hidden = NO;
                    timeLimitLabel.text = @"活动已结束";
                    timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
                }else{
                    clockView.hidden = NO;
                    endImageView.hidden = YES;
                    timeLimitLabel.text = @"限时";
                    timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                }
        
            }else{//结束
                clockView.hidden = YES;
                endImageView.hidden = NO;
                timeLimitLabel.text = @"活动已结束";
                timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
            }
        }else{//第二个定时器
            KDSSecondPartRowModel * rowModel = _array[1];
            UIButton * button = _itemButtonArray[1];
            UILabel *    timeLimitLabel =  [button viewWithTag:1001];
            UIImageView * endImageView  = [button viewWithTag:601];
            if (state) {
                if ([rowModel.status isEqualToString:@"activity_product_end"]) {
                    clockView.hidden = YES;
                    endImageView.hidden = NO;
                    timeLimitLabel.text = @"活动已结束";
                    timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
                }else{
                    clockView.hidden = NO;
                    endImageView.hidden = YES;
                    timeLimitLabel.text = @"限时";
                    timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                }
            }else{//结束
                clockView.hidden = YES;
                endImageView.hidden = NO;
                timeLimitLabel.text = @"活动已结束";
                timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
            }
        }
    });
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    for (int i = 0; i < _array.count; i++) {
        UIButton * button = _itemButtonArray[i];
        
        KDSSecondPartRowModel * rowModel = _array[i];
        //计算结束时间和当前时间相差的秒数
//        _durationInSeconds = [KDSMallTool durationIndistanceSeconds:[KDSMallTool checkISNull:rowModel.endTime]];  //相差秒
        //时间
        KDSClockView * clockView = [button viewWithTag:100+ i];
       
        clockView.timer = [KDSMallTool checkISNull:rowModel.endTime];
//        clockView.second = rowModel.second;
        
        //图片
        UIImageView * photoImageView = [button viewWithTag:200 + i];
        NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:rowModel.logo]]];
        [photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_wh]];
        
        //商品昵称
        UILabel * productLabel = [button viewWithTag:300 + i];
        productLabel.text = [KDSMallTool checkISNull:rowModel.name];
        
        //现价
        UILabel * nowPriceLB = [button viewWithTag:400 + i];
        NSString * priceString =  [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:rowModel.price]];
        nowPriceLB.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
        
        
        //原价
        UILabel * oldPriceLB = [button viewWithTag:500 + i];
        NSString * oldPriceString = [NSString stringWithFormat:@"￥%@",rowModel.oldPrice];
        NSMutableAttributedString * oldPriceAttribut = [[NSMutableAttributedString alloc]initWithString:oldPriceString];
        [oldPriceAttribut addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceString.length)];
        oldPriceLB.attributedText = oldPriceAttribut;
        
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
            
            
            UIImageView * clockImageView = [[UIImageView alloc]init];
            clockImageView.image = [UIImage imageNamed:@"icon_stopwatch_black"];
            [itemButton addSubview:clockImageView];
            [clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(23);
                make.size.mas_equalTo(CGSizeMake(14, 14 * 31 / 26));
            }];
            
            //限时
            UILabel * timeLimitLabel = [KDSMallTool createLabelString:@"限时" textColorString:@"#333333" font:12];
            timeLimitLabel.tag = 1000 + i;
            [itemButton addSubview:timeLimitLabel];
            [timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(clockImageView.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(clockImageView.mas_centerY);
            }];

            //时间
            KDSClockView * clockView = [[KDSClockView alloc]init];
            clockView.delegate = self;
            clockView.tag = 100 + i;
            [itemButton addSubview:clockView];
            [clockView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(timeLimitLabel.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(timeLimitLabel.mas_centerY);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(30);
            }];
            
            //图片
            UIImageView * photoImageView = [[UIImageView alloc]init];
            photoImageView.contentMode = UIViewContentModeScaleAspectFill;
            photoImageView.clipsToBounds = YES;
            photoImageView.tag = 200 + i;
            [itemButton addSubview:photoImageView];
            [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(60);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);

                make.height.mas_equalTo(photoImageView.mas_width);
            }];
            
            //商品昵称
            UILabel * productLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:16];
            productLabel.textAlignment = NSTextAlignmentCenter;
            productLabel.tag = 300 + i;
            [itemButton addSubview:productLabel];
            [productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(photoImageView.mas_bottom).mas_offset(27);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            
            //现价
            UILabel * nowPriceLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
            nowPriceLB.tag = 400 + i;
            [itemButton addSubview:nowPriceLB];
            [nowPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(itemButton.mas_centerX).mas_offset(-5);
                make.top.mas_equalTo(productLabel.mas_bottom).mas_offset(17);
            }];
            
           //原价
            UILabel * oldPriceLB =[KDSMallTool createLabelString:@"" textColorString:@"#999999" font:11];
            oldPriceLB.tag = 500 + i;
            [itemButton addSubview:oldPriceLB];
            [oldPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(itemButton.mas_centerX).mas_offset(5);
                make.centerY.mas_equalTo(nowPriceLB.mas_centerY).mas_offset(2);
                make.bottom.mas_equalTo(itemButton.mas_bottom).mas_offset(-27);
            }];
            
            
            //结束图片
            UIImageView * endImageView = [[UIImageView alloc]init];
            endImageView.tag = 600 + i;
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
            
            [_itemButtonArray addObject:itemButton];
        }

    }
    return self;
}


+(instancetype)seckillTwoItemCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSSeckillTwoItemCellID";
    KDSSeckillTwoItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
