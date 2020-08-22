//
//  KDSDiscountCouponCell.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSDiscountCouponCell.h"


@interface KDSDiscountCouponCell ()
@property(nonatomic,strong)UIView * topBGview;
@property(nonatomic,strong)UIView * bottomBgView;
//劵类型label
@property(nonatomic,strong)UILabel * couponsTypeLB;
//折扣label
@property(nonatomic,strong)UILabel * discountLB;
//去使用
@property(nonatomic,strong)JXLayoutButton * useButton;
//已过期imageview
@property(nonatomic,strong)UIImageView * overdueImageView;
//劵使用范围label
@property(nonatomic,strong)UILabel * useRangeLB;
@property(nonatomic,strong)UILabel * validityLb;

@end

@implementation KDSDiscountCouponCell

-(void)setRowModel:(KDSMyCouponRowModel *)rowModel{
    _rowModel = rowModel;
    
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //劵类型label
    _couponsTypeLB.text = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_rowModel.couponTypeCN]];
    
    //折扣label
    if (_overdue) {//已过期
        _discountLB.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
        _discountLB.attributedText = [KDSMallTool attributedString:[NSString stringWithFormat:@"￥%@",_rowModel.couponValue] dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, 1) lineSpacing:0];
    }else{//未过期
        _discountLB.textColor = [UIColor hx_colorWithHexRGBAString:@"#8A7A6A"];
         _discountLB.attributedText = [KDSMallTool attributedString:[NSString stringWithFormat:@"￥%@",_rowModel.couponValue] dict:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, 1) lineSpacing:0];
    }
   
    
    //劵使用范围label
    _useRangeLB.text = [NSString stringWithFormat:@"满%@减%@",_rowModel.couponCondition,_rowModel.couponValue];
    
    //使用时间范围
    _validityLb.text = [NSString stringWithFormat:@"有效期：%@ 至 %@",_rowModel.startDate,_rowModel.expirationDate];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _topBGview = [[UIView alloc]init];
        _topBGview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView  addSubview:_topBGview];
        [_topBGview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(60);
        }];
        
        
        //劵类型label
        _couponsTypeLB  = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#8A7A6A" font:12];
        _couponsTypeLB.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _couponsTypeLB.textAlignment = NSTextAlignmentCenter;
        _couponsTypeLB.layer.cornerRadius = 3;
        _couponsTypeLB.layer.masksToBounds = YES;
        [_topBGview addSubview:_couponsTypeLB];
        [_couponsTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.topBGview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 25));
        }];
        
        //折扣label
        _discountLB = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:24];
        [_topBGview addSubview:_discountLB];
        [_discountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.couponsTypeLB.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(self.couponsTypeLB.mas_centerY);
        }];
        
        //去使用
        _useButton = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
        _useButton.hidden = YES;
        _useButton.midSpacing = 8;
        _useButton.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
        [_useButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#ca2128"] forState:UIControlStateNormal];
        _useButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_useButton setImage:[UIImage imageNamed:@"icon_more_coupon"] forState:UIControlStateNormal];
        [_useButton setTitle:@"去使用" forState:UIControlStateNormal];
        [_useButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_topBGview addSubview:_useButton];
        [_useButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.couponsTypeLB.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //已过期imageview
        _overdueImageView = [[UIImageView alloc]init];
        _overdueImageView.image = [UIImage imageNamed:@"pic_coupon_expired"];
        _overdueImageView.hidden = YES;
        [_topBGview addSubview:_overdueImageView];
        [_overdueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(self.overdueImageView.mas_height);
        }];
        
        
        _bottomBgView = [[UIView alloc]init];
        _bottomBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:_bottomBgView];
        [_bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topBGview.mas_bottom);
            make.left.mas_equalTo(self.topBGview.mas_left);
            make.right.mas_equalTo(self.topBGview.mas_right);
            make.height.mas_equalTo(self.topBGview.mas_height);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];

    
        //劵使用范围label
        _useRangeLB = [KDSMallTool createLabelString:@"" textColorString:@"666666" font:12];
        [_bottomBgView addSubview:_useRangeLB];
        [_useRangeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(self.bottomBgView.mas_centerY).mas_offset(-5);
            make.right.mas_equalTo(-15);
        }];
        
        _validityLb = [KDSMallTool createLabelString:@"" textColorString:@"666666" font:12];
        [_bottomBgView addSubview:_validityLb];
        [_validityLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.useRangeLB.mas_left);
            make.top.mas_equalTo(self.bottomBgView.mas_centerY).mas_offset(5);
            make.right.mas_equalTo(-15);
        }];
        
        
    }
    return self;
}

#pragma mark - 去使用点击事件
-(void)userButtonClick{
    if ([_delegate respondsToSelector:@selector(discountCouponCellUserButtonClickIndexPath:)]) {
        [_delegate discountCouponCellUserButtonClickIndexPath:_indexPath];
    }
}


-(void)setOverdue:(BOOL)overdue{
    _overdue = overdue;
    if (_overdue) {//过期
        _useButton.hidden = YES;
        _overdueImageView.hidden = NO;
        _topBGview.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#e6e6e6"];
          _couponsTypeLB.textColor  = [UIColor hx_colorWithHexRGBAString:@"#999999"];
    }else{
        _useButton.hidden = NO;
        _overdueImageView.hidden = YES;
        _topBGview.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F6EDE3"];
        _couponsTypeLB.textColor  = [UIColor hx_colorWithHexRGBAString:@"#8A7A6A"];
    }
}

+(instancetype)discountCouponCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSDiscountCouponCellID";
    KDSDiscountCouponCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
