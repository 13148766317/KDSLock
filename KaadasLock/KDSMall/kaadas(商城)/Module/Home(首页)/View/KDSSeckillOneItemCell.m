//
//  KDSSeckillOneItemCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//限时秒杀

#import "KDSSeckillOneItemCell.h"
#import "KDSClockView.h"

#import "KDSSecondPartModel.h"


@interface KDSSeckillOneItemCell ()
<
KDSClockViewDlegate
>

//图片
@property (nonatomic,strong)UIImageView   * photoImageView;
//商品昵称
@property (nonatomic,strong)UILabel   * productLabel;
//现价
@property (nonatomic,strong)UILabel   * nowPriceLB;
//原价
@property (nonatomic,strong)UILabel   * oldPriceLB;
//定时器
@property (nonatomic,strong)KDSClockView   * clockView;
// 限时
@property (nonatomic,strong)UILabel    * timeLimitLabel;
//结束图片
@property (nonatomic,strong)UIImageView  *  endImageView;
@end

@implementation KDSSeckillOneItemCell

-(void)setTimer:(NSInteger)timer{
    _timer = timer;
    
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    KDSSecondPartRowModel * model = [_array firstObject];
    
    //图片
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model.logo]]];
    [_photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_wh]];
    
    //定时器
    _clockView.timer = [KDSMallTool checkISNull:model.endTime];
    
    //商品昵称
    _productLabel.text = [KDSMallTool checkISNull:model.name];
    
    //现价
    NSString * priceString = [NSString stringWithFormat:@"￥%@",model.price];
    _nowPriceLB.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];
    
    //原价
    NSString * oldPriceString = [NSString stringWithFormat:@"￥%@",model.oldPrice];
    NSMutableAttributedString * oldPriceAttribut = [[NSMutableAttributedString alloc]initWithString:oldPriceString];
    [oldPriceAttribut addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceString.length)];
    _oldPriceLB.attributedText = oldPriceAttribut;
    
}

-(void)clockView:(id)clockView State:(BOOL)state{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (state) {
            KDSSecondPartRowModel * model = [_array firstObject];
            if ([model.status isEqualToString:@"activity_product_end"]) {
                _clockView.hidden = YES;
                _timeLimitLabel.text = @"活动已结束";
                _timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
                _endImageView.hidden = NO;
            }else{
                _clockView.hidden = NO;
                _timeLimitLabel.text = @"限时";
                _timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                _endImageView.hidden = YES;
            }
        }else{
            _clockView.hidden = YES;
            _timeLimitLabel.text = @"活动已结束";
            _timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
            _endImageView.hidden = NO;
        }
    });
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * clockImageView = [[UIImageView alloc]init];
        clockImageView.image = [UIImage imageNamed:@"icon_stopwatch_black"];
        [self.contentView addSubview:clockImageView];
        [clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(23);
            make.size.mas_equalTo(CGSizeMake(14, 14 * 31 / 26));
        }];

       //限时
        _timeLimitLabel = [KDSMallTool createLabelString:@"限时" textColorString:@"#333333" font:12];
        [self.contentView addSubview:_timeLimitLabel];
        [_timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(clockImageView.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(clockImageView.mas_centerY);
        }];
        
        //定时器
        _clockView = [[KDSClockView alloc]init];
        _clockView.delegate = self;
        [self.contentView addSubview:_clockView];
        [_clockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLimitLabel.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.timeLimitLabel.mas_centerY);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        
        //图片
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        [self.contentView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(120);
            make.right.mas_equalTo(-120);
            make.height.mas_equalTo(self.photoImageView.mas_width);
        }];
 
        //商品昵称
        _productLabel = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:18];
        _productLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_productLabel];
        [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.photoImageView.mas_bottom).mas_offset(39);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
        }];
        
        //现价
        _nowPriceLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_nowPriceLB];
        [_nowPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5);
            make.top.mas_equalTo(self.productLabel.mas_bottom).mas_offset(19);
        }];
        
        //原价
       
        _oldPriceLB =[KDSMallTool createLabelString:@"" textColorString:@"#999999" font:11];
        [self.contentView addSubview:_oldPriceLB];
        [_oldPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(5);
            make.centerY.mas_equalTo(self.nowPriceLB.mas_centerY).mas_offset(2);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30).priorityLow();
        }];
        
        //结束图片
        _endImageView = [[UIImageView alloc]init];
        _endImageView.hidden = YES;
        _endImageView.image = [UIImage imageNamed:@"pic_close_home"];
        [self.contentView  addSubview:_endImageView];
        [_endImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(70, 60));
        }];

        
    }
    return self;
}

+(instancetype)seckillOneItemCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSSeckillOneItemCellID";
    KDSSeckillOneItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
