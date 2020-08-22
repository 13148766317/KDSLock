//
//  KDSMyFootPrintCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyFootPrintCell.h"

@interface KDSMyFootPrintCell ()

 //选中button
@property (nonatomic,strong)UIButton       * selectButton;
//图片
@property (nonatomic,strong)UIImageView    * photoImageView;
//名称
@property (nonatomic,strong)UILabel        * nameLb;
//价格
@property (nonatomic,strong)UILabel        * priceLb;
//购物车图片
@property (nonatomic,strong)UIButton       * shopcartButton;

@property (nonatomic,strong)UIView         * bgView;
@end

@implementation KDSMyFootPrintCell

-(void)setRowModel:(KDSMyCollectRowModel *)rowModel{
    _rowModel = rowModel;
    
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    
    //选中button
    _selectButton.selected = _rowModel.select;
    
     //图片
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    //名称
    _nameLb.text = [KDSMallTool checkISNull:_rowModel.skuName];
    
    //价格
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_rowModel.price]];
     _priceLb.attributedText = [KDSMallTool attributedString:priceStr dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
}

-(void)setRowFootModel:(KDSMyCollectRowModel *)rowFootModel{
    _rowFootModel = rowFootModel;
    
    if ([KDSMallTool checkObjIsNull:_rowFootModel]) {
        return;
    }
    
    //选中button
    _selectButton.selected = _rowFootModel.select;
    
    //图片
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowFootModel.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
    //名称
    _nameLb.text = [KDSMallTool checkISNull:_rowFootModel.name];
    
    //价格
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",[KDSMallTool checkISNull:_rowFootModel.price]];
    _priceLb.attributedText = [KDSMallTool attributedString:priceStr dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //选中button
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"selectbox_nor"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"selectbox_select"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        _bgView = [[UIView alloc]init];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectButton.mas_left);
            make.top.bottom.right.mas_equalTo(self.contentView);
        }];
        
        //图片
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        [_bgView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.photoImageView.mas_height).multipliedBy(1);
        }];

        //名称
        _nameLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [_bgView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.photoImageView.mas_right).mas_offset(20);
            make.top.mas_equalTo(self.photoImageView.mas_top).mas_offset(8);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        }];

        //价格
        _priceLb = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:18];
        [_bgView addSubview:_priceLb];

        [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLb.mas_left);
            make.bottom.mas_equalTo(self.photoImageView.mas_bottom).mas_offset(-8);
        }];

        //购物车图片
        _shopcartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopcartButton addTarget:self action:@selector(shopcartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_shopcartButton setImage:[UIImage imageNamed:@"icon_cart_tracks"] forState:UIControlStateNormal];
        [self.contentView addSubview:_shopcartButton];
        [_shopcartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(self.priceLb.mas_bottom).mas_offset(5);
        }];
        
        //分割线
        UIView * dividing  = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(dividinghHeight);
        }];
    }
    return self;
}

#pragma mark - 购物车点击
-(void)shopcartButtonClick{
    if ([_delegate respondsToSelector:@selector(myFootPrictCellshopCaetButtonClick:)]) {
        [_delegate myFootPrictCellshopCaetButtonClick:_indexPath];
    }
}

-(void)selectButtonClick{
    _selectButton.selected = !_selectButton.selected;
    
    if ([_delegate respondsToSelector:@selector(myFootPrictCellSelectButtonClick:isSelect:)]) {
        [_delegate myFootPrictCellSelectButtonClick:_indexPath  isSelect:_selectButton.selected];
    }
    
}

-(void)setEditState:(BOOL)editState{
    _editState = editState;
    __weak typeof(self)weakSelf = self;
    if (_editState) {
        _selectButton.hidden = NO;
        _shopcartButton.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
             weakSelf.bgView.transform = CGAffineTransformMakeTranslation(30, 0);
        } completion:^(BOOL finished) {}];
    }else{
        _selectButton.hidden = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.bgView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            _shopcartButton.hidden = NO;
        }];
    }
}

+(instancetype)myFootPrintCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMyFootPrintCellID";
    KDSMyFootPrintCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
