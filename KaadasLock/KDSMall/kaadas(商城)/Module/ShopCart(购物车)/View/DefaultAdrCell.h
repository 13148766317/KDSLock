//
//  DefaultAdrCell.h
//  kaadas
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;

@interface DefaultAdrCell : UITableViewCell
@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * addreddLab;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UIImageView * imgv;
@property (nonatomic, strong) UIImageView * imgvR;
@property(nonatomic,strong)DetailModel *detailModel;
@property (nonatomic,assign)BOOL        fillOrder;//填写订单
@end
