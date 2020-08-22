//
//  FootView.m
//  kaadas
//
//  Created by Apple on 2019/6/4.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "FootView.h"

@implementation FootView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithReuseIdentifier:reuseIdentifier] ) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        self.priceLab =[[UILabel alloc]init];
        self.priceLab.textAlignment = NSTextAlignmentRight;
        self.priceLab.font = [UIFont systemFontOfSize:12];
        self.priceLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        [self addSubview:self.priceLab];

        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(20);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 15));
            
        }];
        
        self.rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
        [ self.rightBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview: self.rightBtn];
        self.rightBtn.layer.cornerRadius = 33 / 2;
        self.rightBtn.layer.masksToBounds = YES;
        [ self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-20);
            make.size.mas_equalTo(CGSizeMake(90, 33));
        }];
        
        self.leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.leftBtn];
        self.leftBtn.layer.cornerRadius = 33 /2;
        self.leftBtn.layer.borderWidth = 1;
        self.leftBtn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"].CGColor;
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-10);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-20);
            make.size.mas_equalTo(CGSizeMake(90, 33));
        }];
        
    }
    return self;
    
    
}

@end
