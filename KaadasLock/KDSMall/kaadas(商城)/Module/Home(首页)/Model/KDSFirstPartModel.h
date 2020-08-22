//
//  KDSFirstPartModel.h
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KDSFirstPartVideoModel,KDSFirstPartBannerModel,KDSFirstPartCategoriesModel;

@interface KDSFirstPartModel : NSObject
@property (nonatomic,strong)KDSFirstPartVideoModel   * vedio;
@property (nonatomic,strong)NSArray  <KDSFirstPartBannerModel *> * banner;
@property (nonatomic,strong)NSArray  <KDSFirstPartCategoriesModel *> * categories;
@end

//视频
@interface KDSFirstPartVideoModel : NSObject
@property (nonatomic,copy)NSString      * logo;
@property (nonatomic,copy)NSString      * url;
@end


//轮播图
@interface KDSFirstPartBannerModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * imgUrl;
@property (nonatomic,copy)NSString      * seriesType;
@property (nonatomic,copy)NSString      * bannerType;
@property (nonatomic,copy)NSString      * seqNo;
@property (nonatomic,copy)NSString      * bannerName;
@property (nonatomic,copy)NSString      * createDate;
@property (nonatomic,copy)NSString      * bannerUrl;
@property (nonatomic,copy)NSString      * bannerTypeCN;
@property (nonatomic,copy)NSString      * bannerUrlCN;
@property (nonatomic,copy)NSString      * imgId;
@property (nonatomic,copy)NSString      * statusCN;
@property (nonatomic,copy)NSString      * status;
@property (nonatomic,copy)NSString      * createBy;

@end


@interface KDSFirstPartCategoriesModel : NSObject
@property (nonatomic,assign)NSInteger     ID;
@property (nonatomic,copy)NSString      * name;
@property (nonatomic,copy)NSString      * img;
@property (nonatomic,copy)NSString      * description_rep;
@end

NS_ASSUME_NONNULL_END
