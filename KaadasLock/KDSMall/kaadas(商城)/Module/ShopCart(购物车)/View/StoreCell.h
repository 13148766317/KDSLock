//
//  StoreCell.h
//  Rent3.0
//
//  Created by Apple on 2018/7/26.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>


//添加代理，用于按钮加减的实现
@protocol StoreCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;


@end

@class StoreModel;
@interface StoreCell : UITableViewCell
@property (nonatomic, strong) UIImageView * picView;
@property (nonatomic, strong) UILabel * topLab;
@property (nonatomic, strong) UILabel * midLab;
@property (nonatomic, strong) UILabel * bottomLab;
@property (nonatomic, strong) UILabel * rightLab;

@property(nonatomic,strong)UIButton *selectBtn;//选中按钮
@property(strong,nonatomic)UIButton *addBtn;//添加商品数量
@property(strong,nonatomic)UIButton *deleteBtn;//删除商品数量
@property(strong,nonatomic)UILabel *numCountLab;//购买商品的数量



@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * descLab;
@property (nonatomic, strong) UILabel * priceLab;



@property(nonatomic ,strong)StoreModel *storeModel;

@property(nonatomic ,weak)id<StoreCellDelegate> delegate;

@end
