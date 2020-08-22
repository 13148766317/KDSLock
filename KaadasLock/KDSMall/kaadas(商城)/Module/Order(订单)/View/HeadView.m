//
//  HeadView.m
//  kaadas
//
//  Created by Apple on 2019/6/4.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithReuseIdentifier:reuseIdentifier] ) {
        
        self.orderNoLab=[[UILabel alloc]init];
        self.orderNoLab.backgroundColor =[UIColor whiteColor];
        self.orderNoLab.textColor = [UIColor  hx_colorWithHexRGBAString:@"#666666"];
        self.orderNoLab.font = [UIFont systemFontOfSize:15];
        self.orderNoLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.orderNoLab];
        [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).mas_offset(15);
            make.height.mas_equalTo(50);
        }];
        
        self.imgv = [[UIImageView alloc]init];
        [self addSubview:self.imgv];
        self.imgv.image = [UIImage imageNamed:@"icon_order"];
        [self.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(15+16);
            make.size.mas_equalTo(CGSizeMake(15, 17));
        }];
        
        self.stateLab =[[UILabel alloc]init];
        self.stateLab.textColor = [UIColor  hx_colorWithHexRGBAString:@"#ca2128"];
        self.stateLab.font = [UIFont systemFontOfSize:12];
        self.stateLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.stateLab];
        [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(15);
            make.height.mas_equalTo(50);
        }];
        
    }
    return self;

       
}


@end
