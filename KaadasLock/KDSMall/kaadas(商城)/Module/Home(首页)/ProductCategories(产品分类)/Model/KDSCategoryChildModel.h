//
//  KDSCategoryChildModel.h
//  kaadas
//
//  Created by Apple on 2019/6/6.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDSCategoryChildModel : NSObject
@property (nonatomic,copy)NSString      * img;
@property (nonatomic,assign)NSInteger     createBy;
@property (nonatomic,copy)NSString      * ID;
@property (nonatomic,assign)NSInteger     seqNo;
@property (nonatomic,copy)NSString      * combination;
@property (nonatomic,copy)NSString      * businessType;
@property (nonatomic,copy)NSString      * createDate;
@property (nonatomic,copy)NSString      * Description;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,assign)NSInteger     pid;

@end
