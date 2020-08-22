//
//  QZUserArchiveTool.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/27.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZUserArchiveTool.h"
#define USER_INFO_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/userModel.data"]

@implementation QZUserArchiveTool
//获取用户信息
+(QZUserModel *)loadUserModel{
    QZUserModel * userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:USER_INFO_PATH];
    return userModel;
}
//保存用户信息
+(void)saveUserModelWithMode:(QZUserModel *)userModel{
     NSLog(@"保存用户路径:%@",USER_INFO_PATH);
    BOOL issuccess = [NSKeyedArchiver archiveRootObject:userModel toFile:USER_INFO_PATH];
    if (issuccess) {
        NSLog(@"用户信息保存成功");
    }else{
        NSLog(@"用户信息保存失败");
    }
}
//清除用户信息
+(void)clearUserModel{
    QZUserModel * userModel = [[QZUserModel alloc]init];
    [self saveUserModelWithMode:userModel];
}
@end
