//
//  BaseModel.h
//  Rent3.0
//
//  Created by Apple on 2018/5/11.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) NSString *myId;

@end
