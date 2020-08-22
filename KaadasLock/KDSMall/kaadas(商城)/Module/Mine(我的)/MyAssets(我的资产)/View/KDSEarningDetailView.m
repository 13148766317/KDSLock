//
//  KDSEarningDetailView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEarningDetailView.h"

@interface KDSEarningDetailView ()

@end

@implementation KDSEarningDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#e6e6e6"];
        
        _labelArray = [NSMutableArray array];
        
//        NSArray * titleArray = @[@"0\n直接收益(元)",@"0\n间接收益(元)",@"0\n介绍收益(元)",@"0\n解锁收益(元)"];
        NSArray * titleArray = @[@"0\n直接收益(元)",@"0\n间接收益(元)",@"0\n介绍收益(元)",@"0\n解锁收益(元)"];
        for (int i = 0; i < titleArray.count; i ++) {
            UILabel * label = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#666666" font:21];
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
            [self addSubview:label];
            [_labelArray addObject:label];
            
            NSString * title = titleArray[i];
            
            if (i < titleArray.count - 1) {
                 label.attributedText = [KDSMallTool attributedString:title dict:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(title.length - 7, 7) lineSpacing:10 alignment:NSTextAlignmentCenter];
            }
           
            
        }
        
    }
    return self;
}


-(void)layoutSubviews{

    int coloum = 2;
    CGFloat labelMargin = 0.6;
    CGFloat labelW = (self.frame.size.width - 1) /2;
    CGFloat labelH = (self.frame.size.height - 1) / 2;
    for (int i = 0; i < _labelArray.count; i++) {
        UILabel * label = (UILabel *)_labelArray[i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0).mas_offset((i / coloum) * (labelH +  labelMargin));
            make.left.mas_equalTo(0).mas_offset((i % coloum) * (labelW + labelMargin));
            make.size.mas_equalTo(CGSizeMake(labelW, labelH));
        }];
    }
    
}



@end
