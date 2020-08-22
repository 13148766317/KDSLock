//
//  OrderListController.h
//  kaadas
//
//  Created by Apple on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListController : BaseDataLoadController
@property(nonatomic ,assign)NSInteger selectIndex;
//从该页面返回是否回到rootViewController
@property (nonatomic,assign)BOOL      backPopToRoot;
@end
