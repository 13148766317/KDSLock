//
//  ReasonCell.m
//  kaadas
//
//  Created by Apple on 2019/6/20.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "ReasonCell.h"

@implementation ReasonCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"问题描述";
        lab.font =[UIFont systemFontOfSize:15];
        lab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        lab.textAlignment =NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(15);
        }];
        
        self.backV = [[UIView alloc]init];
        self.backV.backgroundColor= [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];;
        [self addSubview:self.backV];
        [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(60);
            make.bottom.mas_equalTo(-20);
        }];
  
        self.resonLab=[[UILabel alloc]init];
        self.resonLab.font =[UIFont systemFontOfSize:15];
        self.resonLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.resonLab.textAlignment =NSTextAlignmentLeft;
        self.resonLab.numberOfLines = 0;
        [self.backV addSubview:self.resonLab];
        [self.resonLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lab.mas_bottom).mas_offset(35);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-25);
        }];
        
        UIImageView *lastImg;
        for (int i = 0; i < 3; i ++) {
            UIImageView *aimgv= [[UIImageView alloc]init];
            aimgv.userInteractionEnabled = YES;
            aimgv.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#E6E6E6"];
            aimgv.tag = 1000+i;
            [self.backV addSubview:aimgv];
            lastImg = aimgv;
            [aimgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.resonLab.mas_bottom).mas_offset(37);
                make.left.mas_equalTo(15+85*i);
                make.size.mas_equalTo(CGSizeMake(60, 60));
                
                if (i == 2) {
                    make.bottom.mas_equalTo(-15);
                }
            }];
        }
    
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
