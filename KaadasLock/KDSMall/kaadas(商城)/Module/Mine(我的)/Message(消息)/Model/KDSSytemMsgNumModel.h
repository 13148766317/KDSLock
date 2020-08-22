//
//  KDSSytemMsgNumModel.h
//  kaadas
//
//  Created by 中软云 on 2019/6/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSSytemMsgNumModel : NSObject
@property (nonatomic,assign)NSInteger     number;
@property (nonatomic,copy)NSString      * title;
@property (nonatomic,copy)NSString      * messageType;

@end

NS_ASSUME_NONNULL_END
