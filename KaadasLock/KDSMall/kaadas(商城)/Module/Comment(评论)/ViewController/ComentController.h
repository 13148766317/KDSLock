//
//  ComentController.h
//  kaadas
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ComentBlock)(void);

@interface ComentController : BaseDataLoadController
@property(nonatomic,strong)NSMutableArray *indeInfoArr;
@property (nonatomic, copy)ComentBlock comentBlock;

@end
