//
//  BaseModel.m
//  Rent3.0
//
//  Created by Apple on 2018/5/11.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        self.myId = value;
    }
}


+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"myId":@"id"};
}

@end
