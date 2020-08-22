//
//  KDSOnlineServiceModel.h
//  kaadas
//
//  Created by 中软云 on 2019/7/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSOnlineServiceModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * phone;
@property (nonatomic,copy)NSString      * qq;
@property (nonatomic,copy)NSString      * email;
@property (nonatomic,copy)NSString      * wxUrl;
@end

NS_ASSUME_NONNULL_END
