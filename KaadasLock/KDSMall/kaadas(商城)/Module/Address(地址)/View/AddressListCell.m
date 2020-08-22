//
//  AddressListCell.m
//  rent
//
//  Created by David on 16/5/9.
//  Copyright © 2016年 whb. All rights reserved.
//

#import "AddressListCell.h"
#import "DetailModel.h"
@implementation AddressListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.nameLabel=[[UILabel alloc]init];
        self.nameLabel.font =[UIFont systemFontOfSize:15];
        self.nameLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        self.nameLabel.textAlignment =NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        self.nameLabel.text =@"的点点滴滴说的方所多付";
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH/2, 15));
        }];
        self.phoneLabel=[[UILabel alloc]init];
        self.phoneLabel.font =[UIFont systemFontOfSize:15];
        self.phoneLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.phoneLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:self.phoneLabel];
        self.phoneLabel.text =@"13277098261";
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH/2, 15));
        }];

        self.addressLabel=[[UILabel alloc]init];
        self.addressLabel.font =[UIFont systemFontOfSize:13];
        self.addressLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
        self.addressLabel.textAlignment =NSTextAlignmentLeft;
        self.addressLabel.numberOfLines = 0;
        [self addSubview:self.addressLabel];
        self.addressLabel.text =@"";
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(12);
            make.bottom.mas_equalTo(-17);
        }];
     
        
    }
    return self;
}

-(void)setDetailModel:(KDSAddressListRowModel *)detailModel{
    _detailModel = detailModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@" ,detailModel.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@" ,detailModel.phone];
    self.addressLabel.text =[NSString stringWithFormat:@"%@%@%@ %@",detailModel.province,detailModel.city,detailModel.area,detailModel.address];

    
    
//    NSMutableArray *arr = [self arrayWithJsonString:detailModel.areaCode];
//    NSString *finalStr=@"";
//    for (NSDictionary *dic in arr) {
//        NSString *aname = [NSString stringWithFormat:@"%@" ,dic[@"name"]];
//        finalStr = [NSString stringWithFormat:@"%@ %@",finalStr, aname];
//    }
//    self.addressLabel.text =[NSString stringWithFormat:@"%@ %@" ,finalStr ,detailModel.address];;

    
}



-(NSMutableArray *)arrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}


@end
