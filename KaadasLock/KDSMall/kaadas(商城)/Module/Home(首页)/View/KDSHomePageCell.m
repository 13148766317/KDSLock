//
//  KDSHomePageCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomePageCell.h"
#import "KDSMoreProductButton.h"

@interface KDSHomePageCell ()
@property (nonatomic,strong)NSMutableArray   * productArray;
//大图
@property (nonatomic,strong)UIImageView      * bigImageView;

@end

@implementation KDSHomePageCell

-(void)setCategoryArray:(NSArray *)categoryArray{
    _categoryArray = categoryArray;
    
    for (int i = 0; i < 2; i++) {
        KDSFirstPartCategoriesModel * model = _categoryArray[i];
        UIButton * button = (UIButton *)_productArray[i];
        //标题
        UILabel * titleLb = [button viewWithTag:100 + i];
        titleLb.text = [KDSMallTool checkISNull:model.name];
        //描述
        UILabel * destailLb = [button viewWithTag:200 + i];
        destailLb.text = [KDSMallTool checkISNull:model.description_rep];

        //图片
        UIImageView  * imageView = [button viewWithTag:300 + i];
        NSURL * imageuRL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:model.img]]];
        [imageView sd_setImageWithURL:imageuRL placeholderImage:[UIImage imageNamed:placeholder_wh]];
    }
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        
        
//        CGFloat topMargin        = 5;
//        CGFloat itemButtonMargin = 5;
//        CGFloat itemWidth        = (KSCREENWIDTH- itemButtonMargin )/ 2.0;
//
//        _productArray = [NSMutableArray array];
//        for (int i = 0; i < 2; i++) {
//            UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            itemButton.backgroundColor = [UIColor redColor];
//            itemButton.tag = i;
//            itemButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
//            [self.contentView addSubview:itemButton];
//            [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//            UILabel * titleLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"333333" font:21];
//            titleLb.tag = 100 + i;
//            [itemButton addSubview:titleLb];
//            [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(33);
//                make.centerX.mas_equalTo(itemButton.mas_centerX);
//            }];
//
//            UILabel * destailLB = [KDSMallTool createLabelString:@"" textColorString:@"#8a7a6a" font:12];
//            destailLB.tag = 200 + i;
//            destailLB.textAlignment = NSTextAlignmentCenter;
//            [itemButton addSubview:destailLB];
//            [destailLB mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(titleLb.mas_bottom).mas_offset(15);
//               make.left.mas_equalTo(0);
//                make.right.mas_equalTo(0);
//            }];
//
//            UIImageView *  pictureImageView = [[UIImageView alloc]init];
//            pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
//            pictureImageView.clipsToBounds = YES;
//            pictureImageView.tag = 300 + i;
//            [itemButton addSubview:pictureImageView];
//            [pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(destailLB.mas_bottom).mas_offset(11);
//                make.left.mas_equalTo(15);
//                make.right.mas_equalTo(-15);
//                make.height.mas_equalTo(pictureImageView.mas_width);
//                make.bottom.mas_equalTo(itemButton.mas_bottom).mas_offset(-15);
//            }];
//            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(0).mas_offset(i * (itemButtonMargin + itemWidth));
//                make.top.mas_equalTo(topMargin);
//                make.width.mas_equalTo(itemWidth);
//                make.bottom.mas_equalTo(pictureImageView.mas_bottom).mas_offset(20).priorityLow();
//
//            }];
//
//            [_productArray addObject:itemButton];
//        }
//
//        //更多产品
//        UIButton * firstItemButton = [_productArray firstObject];
//        KDSMoreProductButton * moreButton = [KDSMoreProductButton buttonWithType:UIButtonTypeCustom];
//        [moreButton setTitle:@"更多产品 >" forState:UIControlStateNormal];
//        [moreButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
//        moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:moreButton];
//        moreButton.hidden = YES;
//        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.top.mas_equalTo(firstItemButton.mas_bottom).mas_equalTo(5);
//            make.height.mas_equalTo(0);
//
//        }];
        
        //大图
         _bigImageView = [[UIImageView alloc]init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bigImageView.clipsToBounds = YES;
        _bigImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        [self.contentView addSubview:_bigImageView];
        [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(moreButton.mas_bottom).mas_offset(10);
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        _bigImageView.hidden = YES;
        _bigImageView.image = [UIImage imageNamed:@"banner_home"];
        
    }
    return self;
}


#pragma mark - itemButton 点击事件
-(void)itemButtonClick:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(homePageCellItemButtonClick:)]) {
        [_delegate homePageCellItemButtonClick:button.tag];
    }
}

#pragma mark - 更多产品点击事件
-(void)moreButtonClick{
    if ([_delegate respondsToSelector:@selector(homePageCellMoreButtonClick)]) {
        [_delegate homePageCellMoreButtonClick];
    }
}

+(instancetype)homePageCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSHomePageCellID";
    KDSHomePageCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
