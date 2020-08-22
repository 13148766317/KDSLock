//
//  KDSHomePageHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/5/27.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomePageHttp.h"
#import "KDSFirstPartModel.h"
#import "KDSSecondPartModel.h"
#import "KDSSearchModel.h"
#import "KDSAllTagModel.h"
#import "KDSProductListModel.h"
//#import "KDSCrowListModel.h"
//#import "KDSGroupListModel.h"
//#import "KDSSeckillListModel.h"
#import "KDSCategoryChildModel.h"
#import "KDSCouponModel.h"
#import "KDSBargainListModel.h"
//#import "KDSBargainDetailModel.h"
//#import "KDSBargainRecordListModel.h"
#import "KDSSystemUpdateModel.h"

@implementation KDSHomePageHttp

#pragma mark - 首页购物车、系统数据
+(void)getShopCartAndSysNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:shopcarGetNumber paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSDictionary * dict = json[@"data"];
            success(YES,dict);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
}

#pragma mark -  1.获取轮播图，视频，分类 
+(void)getFirstPartParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:homeGetFirstPart paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSFirstPartModel * model = [KDSFirstPartModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

#pragma mark - 2.获取灵动系列，推拉系列，活动
+(void)getSecondPartWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:homeGetSecdPart paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSArray * array = [KDSSecondPartModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            success(YES,array);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

#pragma mark - 3.搜索
+(void)getFirstSearchWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getFirstSearch paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
        if (code == 1) {
            KDSSearchModel * model = [KDSSearchModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
    
}
#pragma mark - 获取所有标签
+(void)getAllAllKeyValueWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getAllKeyValue paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSAllTagModel * model = [KDSAllTagModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

#pragma mark - 获取商品列表
+(void)getProductListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getProductList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSProductListModel * model = [KDSProductListModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

#pragma mark - 查询个活动列表 (秒杀 团购 众筹 灵动)
+(void)getFirstAllWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    NSString * type = dict[@"params"][@"type"];
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getFirstAll paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            if ([type isEqualToString:@"product_type_crowd"]) {
//                KDSCrowListModel * model = [KDSCrowListModel mj_objectWithKeyValues:json[@"data"]];
//                success(YES,model);
            }else if ([type isEqualToString:@"product_type_group"]){
//                KDSGroupListModel * model = [KDSGroupListModel mj_objectWithKeyValues:json[@"data"]];
//                success(YES,model);
            }else if ([type isEqualToString:@"product_type_seckill"]){
//                KDSSeckillListModel * model  = [KDSSeckillListModel mj_objectWithKeyValues:json[@"data"]];
//                success(YES,model);
            }else if ([type isEqualToString:@"product_type_bargain"]){
                KDSBargainListModel * model = [KDSBargainListModel mj_objectWithKeyValues:json[@"data"]];
                success(YES,model);
            }else{
                KDSProductListModel  * model  = [KDSProductListModel mj_objectWithKeyValues:json[@"data"]];
                success(YES,model);
            }
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
+(void)getChildListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getcategoryChildList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            NSArray * array = [KDSCategoryChildModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            success(YES,array);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


#pragma mark - 新人券 未登录
+(void)getNotokenCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getNotokenCoupon paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSCouponModel * model = [KDSCouponModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
#pragma mark - 新人券 已登录
+(void)getCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getCoupon paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
             KDSCouponModel * model = [KDSCouponModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//#pragma mark - 砍价详情
//+(void)bargainWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:bargainDetail paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSBargainDetailModel * model = [KDSBargainDetailModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//}

//#pragma mark - 砍价流水 列表
//+(void)getBargainRecordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:bargainRecord paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSBargainRecordListModel * model = [KDSBargainRecordListModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//
//}
//#pragma mark - 发起砍价
//+(void)startBargainRecordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:startBargain paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            success(YES,json);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//}
#pragma mark -  前端获取系统升级
+(void)systemUpgradeAppsuccess:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramDict = @{@"params": @{
                                @"type": @"system_upgrade_type_ios"          //int  类型 ios
                            },
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:systemUpgradeApp paramsDict:paramDict success:^(NSInteger code, id  _Nullable json) {
//        NSLog(@"强制更新%@",json);
        if (code == 1) {
            KDSSystemUpdateModel * model = [KDSSystemUpdateModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

@end
