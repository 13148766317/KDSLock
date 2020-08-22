//
//  JavaNetClass.h
//  Rent3.0
//
//  Created by Apple on 2018/7/18.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JavaNetClass : NSObject
typedef void (^SuccessRespondBlock)(id responseObject);
//typedef void (^FailRespondBlock)(id responseObject);

+(void)JavaNetRequestWithPort:(NSString *)str andPartemer:(NSDictionary *) dic Success:(SuccessRespondBlock)successResponse;


@end
