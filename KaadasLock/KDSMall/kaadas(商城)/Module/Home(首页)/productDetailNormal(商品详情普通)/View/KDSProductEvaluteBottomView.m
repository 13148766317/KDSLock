//
//  KDSProductEvaluteBottomView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductEvaluteBottomView.h"

@interface KDSProductEvaluteBottomView ()
//浏览量
@property(nonatomic,strong)UILabel  * visitCountLabel;
@property(nonatomic,strong)NSMutableArray * buttonArray;
@end

@implementation KDSProductEvaluteBottomView
-(void)buttonClick:(UIButton *)button{
    KDSProductEvaluateButtonType buttonType = -1;
    switch (button.tag) {
        case 0:{//点赞
            buttonType = KDSProductEvaluate_like;
        }
            break;
            
        case 1:{//评论
            buttonType = KDSProductEvaluate_evaluate;
        }
            break;
            
            
        default:
            break;
    }
    
    if (buttonType < 0) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(productEvaluateBottemViewButtonClick:)]) {
        [_delegate productEvaluateBottemViewButtonClick:buttonType];
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _buttonArray = [NSMutableArray array];
        
        //浏览量 @"浏览0次"
        _visitCountLabel = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self addSubview:_visitCountLabel];
        [_visitCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
        CGFloat buttonW = 70;
        CGFloat buttonH = 30;
        CGFloat buttonMarign = 3;
        NSArray * titleImageArray = @[@"icon_thumbup_appraisal",@"icon_judge_appraisal"];
        for (int i = 0; i < titleImageArray.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setTitle:@"0" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#999999"] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:titleImageArray[i]] forState:UIControlStateNormal];
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
                make.right.mas_equalTo(-16).mas_offset(i * -(buttonW + buttonMarign));
                make.centerY.mas_equalTo(self.visitCountLabel.mas_centerY);
            }];
            
            [_buttonArray addObject:button];
        }
        
    }
    return self;
}

@end
