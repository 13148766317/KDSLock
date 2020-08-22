//
//  KDSPostSaleCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/25.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPostSaleCell.h"
#import "KDSTextView.h"
#import "BHPhotoBrowser.h"

@interface KDSPostSaleCell ()
<
BHPhotoBrowserDelegate
>
@property (nonatomic,strong)BHPhotoBrowser   * photoBrowser;
@end

@implementation KDSPostSaleCell

#pragma mark - 售后原因选择事件
-(void)topBgButtonClick{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton * topBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [topBgButton addTarget:self action:@selector(topBgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:topBgButton];
        [topBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
        }];
        
        //售后原因
        UILabel * saleReasonLb = [KDSMallTool createLabelString:@"售后原因" textColorString:@"333333" font:15];
        [topBgButton addSubview:saleReasonLb];
        [saleReasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(topBgButton.mas_centerY);
        }];
        
        //右箭头
        UIImageView *rightArrowImageView = [[UIImageView alloc]init];
        [topBgButton  addSubview:rightArrowImageView];
        rightArrowImageView.image = [UIImage imageNamed:@"icon_list_more"];
        [rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(topBgButton.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(7, 12));
        }];
        
        //请选择
        UILabel * chooseLb = [KDSMallTool createLabelString:@"请选择" textColorString:@"999999" font:15];
        [topBgButton addSubview:chooseLb];
        [chooseLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightArrowImageView.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(topBgButton.mas_centerY);
        }];
        
        //分割线
        UIView * topBgLine = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:topBgLine];
        [topBgLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(topBgButton.mas_bottom);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        
        //问题描述
        UILabel * questionDesTitleLb = [KDSMallTool createLabelString:@"问题描述" textColorString:@"333333" font:15];
        [self.contentView addSubview:questionDesTitleLb];
        [questionDesTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topBgLine.mas_left);
            make.top.mas_equalTo(topBgLine.mas_bottom).mas_offset(40);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-300);
        }];
        
        
        //输入框和选择图片背景
        UIView * bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(questionDesTitleLb.mas_left);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(questionDesTitleLb.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(bgView.mas_width).multipliedBy(0.7);
        }];
        
        
        //图片选择器
        //图片
        CGFloat photoMargin = 10;
        CGFloat maxCol = 3;
        CGFloat photoWidth = 70;
        _photoBrowser = [[BHPhotoBrowser alloc]init];
        _photoBrowser.addImage = [UIImage imageNamed:@"icon_camera_add"];
        _photoBrowser.delegate = self;
        _photoBrowser.photosMaxCol = maxCol;
        _photoBrowser.photoMargin = photoMargin;
        _photoBrowser.photoWidth = photoWidth;
        _photoBrowser.photoHeight = photoWidth;
        _photoBrowser.imagesMaxCountWhenWillCompose = 3;
        [bgView  addSubview:_photoBrowser];
        [_photoBrowser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(photoWidth);
        }];
        
        
        KDSTextView * textView = [[KDSTextView alloc]init];
        textView.backgroundColor = [UIColor purpleColor];
        [bgView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(bgView);
            make.bottom.mas_equalTo(self.photoBrowser.mas_top).mas_offset(-10);
        }];
        
    }
    return self;
}
-(void)photoBrowserImageArray:(NSArray *)imageArray{
    
}

+(instancetype)postSaleWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSPostSaleCellID";
    KDSPostSaleCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
