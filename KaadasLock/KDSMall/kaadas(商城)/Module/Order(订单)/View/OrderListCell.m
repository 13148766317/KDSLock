//
//  NewOrderListCell.m
//  rent
//
//  Created by David on 2017/8/8.
//  Copyright © 2017年 whb. All rights reserved.
//

#import "OrderListCell.h"
#import "DetailModel.h"
#define kImageHeight 80
@implementation OrderListCell


-(void)setDetailModel:(DetailModel *)detailModel{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:detailModel.logo] placeholderImage:[UIImage imageNamed:@"图片占位"]];

    self.nameLab.text =[NSString stringWithFormat:@"%@" ,detailModel.productName];
    self.descLab.text = [NSString stringWithFormat:@"%@" ,detailModel.productLabels];
    self.countLab.text =[NSString stringWithFormat:@"x %@" ,detailModel.qty];

    NSString *priceS=[NSString stringWithFormat:@"¥%@" ,detailModel.price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    self.priceLab.attributedText = AttributedStr;

    if ([_indentStatus isEqualToString:@"indent_status_wait_comment"] || [_indentStatus isEqualToString:@"indent_status_completed"] || [_indentStatus isEqualToString:@"indent_status_wait_install"] || [_indentStatus isEqualToString:@"indent_status_wait_refund"] || [_indentStatus isEqualToString:@"indent_status_refunded"]) {
        _rightButton.hidden = NO;
        [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(90, 33));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];
        
        NSString * status = [KDSMallTool checkISNull:detailModel.status];
        
        if ([_indentStatus isEqualToString:@"indent_status_wait_comment"] || [_indentStatus isEqualToString:@"indent_status_completed"]) {//待评论 完成
            _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"].CGColor;
            [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#FFFFFF"] forState:UIControlStateNormal];
           
            if ([status isEqualToString:@"indent_info_status_after_underway"]) {
                _rightButton.enabled = NO;
                [_rightButton setTitle:@"售后处理中" forState:UIControlStateNormal];
                _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
                _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
                [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
                _rightButton.layer.borderWidth = 1;
                
            }else if([status isEqualToString:@"indent_info_status_after_complete"]){
                [_rightButton setTitle:@"售后完成" forState:UIControlStateNormal];
                _rightButton.enabled = NO;
                 _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
            }else if ([status isEqualToString:@"indent_info_status_refund_of"]){
                _rightButton.enabled = NO;
                [_rightButton setTitle:@"退款中" forState:UIControlStateNormal];
                 _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
                 _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
                 [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
                 _rightButton.layer.borderWidth = 1;
                
            }else if ([status isEqualToString:@"indent_info_status_refund_to_complete"]){
                _rightButton.enabled = NO;
                [_rightButton setTitle:@"退款完成" forState:UIControlStateNormal];
                 _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
                
            }else{
                _rightButton.enabled = YES;
                [_rightButton setTitle:@"申请售后" forState:UIControlStateNormal];
                _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
                _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
                [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
                _rightButton.layer.borderWidth = 1;
            }
            
        }else if ([_indentStatus isEqualToString:@"indent_status_wait_install"] || [_indentStatus isEqualToString:@"indent_status_wait_refund"] || [_indentStatus isEqualToString:@"indent_status_refunded"]){//待安装 待退款
            _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"].CGColor;
            [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#FFFFFF"] forState:UIControlStateNormal];
            if ([_indentType isEqualToString:@"indent_type_base"]) {//普通商品
                if ([status isEqualToString:@"indent_info_status_refund_of"]){
                    _rightButton.enabled = NO;
                    [_rightButton setTitle:@"退款中" forState:UIControlStateNormal];
                     _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
                     _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
                     [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
                     _rightButton.layer.borderWidth = 1;
                }else if ([status isEqualToString:@"indent_info_status_refund_to_complete"]){
                    _rightButton.enabled = NO;
                    [_rightButton setTitle:@"退款完成" forState:UIControlStateNormal];
                     _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
                }else{
                    _rightButton.enabled = YES;
                    [_rightButton setTitle:@"申请退款" forState:UIControlStateNormal];
                    _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
                    _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
                    [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
                    _rightButton.layer.borderWidth = 1;
                }
            }else{
                _rightButton.hidden = YES;
                [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(0);
                    make.size.mas_equalTo(CGSizeMake(90, 0));
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
                }];
            }
        }
        
    }else{
        _rightButton.hidden = YES;
        [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(90, 0));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];
    }
    
}

-(void)setOrderStatus:(NSString *)orderStatus{
    _orderStatus = orderStatus;
    
    _rightButton.hidden = NO;
    [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 33));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
    }];
    
    if ([_orderStatus isEqualToString:@"indent_info_status_after_underway"]) {
        _rightButton.enabled = NO;
        [_rightButton setTitle:@"售后处理中" forState:UIControlStateNormal];
         _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
         _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
         [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
         _rightButton.layer.borderWidth = 1;
        
    }else if([_orderStatus isEqualToString:@"indent_info_status_after_complete"]){
        [_rightButton setTitle:@"售后完成" forState:UIControlStateNormal];
        _rightButton.enabled = NO;
         _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
    } else  if ([_orderStatus isEqualToString:@"indent_info_status_refund_of"]){
        _rightButton.enabled = NO;
        [_rightButton setTitle:@"退款中" forState:UIControlStateNormal];
         _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FFFFFF"];
         _rightButton.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
         [_rightButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
         _rightButton.layer.borderWidth = 1;
        
    }else if ([_orderStatus isEqualToString:@"indent_info_status_refund_to_complete"]){
        _rightButton.enabled = NO;
        [_rightButton setTitle:@"退款完成" forState:UIControlStateNormal];
         _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
    }

}

#pragma mark -

-(void)rightButtonClick{
    NSString * buttonTitle = [_rightButton titleForState:UIControlStateNormal];
    
    OrderListButtonType  type = -1;
    if ([buttonTitle isEqualToString:@"申请退款"]) {
        type  = OrderListButton_refund;
    }else if ([buttonTitle isEqualToString:@"申请售后"]){
        type = OrderListButton_afterSales;
    }
    if ([_delegate respondsToSelector:@selector(orderListRightButtonClick:buttonType:)]) {
        [_delegate orderListRightButtonClick:_indexPath buttonType:type];
    }
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.picView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.picView];
        self.picView.backgroundColor =KViewBackGroundColor;
        [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(kImageHeight, kImageHeight));
        }];
        
        self.nameLab=[[UILabel alloc]init];
        //        self.nameLab.backgroundColor = [UIColor redColor];
        self.nameLab.font =[UIFont systemFontOfSize:16];
        self.nameLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.nameLab.textAlignment =NSTextAlignmentLeft;
        self.nameLab.numberOfLines = 2;
        [self.contentView addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(21);
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-25);
        }];

        self.descLab=[[UILabel alloc]init];
        self.descLab.font =[UIFont systemFontOfSize:12];
        self.descLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
        self.descLab.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.descLab];
        [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(15);
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(12);
        }];

        self.priceLab=[[UILabel alloc]init];
        self.priceLab.font =[UIFont systemFontOfSize:15];
        self.priceLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.priceLab.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:self.priceLab];
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(20);
//            make.bottom.mas_equalTo(-17);
        }];


        self.countLab=[[UILabel alloc]init];
        self.countLab.font =[UIFont systemFontOfSize:14];
        self.countLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.countLab.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:self.countLab];
        [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.priceLab.mas_top);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        
         _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#BBEOFF"];
        [_rightButton setTitle:@"" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_rightButton];
        _rightButton.layer.cornerRadius = 33 / 2;
        _rightButton.layer.masksToBounds = YES;
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.countLab.mas_bottom).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(90, 33));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15).priorityLow();
        }];

    }
    return self;
}

@end
