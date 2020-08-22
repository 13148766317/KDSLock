//
//  AddressModel.h
//  kaadas
//
//  Created by Apple on 2019/5/20.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSString *code;
@end
