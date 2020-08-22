//
//  KDSProductDetailNormalCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailNormalCell.h"
#import "KDSPreferentialView.h"

@interface KDSProductDetailNormalCell ()
//产品名称
@property (nonatomic,strong)UILabel   * productNameLb;
//现价
@property (nonatomic,strong)UILabel   * nowPrictLb;
//原价格
@property (nonatomic,strong)UILabel   * oldPriceLb;
//月销量
@property (nonatomic,strong)UILabel   * monthlySalesLb;
//优惠详情控件
@property (nonatomic,strong)KDSPreferentialView   * preferentialView;
@end

@implementation KDSProductDetailNormalCell


-(void)setDetailModel:(KDSProductDetailModel *)detailModel{
    _detailModel = detailModel;
    if ([KDSMallTool checkObjIsNull:_detailModel]) {
        return;
    }
    
    //产品名称
    _productNameLb.text = [KDSMallTool checkISNull:_detailModel.name];
    //现价
    NSString * nowPriceStr = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_detailModel.price]];
    _nowPrictLb.attributedText = [KDSMallTool attributedString:nowPriceStr dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, 1) lineSpacing:0];
    //原价
    _oldPriceLb.text = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_detailModel.oldPrice]];
    
    //月销量
    _monthlySalesLb.text = [NSString stringWithFormat:@"月销    %ld件",(long)_detailModel.countNum];
}
-(void)setProductName:(NSString *)productName{
    _productName = productName;
    //产品名称
    _productNameLb.text = [KDSMallTool checkISNull:_productName];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        //产品名称
        _productNameLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:15];
        _productNameLb.numberOfLines = 2;
        [self.contentView addSubview:_productNameLb];
        [_productNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        }];
        
        //现价
        _nowPrictLb = [KDSMallTool createLabelString:@"" textColorString:@"#ca2128" font:21];
        [self.contentView addSubview:_nowPrictLb];
        [_nowPrictLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLb).mas_offset(-3);
            make.top.mas_equalTo(self.productNameLb.mas_bottom).mas_offset(20);
        }];
        
        //原价
        _oldPriceLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_oldPriceLb];
        [_oldPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nowPrictLb.mas_right).mas_offset(20);
            make.bottom.mas_equalTo(self.nowPrictLb.mas_bottom).mas_offset(-2);
        }];
        
        //原价分割线
        UIView * priceLine = [KDSMallTool createDividingLineWithColorstring:@"#999999"];
        [_oldPriceLb addSubview:priceLine];
        [priceLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.oldPriceLb);
            make.centerY.mas_equalTo(self.oldPriceLb.mas_centerY);
            make.height.mas_equalTo(1);
        }];
        
        //月销量
        _monthlySalesLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_monthlySalesLb];
        [_monthlySalesLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-13);
            make.top.mas_equalTo(self.oldPriceLb.mas_top).mas_offset(0);
        }];
        
        //优惠详情
        _preferentialView = [[KDSPreferentialView alloc]init];
        [_preferentialView.getPreferentialButton addTarget:self action:@selector(preferentialButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_preferentialView];
        [_preferentialView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.monthlySalesLb.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(0);
        }];
        
        _preferentialView.hidden = YES;
        
        //底部分割线
        UIView * boldDividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:boldDividing];
        [boldDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.preferentialView.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(15);
            make.left.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0).priorityLow();
        }];
    }
    return self;
}
#pragma mark - 领券 事件点击
-(void)preferentialButtonClick{
    if ([_delegate respondsToSelector:@selector(productDetailPreferentialButtonClick)]) {
        [_delegate productDetailPreferentialButtonClick];
    }
}
+(instancetype)productDetailNormalCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductDetailNormalCellID";
    KDSProductDetailNormalCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
