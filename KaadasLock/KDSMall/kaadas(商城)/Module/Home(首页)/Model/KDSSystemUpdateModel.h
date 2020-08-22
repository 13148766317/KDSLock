//
//  KDSSystemUpdateModel.h
//  kaadas
//
//  Created by 中软云 on 2019/8/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSSystemUpdateModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * versionNumber;
@property (nonatomic,copy)NSString      * updateContent;
@property (nonatomic,copy)NSString      * systemType;
@property (nonatomic,copy)NSString      * url;
@property (nonatomic,copy)NSString      * createTime;
@property (nonatomic,copy)NSString      * systemTypeCN;
@end

NS_ASSUME_NONNULL_END
