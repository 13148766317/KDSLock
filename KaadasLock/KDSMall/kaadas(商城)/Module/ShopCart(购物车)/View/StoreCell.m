//
//  StoreCell.m
//  Rent3.0
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "StoreCell.h"
#import "StoreModel.h"
#define kImageHeight 90

@implementation StoreCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
        [self addSubview:self.selectBtn];
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(30);
            make.left.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.picView = [[UIImageView alloc]init];
        [self addSubview:self.picView];
        self.picView.backgroundColor =KViewBackGroundColor;
        [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.left.mas_equalTo(self).offset(60);
            make.size.mas_equalTo(CGSizeMake(kImageHeight, kImageHeight));
        }];
        
        self.nameLab=[[UILabel alloc]init];
        self.nameLab.font =[UIFont systemFontOfSize:15];
        self.nameLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.nameLab.textAlignment =NSTextAlignmentLeft;
        self.nameLab.numberOfLines = 1;
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(21);
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-25);
        }];
        
        
        self.descLab=[[UILabel alloc]init];
        self.descLab.font =[UIFont systemFontOfSize:12];
        self.descLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
        self.descLab.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.descLab];
        [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(12);
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(12);
        }];
        
        
        self.priceLab=[[UILabel alloc]init];
        self.priceLab.font =[UIFont systemFontOfSize:15];
        self.priceLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.priceLab.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.priceLab];
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.picView.mas_right).mas_offset(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(29);
            make.bottom.mas_equalTo(-27);
        }];

        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.backgroundColor = [UIColor cyanColor];
        self.addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.addBtn.tag = 12;
        [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
        self.addBtn.backgroundColor = KViewBackGroundColor;
        [self.addBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.addBtn];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(18);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        
        
        self.numCountLab = [[UILabel alloc]init];
        self.numCountLab.font = [UIFont systemFontOfSize:15];
        self.numCountLab.textColor =[UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.numCountLab.textAlignment = NSTextAlignmentCenter;
        self.numCountLab.backgroundColor=KViewBackGroundColor;
        [self addSubview: self.numCountLab];
        [self.numCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(18);
            make.right.mas_equalTo(self.addBtn.mas_left).mas_offset(-2);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        

        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setTitle:@"-" forState:UIControlStateNormal];
        self.deleteBtn.tag = 11;
        self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.deleteBtn.backgroundColor = KViewBackGroundColor;
        [self.deleteBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
        [ self.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(18);
            make.right.mas_equalTo(self.numCountLab.mas_left).mas_offset(-2);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
     
        
    }
    return self;
}


-(void)setStoreModel:(StoreModel *)storeModel{

    [self.picView sd_setImageWithURL:[NSURL URLWithString:storeModel.logo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    self.nameLab.text =[NSString stringWithFormat:@"%@" ,storeModel.skuProductName];
    self.descLab.text =[NSString stringWithFormat:@"%@" ,storeModel.attributeComboName];
    
    NSString * price = [NSString stringWithFormat:@"¥%@" ,storeModel.price];
    self.priceLab.attributedText = [KDSMallTool attributedString:price dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
    self.numCountLab.text =[NSString stringWithFormat:@"%ld" ,(long)storeModel.qty];
    
    
    if (storeModel.isSelectState) {
        storeModel.isSelectState = YES;
        [self.selectBtn setImage:[UIImage imageNamed:@"selectbox_select"] forState:UIControlStateNormal];
    }else{
        storeModel.isSelectState = NO;
        [self.selectBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
    }
    
}

/**
 * 点击减按钮实现数量的减少
 *
 * @param sender 减按钮
 */
-(void)deleteBtnAction:(UIButton *)sender
{
    NSLog(@"减少");
    if (self.delegate) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
}

-(void)addBtnAction:(UIButton *)sender
{
    [self.delegate btnClick:self andFlag:(int)sender.tag];
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
