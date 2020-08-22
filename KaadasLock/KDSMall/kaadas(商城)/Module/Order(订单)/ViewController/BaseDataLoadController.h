//
//  BaseDataLoadController.h
//  shop
//
//  Created by zjf on 15/12/4.
//  Copyright © 2015年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseController.h"
#import "JavaNetClass.h"
#import "KDSBaseController.h"
@interface BaseDataLoadController : KDSBaseController

#pragma mark - 加载 操作
typedef enum {
    DataFirstLoading = 0,
    DataSubmiting,
    DataLoadSuccess,
    DataLoadEmpty,
    DataLoadFail,
    NoNetWork
} DataState;

#pragma mark - 刷新 操作
typedef enum {
    firstLoad = 0,
    refreshData,
    loadMore,
    loadComplete
} LoadState;


typedef void (^SureRespondBlock)(void);
typedef void (^CancelRespondBlock)(void);

@property(nonatomic,strong)UIView *loadingView;
@property(nonatomic)CGRect loadingViewFrame;
@property (nonatomic,strong) CAShapeLayer *loadingLayer;

@property(nonatomic)LoadState loadState;
@property(nonatomic)DataState dataState;



-(void)loadData:(LoadState)loadState;


-(void)reloadData;


-(void)loadDataWithBlock:(LoadState)loadState url:(NSString *)postUrl partemer:(NSDictionary *)dic Success:(SuccessRespondBlock)successResponse;


-(void)submitDataWithBlock:(NSString *)postUrl partemer:(NSDictionary *)dic Success:(SuccessRespondBlock)successResponse;





-(void)setSubmitAnimation;
-(void)setSbmitResult;
-(void)setLoadAnimation;


-(Boolean)isSuccessData:(id)responseObject;
-(Boolean)isEmptyData:(id)responseObject;
-(Boolean)isNoNtework:(id)responseObject;
-(Boolean)isLoginTimeOut:(id)responseObject;
-(Boolean)isRandWrong:(id)responseObject;




-(void)showToastSuccess:(NSString *)msg;
-(void)showToastError:(NSString *)msg;

////弹出选择按钮
//-(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message andCancleMessage:(NSString *)message1 andSUreMessage:(NSString *)message2 sureBlock:(SureRespondBlock)sure cancelBlock:(CancelRespondBlock)cancel;




#pragma mark 设置空数据空态图
-(void)setEmptyView;



-(void)setDefaultView:(NSString *)imagePath alertLable:(NSString *)txt reloadData:(BOOL)isReload;





@end
