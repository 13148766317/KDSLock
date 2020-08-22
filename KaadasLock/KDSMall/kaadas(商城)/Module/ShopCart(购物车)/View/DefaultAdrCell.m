//
//  DefaultAdrCell.m
//  kaadas
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "DefaultAdrCell.h"

@implementation DefaultAdrCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        self.nameLab=[[UILabel alloc]init];
        self.nameLab.font =[UIFont boldSystemFontOfSize:15];
        self.nameLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.nameLab.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-25);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(15);
        }];
        
        self.phoneLabel=[[UILabel alloc]init];
        self.phoneLabel.font =[UIFont systemFontOfSize:15];
        self.phoneLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.phoneLabel.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-25);
            make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(150, 15));
        }];
        
        
        self.addreddLab=[[UILabel alloc]init];
        self.addreddLab.font =[UIFont systemFontOfSize:15];
        self.addreddLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.addreddLab.textAlignment =NSTextAlignmentLeft;
        self.addreddLab.numberOfLines =0;
//        self.addreddLab.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.addreddLab];
        self.addreddLab.userInteractionEnabled = NO;
        [self.addreddLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-25);
            make.top.mas_equalTo(self.phoneLabel.mas_bottom).mas_offset(15);
            make.bottom.mas_equalTo(-17);
        }];
        
       
        
        self.imgv= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_address"]];
        [self addSubview:self.imgv];
        [self.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(16, 19));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.imgvR= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_list_more"]];
        [self addSubview:self.imgvR];
        [self.imgvR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(7, 13));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
        
    }
    return self;
}


-(void)setDetailModel:(DetailModel *)detailModel{
    
    self.nameLab.text = [NSString stringWithFormat:@"%@" ,detailModel.transportName];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@" ,detailModel.transportPhone];
    if (_fillOrder) {
        self.addreddLab.text = [NSString stringWithFormat:@"%@%@%@ %@",detailModel.province,detailModel.city,detailModel.area,detailModel.transportAddress];
    }else{
        self.addreddLab.text =  [NSString stringWithFormat:@"%@",detailModel.transportAddress];
    }

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
