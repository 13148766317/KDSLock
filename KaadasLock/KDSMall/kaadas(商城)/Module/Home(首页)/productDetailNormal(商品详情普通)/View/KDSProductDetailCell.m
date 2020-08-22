//
//  KDSProductDetailCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/22.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailCell.h"

@interface KDSProductDetailCell ()


@end

@implementation KDSProductDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleToFill;
        _photoImageView.clipsToBounds = YES;
        [self.contentView addSubview:_photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
//            make.height.mas_equalTo(KSCREENWIDTH * 1.5);
        }];

    }
    return self;
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
//        [self.contentView addSubview:self.btn];
//        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.contentView);
//        }];
//
//
//    }
//    return self;
//}
//
//- (UIButton *)btn {
//    if (nil == _btn) {
//        _btn = [[UIButton alloc] init];
////        _btn.titleLabel.font = kFT3;
//        _btn.userInteractionEnabled = NO;
//    }
//    return _btn;
//}

+(instancetype)productDetailCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductDetailCellID";
    KDSProductDetailCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
