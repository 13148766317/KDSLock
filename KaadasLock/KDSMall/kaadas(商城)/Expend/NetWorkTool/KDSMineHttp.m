//
//  KDSMineHttp.m
//  kaadas
//
//  Created by 中软云 on 2019/5/29.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMineHttp.h"
//#import "KDSNearShopModel.h"
#import "KDSMyCollectListModel.h"
#import "KDSFootPrintListModel.h"
//#import "KDSShopDetailModel.h"
//#import "KDSMyPostListModel.h"
#import "KDSMyAssetsModel.h"
#import "KDSMyAssetsDetailModel.h"
#import "KDSEarningDetailModel.h"
#import "KDSMyTeamModel.h"
#import "KDSMyTaskOnGoingmodel.h"
#import "KDSmyTaskFinishModel.h"
#import "KDSMyCouponModel.h"
//#import "KDSMyReplyModel.h"
#import "KDSOnlineServiceModel.h"
#import "KDSIntergralDetailModel.h"
//#import "KDSMyBargainListModel.h"

@implementation KDSMineHttp

//获取用户个人信息接口
+(void)mineInfoWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:mineInfo paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            QZUserModel * userModel = [QZUserModel mj_objectWithKeyValues:json[@"data"]];
            [QZUserArchiveTool saveUserModelWithMode:userModel];
            success(YES,userModel);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//获取验证码
+(void)getCodeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getCode paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


//修改用户信息
+(void)updateUserInfoWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure getInfo:(void (^)(BOOL isSuccess))getInfo{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:updateUserInfo paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
            NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
            NSDictionary * dictionary = @{
                                          @"params":@{},
                                          @"token":[KDSMallTool checkISNull:userToken]
                                          };
            [self mineInfoWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
                if (isSuccess) {
                    getInfo(isSuccess);
                }
            } failure:^(NSError * _Nonnull error) {
                    
            }];
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//设置密码
+(void)setPassWordWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:setPwd paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
        if (code == 1) {
            NSString * token = json[@"data"][@"token"];
            if (token) {
                //保存token
                [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//绑定微信
+(void)bingWechatWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:bingWechat paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//绑定手机号
+(void)bingPhoneNumberWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:bingPhoneNumber paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//绑定邀请码
+(void)binginviteCodeWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:bingInviteCode paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//获取我的帖子分页列表
+(void)myInvitationPageWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myInvitationPage paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSMyPostListModel * model = [KDSMyPostListModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
}

//获取我的帖子的回复分页列表
+(void)invitationReplyPageWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:invitationReplyPage paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSMyReplyModel * model = [KDSMyReplyModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
}

//我的收藏 列表
+(void)myCollectionListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myCollectAppList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        
        if (code == 1) {
            KDSMyCollectListModel * model = [KDSMyCollectListModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//批量取消收藏
+(void)cancelCollectByIdsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:cancelCollectByIds paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的足迹 列表
+(void)myFootPrintListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    KDSFootPrintListModel
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myFootPrintList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSFootPrintListModel * model = [KDSFootPrintListModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//删除足迹
+(void)deleteFootPrintWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:deleteFootPrint paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

////门店获取分页列表
//+(void)shopAppListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:shopAppPageList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSNearShopModel * model = [KDSNearShopModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//}
//
////门店详情
//+(void)shopAppDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:shopAppDetail paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSShopDetailModel * model = [KDSShopDetailModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//}

//提交反馈
+(void)feedbackSaveWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:feedbackSave paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


//我的资产
+(void)myAssetsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myAssets paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyAssetsModel * model = [KDSMyAssetsModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的资产详情
+(void)myAssetsDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myAssetsDetail paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyAssetsDetailModel * model = [KDSMyAssetsDetailModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的团队
+(void)myTeamWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myTeam paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyTeamModel * model = [KDSMyTeamModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//收益明细
+(void)earnDetailsWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:earnDetails paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSEarningDetailModel * model = [KDSEarningDetailModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的团队人数
+(void)myTeamCountWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myTeamCount paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的任务（进行时）
+(void)myTaskongoingWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myTaskongoing paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyTaskOnGoingmodel * model = [KDSMyTaskOnGoingmodel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//我的任务（完成时）
+(void)myTaskCompleteWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:myTaskcomplete paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSmyTaskFinishModel  * model = [KDSmyTaskFinishModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//用户激活优惠券
+(void)activationCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:activationCoupon paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            success(YES,json);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
    
}

//获取我的优惠券
+(void)getMyCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getMyCoupon paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyCouponModel * model = [KDSMyCouponModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//获取过期的优惠券
+(void)getMyPastDueCouponWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getMyPastDueCoupon paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSMyCouponModel * model = [KDSMyCouponModel mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//在线客服服务
+(void)onlineServiceWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:onlineService paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code ==1) {
            KDSOnlineServiceModel * model = [KDSOnlineServiceModel mj_objectWithKeyValues:json[@"data"]];
            
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

//积分明细
+(void)interfralDetailWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:intergralDetail paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            KDSIntergralDetailModel * model = [KDSIntergralDetailModel  mj_objectWithKeyValues:json[@"data"]];
            success(YES,model);
        }else{
            success(NO,json[@"msg"]);
        }
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

////我发起的砍价列表
//+(void)myBargainListWithParams:(NSDictionary *)dict success:(void (^)(BOOL isSuccess, id obj))success failure:(void (^)(NSError *error))failure{
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:getMyBargainList paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            KDSMyBargainListModel * model = [KDSMyBargainListModel mj_objectWithKeyValues:json[@"data"]];
//            success(YES,model);
//        }else{
//            success(NO,json[@"msg"]);
//        }
//        
//    } failure:^(NSError * _Nullable error) {
//        failure(error);
//    }];
//}


@end
