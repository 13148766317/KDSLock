//
//  KDSHomeProgressView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeProgressView.h"

@interface KDSHomeProgressView ()
//支持人数
@property (nonatomic,strong)UILabel   * titleLb;
//百分比
@property (nonatomic,strong)UILabel   * percentLb;
//进度背景
@property (nonatomic,strong)UIView    * bgProgressView;
//进度
@property (nonatomic,strong)UIView    * progressView;
@end

@implementation KDSHomeProgressView

- (void)setRowModel:(KDSSecondPartRowModel *)rowModel{
    _rowModel = rowModel;
    
    //支持人数
    NSString * titleString = [NSString stringWithFormat:@"%ld人支持",_rowModel.saleQty];
    NSMutableAttributedString * titleAttribut = [[NSMutableAttributedString alloc]initWithString:titleString];
    [titleAttribut addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#333333"] range:NSMakeRange(0, [KDSMallTool checkISNull:[NSString stringWithFormat:@"%ld",_rowModel.purchaseNumber]].length)];
    
    _titleLb.attributedText = titleAttribut;
    
    //百分比
    _percentLb.text = [NSString stringWithFormat:@"%@%%",_rowModel.percentage];
    
    //进度条
    [_progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgProgressView.mas_left);
        make.top.mas_equalTo(self.bgProgressView.mas_top);
        make.height.mas_equalTo(self.bgProgressView.mas_height);
//        make.width.mas_equalTo(self.bgProgressView.mas_width).multipliedBy((CGFloat)self.rowModel.purchaseNumber / (CGFloat) self.rowModel.count);
        make.width.mas_equalTo(self.bgProgressView.mas_width).multipliedBy([self->_rowModel.percentage floatValue]);
    }];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        //支持人数
        _titleLb = [KDSMallTool createLabelString:@"0人支持" textColorString:@"999999" font:12];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        
        //百分比
        _percentLb = [KDSMallTool createLabelString:@"0%" textColorString:@"#333333" font:12];
        [self addSubview:_percentLb];
        [_percentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        
        //进度背景
        _bgProgressView = [KDSMallTool createDividingLineWithColorstring:@"#e6e6e6"];
        [self addSubview:_bgProgressView];
        [_bgProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(3);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        //进度条
        _progressView = [KDSMallTool createDividingLineWithColorstring:@"#1F96F7"];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgProgressView.mas_left);
            make.top.mas_equalTo(self.bgProgressView.mas_top);
            make.height.mas_equalTo(self.bgProgressView.mas_height);
            make.width.mas_equalTo(self.bgProgressView.mas_width).multipliedBy(0.0);
        }];
        
    }
    return self;
}

@end
