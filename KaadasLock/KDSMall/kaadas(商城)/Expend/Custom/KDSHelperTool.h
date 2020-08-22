//
//  QZHelpTool.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/4/8.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDSTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KDSHelperTool : NSObject
@property (nonatomic,strong)KDSTabBarController   * tableBarVC;
//是否token失效
@property (nonatomic,assign)BOOL     isUnToken;

@property (nonatomic,strong)NSString * classUrl;


@property (nonatomic,strong)id noteData;

@property (nonatomic,strong)id lessionData;
@property (nonatomic,strong)NSMutableArray* lessionArr;


+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
