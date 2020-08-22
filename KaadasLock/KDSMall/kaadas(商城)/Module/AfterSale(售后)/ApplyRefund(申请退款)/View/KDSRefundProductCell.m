//
//  KDSRefundProductCell.m
//  kaadas
//
//  Created by 中软云 on 2019/8/2.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSRefundProductCell.h"

@interface KDSRefundProductCell ()
//图片
@property (nonatomic,strong)UIImageView   * productImageView;
//商品名称
@property (nonatomic,strong)UILabel       * productNameLB;
//商品类型
@property (nonatomic,strong)UILabel       * productTypeLb;
//价格
@property (nonatomic,strong)UILabel       * priceLb;
//购买个数
@property (nonatomic,strong)UILabel       * buyCountLb;
@end

@implementation KDSRefundProductCell

-(void)setInfoDict:(NSDictionary *)infoDict{
    _infoDict = infoDict;
    
    //图片
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_infoDict[@"logo"]]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    //商品名称
    _productNameLB.text = [KDSMallTool checkISNull:_infoDict[@"productName"]];
    
    _productTypeLb.text = [KDSMallTool checkISNull:_infoDict[@"productLabels"]];
    
    //价格
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_infoDict[@"price"]]];
    _priceLb.attributedText = [KDSMallTool attributedString:priceStr dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
    
    //购买个数
    _buyCountLb.text = [NSString stringWithFormat:@"x%@",[KDSMallTool checkISNull:_infoDict[@"qty"]]];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //图片
        _productImageView = [[UIImageView alloc]init];
        _productImageView.image = [UIImage imageNamed:placeholder_wh];
        [self.contentView addSubview:_productImageView];
        [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(90, 90));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];
        
        //商品名称
        _productNameLB = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_productNameLB];
        [_productNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImageView.mas_right).mas_offset(20);
            make.top.mas_equalTo(self.productImageView.mas_top).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        }];
        
        _productTypeLb = [KDSMallTool createLabelString:@"" textColorString:@"666666" font:12];
        [self.contentView addSubview:_productTypeLb];
        [_productTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLB.mas_left);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        //价格
        _priceLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:15];
        [self.contentView addSubview:_priceLb];
        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLB.mas_left);
            make.bottom.mas_equalTo(self.productImageView.mas_bottom).mas_offset(-0);
        }];
        
        //购买个数
        _buyCountLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:12];
        [self.contentView addSubview:_buyCountLb];
        [_buyCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.productNameLB.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.priceLb.mas_bottom);
        }];
        
    }
    return self;
}

+(instancetype)refundProductCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSRefundProductCellID";
    KDSRefundProductCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
