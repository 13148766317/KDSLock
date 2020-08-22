//
//  KDSHomeOneItemCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeOneItemCell.h"
#import "KDSSecondPartModel.h"
#import "KDSClockView.h"

@interface KDSHomeOneItemCell ()
<
KDSClockViewDlegate
>
@property (nonatomic,strong)UIImageView   * pictureImageView;
@property (nonatomic,strong)UILabel       * titleLb;
@property (nonatomic,strong)UILabel       * priceLB;
@property (nonatomic,strong)UIImageView   * endImageView;

@property (nonatomic,strong)UIImageView   * clockImageView;
@property (nonatomic,strong) UILabel      * timeLimitLabel;
@property (nonatomic,strong)KDSClockView  * clockView;
@end

@implementation KDSHomeOneItemCell

-(void)clockView:(KDSClockView *)clockView State:(BOOL)state{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self->_prouctType == KDSProduct_group) {
                if (state) {
                    KDSSecondPartRowModel * model =  [self->_array firstObject];
                    if ([model.status isEqualToString:@"activity_product_end"]) {
                        self->_endImageView.hidden = NO;
                        self->_clockImageView.hidden = NO;
                        self->_clockView.hidden = YES;
                        self->_timeLimitLabel.hidden = NO;
                        self->_timeLimitLabel.text = @"活动已结束";
                        self->_timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
                    }else{
                        self->_endImageView.hidden = YES;
                        self->_clockImageView.hidden = NO;
                        self->_clockView.hidden = NO;
                        self->_timeLimitLabel.hidden = NO;
                        self->_timeLimitLabel.text = @"限时";
                        self->_timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
                    }
                }else{//结束
                    self->_endImageView.hidden = NO;
                    self->_clockImageView.hidden = NO;
                    self->_clockView.hidden = YES;
                    self->_timeLimitLabel.hidden = NO;
                    self->_timeLimitLabel.text = @"活动已结束";
                    self->_timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
                }
              
            }else{
                self->_endImageView.hidden = YES;
                self->_clockImageView.hidden = YES;
                self->_timeLimitLabel.hidden = YES;
                self->_clockView.hidden = YES;
            }
    });
}

-(void)setArray:(NSArray *)array{
    _array  = array;
    KDSSecondPartRowModel * model =  [_array firstObject];
    
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    
    _titleLb.text = [KDSMallTool checkISNull:model.name];
    
    NSString * priceString = [NSString stringWithFormat:@"￥%@",model.price];
    
    _priceLB.attributedText =[KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];;
    
    if (_prouctType == KDSProduct_group) {
        if ([model.status isEqualToString:@"activity_product_end"]) {
            _endImageView.hidden = NO;
            _clockImageView.hidden = NO;
            _clockView.hidden = YES;
            _timeLimitLabel.hidden = NO;
            _timeLimitLabel.text = @"活动已结束";
            _timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        }else{
            _endImageView.hidden = YES;
            _clockImageView.hidden = NO;
            _clockView.hidden = NO;
            _timeLimitLabel.hidden = NO;
            _timeLimitLabel.text = @"限时";
            _timeLimitLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
            _clockView.timer = [KDSMallTool checkISNull:model.endTime];
        }
        [_pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clockView.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(self.pictureImageView.mas_width).multipliedBy(0.6);
        }];
    }else{
        _endImageView.hidden = YES;
        _clockImageView.hidden = YES;
        _timeLimitLabel.hidden = YES;
        _clockView.hidden = YES;
        [_pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(self.pictureImageView.mas_width).multipliedBy(0.6);
        }];
    }

}


-(void)setBargainArray:(NSArray *)bargainArray{
    _bargainArray = bargainArray;
    
    _endImageView.hidden = YES;
    _clockImageView.hidden = YES;
    _timeLimitLabel.hidden = YES;
    _clockView.hidden = YES;
    [_pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self.pictureImageView.mas_width).multipliedBy(0.6);
    }];
    
    KDSSecondPartRowModel * model =  [_bargainArray firstObject];
    
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    
    _titleLb.text = [KDSMallTool checkISNull:model.name];
    
    NSString * priceString = [NSString stringWithFormat:@"￥%@",model.maxPrice];
    
    _priceLB.attributedText =[KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(0, 1) lineSpacing:0];;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        
        //闹钟图片
        _clockImageView = [[UIImageView alloc]init];
        _clockImageView.image = [UIImage imageNamed:@"icon_stopwatch_black"];
        [self.contentView addSubview:_clockImageView];
        [_clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(23);
            make.size.mas_equalTo(CGSizeMake(14, 14 * 31 / 26));
        }];
        
        //限时
       _timeLimitLabel = [KDSMallTool createLabelString:@"限时" textColorString:@"#333333" font:12];
        [self.contentView addSubview:_timeLimitLabel];
        [_timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.clockImageView.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.clockImageView.mas_centerY);
        }];
         
        //时间
         _clockView = [[KDSClockView alloc]init];
        _clockView.delegate = self;
        [self.contentView addSubview:_clockView];
        [_clockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLimitLabel.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.timeLimitLabel.mas_centerY);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        
        _pictureImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_pictureImageView];
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clockView.mas_bottom);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(self.pictureImageView.mas_width).multipliedBy(0.6);
        }];
        
        _titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:20];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pictureImageView.mas_bottom).mas_offset(40);
//            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        _priceLB = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
        [self.contentView addSubview:_priceLB];
        [_priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(19);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-45).priorityLow();
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


+(instancetype)homeOneItemWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSHomeOneItemCellID";
    KDSHomeOneItemCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
