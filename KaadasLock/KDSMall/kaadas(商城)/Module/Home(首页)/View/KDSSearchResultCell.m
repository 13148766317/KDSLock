//
//  KDSSearchResultCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSearchResultCell.h"

@interface KDSSearchResultCell ()
//图片
@property (nonatomic,strong)UIImageView   * photoImageView;
//产品名称
@property (nonatomic,strong)UILabel       * productLabel;
//价格
@property (nonatomic,strong)UILabel       * priceLabel;

@end

@implementation KDSSearchResultCell

-(void)setRowModel:(KDSSearchRowModel *)rowModel {
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_rowModel.logo]]];
    [_photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_h]];
    
    //产品名称
    _productLabel.text = [KDSMallTool checkISNull:_rowModel.name];
    
    //价格
    NSString * priceString = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_rowModel.price]];
    
    _priceLabel.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, 1) lineSpacing:0];
}

-(void)setListRowModel:(KDSProductListRowModel *)listRowModel{
    _listRowModel = listRowModel;
    if ([KDSMallTool checkObjIsNull:_listRowModel]) {
        return;
    }
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_listRowModel.logo]]];
    [_photoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_h]];

    //产品名称
    _productLabel.text = [KDSMallTool checkISNull:_listRowModel.name];
    
    //价格
    NSString * priceString = [NSString stringWithFormat:@"￥%@",_listRowModel.price];
    _priceLabel.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, 1) lineSpacing:0];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        [self.contentView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(90);
            make.width.mas_equalTo(self.photoImageView.mas_height);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-20).priorityLow();
        }];
        
        //产品名称
        _productLabel = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:18];
        _productLabel.numberOfLines = 2;
        [self.contentView addSubview:_productLabel];
        [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.photoImageView.mas_right).mas_offset(20);
            make.top.mas_equalTo(self.photoImageView.mas_top).mas_equalTo(3);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        }];
        
        //价格
        _priceLabel = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productLabel.mas_left);
            make.bottom.mas_equalTo(self.photoImageView.mas_bottom).mas_offset(-3);
        }];
        
        //分割线
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];

    }
    return self;
}


+(instancetype)searchResultCellWithTableView:(UITableView *)tableView{
    
    static NSString * cellID = @"KDSSearchResultCellID";
    KDSSearchResultCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
    
}


@end
