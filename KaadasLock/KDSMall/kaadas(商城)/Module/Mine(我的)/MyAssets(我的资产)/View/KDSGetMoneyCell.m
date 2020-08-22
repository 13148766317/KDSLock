//
//  KDSGetMoneyCell.m
//  kaadas
//
//  Created by 中软云 on 2019/6/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSGetMoneyCell.h"

@interface KDSGetMoneyCell ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField   * textField;
//可提现金额
@property (nonatomic,strong)UILabel       * myMoneyLb;

@property (nonatomic,strong)UILabel       * bindTitleLb;

@property (nonatomic,strong)UILabel       * detailLb;
@property (nonatomic,strong)UILabel       * bankCardLb;

@end

@implementation KDSGetMoneyCell

-(void)setDesModel:(KDSWithdrawalDesModel *)desModel{
    _desModel = desModel;
    
    //可提现金额
    NSString * balanceStr = @"";
    if ([KDSMallTool checkISNull:_desModel.balance].length <= 0) {
        balanceStr = @"0";
    }else{
        balanceStr = [KDSMallTool checkISNull:_desModel.balance];
    }
    _myMoneyLb.text = [NSString stringWithFormat:@"可提现金额%@元",balanceStr];
    
    
    //提现到银行卡
    NSString * bankCardString = @"";
    if ([KDSMallTool checkISNull:_desModel.bankcard].length <= 0) {
        bankCardString = @"";
    }else{
        bankCardString = [KDSMallTool checkISNull:_desModel.bankcard];
    }
    //银行卡号
    _bankCardLb.text =  bankCardString;
    
    
   //提现说明
    _detailLb.text = [KDSMallTool checkISNull:_desModel.remark];
    
}
#pragma mark - 绑定到银行卡事件点击
-(void)bindBgButtonClick{
    if ([_delegate respondsToSelector:@selector(bindBankCardBgButtonClick)]) {
        [_delegate bindBankCardBgButtonClick];
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //顶部分割
        UIView * topLine = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:topLine];
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(15);
        }];
        
        //提取金额
        UILabel * getMoneyTitleLb = [KDSMallTool createLabelString:@"提取金额" textColorString:@"#333333" font:15];
        [self.contentView addSubview:getMoneyTitleLb];
        [getMoneyTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(30);
        }];
        
        //人民币符号
        UILabel *  symbolLb = [KDSMallTool createLabelString:@"￥" textColorString:@"#333333" font:30];
        [self.contentView addSubview:symbolLb];
        [symbolLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getMoneyTitleLb.mas_left);
            make.top.mas_equalTo(getMoneyTitleLb.mas_bottom).mas_offset(35);
            make.width.mas_equalTo(30);
        }];
        
        //金额输入框
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.placeholder = @"输入金额";
        _textField.textColor= [UIColor hx_colorWithHexRGBAString:@"#333333"];
        _textField.keyboardType =  UIKeyboardTypeDecimalPad;
        _textField.font = [UIFont boldSystemFontOfSize:30];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(symbolLb.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(symbolLb.mas_centerY);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(40);
        }];
        
        //输入框底部的分割线
        UIView * textfieldLine = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:textfieldLine];
        [textfieldLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(symbolLb.mas_left);
            make.right.mas_equalTo(self.textField.mas_right);
            make.top.mas_equalTo(self.textField.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //可提现金额
        _myMoneyLb = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        [self.contentView addSubview:_myMoneyLb];
        [_myMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getMoneyTitleLb.mas_left);
            make.top.mas_equalTo(self.textField.mas_bottom).mas_offset(18);
        }];
        
        //
        UIView * secondLine = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:secondLine];
        [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.myMoneyLb.mas_bottom).mas_offset(18);
            make.height.mas_equalTo(15);
           
        }];
        
        UIButton * bindBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bindBgButton addTarget:self action:@selector(bindBgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        bindBgButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:bindBgButton];
        [bindBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(secondLine.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        
        _bindTitleLb = [KDSMallTool createLabelString:@"提现到银行卡" textColorString:@"#333333" font:15];
        [bindBgButton addSubview:_bindTitleLb];
        [_bindTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(bindBgButton.mas_centerY);
        }];
        
        //
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [bindBgButton addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(bindBgButton.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(8, 8 * 25 / 14));
        }];
        
        //银行卡号
        _bankCardLb = [KDSMallTool createLabelString:@"" textColorString:@"333333" font:15];
        [bindBgButton addSubview:_bankCardLb];
        [_bankCardLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bindBgButton.mas_centerY);
            make.right.mas_equalTo(arrowImageView.mas_left).mas_offset(-10);
        }];
        
        
        UIView * detailBgView = [[UIView alloc]init];
        detailBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [self.contentView addSubview:detailBgView];

        //本月可提现2次，单笔提现手续费2元+0.8%
        _detailLb =  [KDSMallTool createLabelString:@"" textColorString:@"#CA2128" font:12];
        [detailBgView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(detailBgView.mas_bottom).mas_offset(-15);
        }];


        [detailBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(bindBgButton.mas_bottom);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0).priorityLow();
        }];
    }
    return self;
}

-(NSString *)text{
    if ([KDSMallTool checkISNull:_textField.text].length <= 0) {
        return @"";
    }else{
        return [KDSMallTool checkISNull:_textField.text];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toString.length > 0) {
        NSInteger dightNum = 3;
        NSString *stringRegex = [NSString stringWithFormat:@"([1-9]\\d{0,%ld})?",dightNum];
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:toString];
        if (!flag) {
            return NO;
        }else{
            if ([toString doubleValue] > pow(10, dightNum)) {
                return NO;
            }else{
                return YES;
            }
        }
    }
    
    return YES;
}

+(instancetype)getMoneyCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSGetMoneyCellID";
    KDSGetMoneyCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
