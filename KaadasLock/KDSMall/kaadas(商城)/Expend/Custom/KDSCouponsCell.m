//
//  KDSCouponsCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/17.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSCouponsCell.h"

@interface KDSCouponsCell ()

@property (nonatomic,strong)UIView         * topBgView;
@property (nonatomic,strong)UIView         * bottomBgView;
@property (nonatomic,strong)UILabel        * couponTypeLb;
@property (nonatomic,strong)UILabel        * couponPriceLb;
@property (nonatomic,strong)UIButton       * selectButton;
@property (nonatomic,strong)UILabel        * desLb;
@property (nonatomic,strong)UILabel        * timeLb;

@end

@implementation KDSCouponsCell

-(void)selectButtonClick{
    
    _selectButton.selected = !_selectButton.selected;
    _model.select = _selectButton.selected;
    
    if ([_delegate respondsToSelector:@selector(couponsCellDelegate:model:)]) {
        [_delegate couponsCellDelegate:_indexPath model:_model];
    }
    
}

-(void)setModel:(KDSCoupon1Model *)model{
    _model = model;
    NSString * couponValue = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_model.couponValue]];
    _couponPriceLb.attributedText = [KDSMallTool attributedString:couponValue dict:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, 1) lineSpacing:0];
    
    _desLb.text = [NSString stringWithFormat:@"满%@减%@",[KDSMallTool checkISNull:_model.couponCondition],[KDSMallTool checkISNull:_model.couponValue]];
    _timeLb.text = [NSString stringWithFormat:@"有效期：%@ 至 %@",[KDSMallTool checkISNull:_model.startDate],[KDSMallTool checkISNull:_model.expirationDate]];
    if (_model.select) {
        _selectButton.selected = YES;
    }else{
        _selectButton.selected = NO;
    }
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F7F7F7"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _topBgView = [[UIView alloc]init];
        _topBgView.backgroundColor  = [UIColor hx_colorWithHexRGBAString:@"#F6EDE3"];
        [self.contentView addSubview:_topBgView];
        [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(60);
        }];
        
        _bottomBgView = [[UIView alloc]init];
        _bottomBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        [self.contentView addSubview:_bottomBgView];
        [_bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topBgView.mas_left);
            make.right.mas_equalTo(self.topBgView.mas_right);
            make.height.mas_equalTo(self.topBgView.mas_height);
            make.top.mas_equalTo(self.topBgView.mas_bottom);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
        //
        _couponTypeLb = [KDSMallTool createLabelString:@"现金券" textColorString:@"#8A7A6A" font:12];
        _couponTypeLb.textAlignment = NSTextAlignmentCenter;
        _couponTypeLb.layer.cornerRadius = 2;
        _couponTypeLb.layer.masksToBounds = YES;
        _couponTypeLb.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [_topBgView addSubview:_couponTypeLb];
        [_couponTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 25));
            make.centerY.mas_equalTo(_topBgView.mas_centerY);
        }];
        
        //
        _couponPriceLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#8A7A6A" font:24];
        [self.contentView addSubview:_couponPriceLb];
        [_couponPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_couponTypeLb.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(_couponTypeLb.mas_centerY);
        }];
        
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"selectbox_sel"] forState:UIControlStateSelected];
        [_selectButton setImage:[UIImage imageNamed:@"selectbox_nor"] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_topBgView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.topBgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        //使用类型
        _desLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [_bottomBgView addSubview:_desLb];
        [_desLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(self.bottomBgView.mas_centerY).mas_offset(-5);
        }];
        
        //使用时间
        _timeLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [_bottomBgView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.desLb.mas_left);
            make.top.mas_equalTo(self.bottomBgView.mas_centerY).mas_offset(5);
        }];
        
    }
    return self;
}

+(instancetype)couponsCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSCouponsCellID";
    KDSCouponsCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
