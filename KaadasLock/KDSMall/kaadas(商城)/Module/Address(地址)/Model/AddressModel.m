//
//  AddressModel.m
//  kaadas
//
//  Created by Apple on 2019/5/20.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //    NSLog(@"没有的值为%@" ,key);
    if([key isEqualToString:@"id"]){
        self.code = value;
    }
}
@end
