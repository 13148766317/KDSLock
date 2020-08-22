//
//  QZUserArchiveTool.h
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/27.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QZUserArchiveTool : NSObject{
    QZUserModel * userModel;
}
//获取用户信息
+(QZUserModel *)loadUserModel;
//保存用户信息
+(void)saveUserModelWithMode:(QZUserModel *)userModel;
//清除用户信息
+(void)clearUserModel;


@end

NS_ASSUME_NONNULL_END
