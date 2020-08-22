//
//  QZUserModel.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/26.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "QZUserModel.h"
#import <objc/runtime.h>

@implementation QZUserModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        unsigned int count = 0;
        //成员变量属性
        Ivar * ivars = class_copyIvarList([QZUserModel class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            //利用kvc赋值
            if (value) {
                [self setValue:value forKey:key];
            }
            
        }
        //释放内存
        free(ivars);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([QZUserModel class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    //释放内存
    free(ivars);
}



@end


