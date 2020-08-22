//
//  RepairController.h
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void (^RepariBlock)(void);

@interface RepairController : BaseDataLoadController
@property(nonatomic,strong)NSString *idStr;
@property(nonatomic,strong)NSString *indentId;
@property(nonatomic,strong)NSDictionary *dataDic;

//@property (nonatomic, copy)RepariBlock repairBlock;

@end
