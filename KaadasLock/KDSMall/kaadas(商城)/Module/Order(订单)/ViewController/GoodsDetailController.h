//
//  GoodsDetailController.h
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
typedef void (^SelectBlockk)(DetailModel * amodel, NSInteger index);

typedef void (^KDSSelectBlock)(DetailModel * amodel);
@interface GoodsDetailController : UIViewController
@property (nonatomic,assign)KDSProductDetailBottomType      type;
@property(nonatomic,strong)UIView                         * contentView;
@property(nonatomic,strong)NSMutableArray                 * dataArray;

@property (nonatomic, copy)SelectBlockk                     selBlock;
@property (nonatomic,copy)KDSSelectBlock                    selectBlock;
@property(nonatomic,assign)CGFloat                          contentH;
//限购数量
@property (nonatomic,assign)NSInteger                      residueNum;

@end
