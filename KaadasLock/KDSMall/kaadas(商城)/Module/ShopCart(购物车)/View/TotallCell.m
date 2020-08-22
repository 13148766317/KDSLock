//
//  TotallCell.m
//  kaadas
//
//  Created by Apple on 2019/5/18.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "TotallCell.h"

@implementation TotallCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.leftLab=[[UILabel alloc]init];
        self.leftLab.font =[UIFont systemFontOfSize:15];
        self.leftLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.leftLab.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.leftLab];
        self.leftLab.text =@"的点点";
        [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        
        


        self.rightField=[[UITextField alloc]init];
        self.rightField.font =[UIFont systemFontOfSize:15];
        self.rightField.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.rightField.textAlignment =NSTextAlignmentRight;
        [self addSubview:self.rightField];
        self.rightField.userInteractionEnabled = NO;
        [self.rightField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(120);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        
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
