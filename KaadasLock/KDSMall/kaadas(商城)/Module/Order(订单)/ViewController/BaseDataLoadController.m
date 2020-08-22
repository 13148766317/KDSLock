//
//  BaseDataLoadController.m
//  shop
//
//  Created by zjf on 15/12/4.
//  Copyright © 2015年 whb. All rights reserved.
//

#import "BaseDataLoadController.h"
//#import "LoginController.h"
//#import "MBProgressHUD+MJ.h"
//#import "TabBarController.h"
//#import "AppDelegate.h"
#import "KDSProgressHUD.h"
#define alertMsg  @"msg"  //服务器提示语

#import "KDSLoginViewController.h"

@implementation BaseDataLoadController
{

    UIView *backView;
    UIView *coverView;
    UIView *submitView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingViewFrame=self.view.frame;
    self.loadState=firstLoad;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.loadState==firstLoad||self.dataState==DataLoadFail||self.dataState==NoNetWork){
        [self loadData:firstLoad];
    }
}

-(void)loadData:(LoadState)loadState{
}

-(void)reloadData{
    
    [self loadData:firstLoad];
}


-(void)submitDataWithBlock:(NSString *)postUrl partemer:(NSDictionary *)dic Success:(SuccessRespondBlock)successResponse{
    
    [self setSubmitAnimation];
    __weak __typeof(self) weakSelf = self;
    [JavaNetClass JavaNetRequestWithPort:postUrl andPartemer:dic Success:^(id responseObject) {
        [weakSelf setSbmitResult];
        [self loginTimeDeal:responseObject];
        NSString *msg=responseObject[alertMsg];
        if(!msg){
            if([weakSelf isSuccessData:responseObject]){
                msg = @"";
            }else{
                msg=@"加载失败";
            }
        }
        if([weakSelf isSuccessData:responseObject]){
//            [weakSelf showToastSuccess:msg];  //暂时注释
        }
        else {
            [weakSelf showToastError:msg];
        }
        if(successResponse){
            successResponse(responseObject);
        }
        
    }];
    
}

-(void)setSubmitAnimation{
    
    [KDSProgressHUD showHUDTitle:@"加载中..." toView:self.view];
 
}

-(void)setSbmitResult{
    [KDSProgressHUD hideHUDtoView:self.view animated:YES];
    [submitView removeFromSuperview];
    submitView = nil;
}


-(void)loadDataWithBlock:(LoadState)loadState url:(NSString *)postUrl partemer:(NSDictionary *)dic Success:(SuccessRespondBlock)successResponse{
    
    if (loadState == firstLoad) {
        [self setLoadAnimation];
    }
    __weak __typeof(self) weakSelf = self;
    
    [JavaNetClass JavaNetRequestWithPort:postUrl andPartemer:dic Success:^(id responseObject) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [self loginTimeDeal:responseObject];
        [weakSelf setLoadResult:responseObject];
        NSString *msg=responseObject[alertMsg];
        NSInteger  codeNum = [responseObject[@"code"] integerValue];
        if(!msg){
            if([weakSelf isSuccessData:responseObject]){
                msg = @"";
            }else{
                msg=@"加载失败";
            }
        }
        if(![weakSelf isSuccessData:responseObject]){
            if(![weakSelf isEmptyData:responseObject]){
                NSLog(@"msg----:%@",msg);
                [weakSelf showToastError:msg];
                if (codeNum == 21) {
                    if ([HelperTool shareInstance].isUnToken) {
                        return;
                    }
                    //清空用户信息和token
                    [QZUserArchiveTool clearUserModel];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [HelperTool shareInstance].isUnToken = YES;
                    KDSTabBarController * tableBarVC = [HelperTool shareInstance].tableBarVC;
//                    WxLoginController * loginVC = [[WxLoginController alloc]init];
                    KDSLoginViewController * loginVC = [[KDSLoginViewController alloc]init];

                    KDSMallNC * nav = [[KDSMallNC alloc]initWithRootViewController:loginVC];
                    [tableBarVC presentViewController:nav animated:YES completion:^{}];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [HelperTool shareInstance].isUnToken = NO;
                    });
                }
            }
        }else{
            if(successResponse){
                successResponse(responseObject);
            }
        }
    }];
    
    
}

-(void)setLoadAnimation{

    if(self.loadingView!=nil){
        [self.loadingView removeFromSuperview];
    }
    self.loadingView=[[UIView alloc]initWithFrame:self.loadingViewFrame];
    self.loadingView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.loadingView];
    
    [KDSProgressHUD showHUDTitle:@"加载中" toView:self.view];

}

-(void)setLoadResult:(id) responseObject{
    
    if(self.loadingView!=nil){
        [self.loadingView removeFromSuperview];
    }
    self.loadState = loadComplete;
    DataState dataState=DataLoadFail;
    
    if ([self isSuccessData:responseObject]) {
        //NSLog(@"responseObjectle==%@" ,NSStringFromClass([responseObject class]));
        id aObject =responseObject[@"data"];
        
        if ([aObject isKindOfClass:[NSArray class]]) {
            NSArray *array=responseObject[@"data"];
            if(array.count>0) {
                dataState=DataLoadSuccess;
            } else {
                dataState=DataLoadEmpty;
            }
        }
        
        if ([aObject isKindOfClass:[NSString class]]) {
            NSString *astring =responseObject[@"data"];
            if (astring.length >0) {
                dataState=DataLoadSuccess;
            }else{
                dataState=DataLoadEmpty;
            }
        }
        
        if ([aObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *adic =responseObject[@"data"];
            if (adic >0) {
                dataState=DataLoadSuccess;
                NSString *total = [NSString stringWithFormat:@"%@" ,adic[@"total"]];
                if ([total isEqualToString:@"0"]) {
                    dataState=DataLoadEmpty;
                }
            }else{
                dataState=DataLoadEmpty;
            }
        }
        
    }
    else if([self isLoginTimeOut:responseObject]){
        dataState=DataLoadSuccess;
    }
    else if([self isEmptyData:responseObject]){
        dataState=DataLoadEmpty;
    }
    else if([self isNoNtework:responseObject]){
        dataState=NoNetWork;
    }
    else{
        dataState=DataLoadFail;
    }
    
 
    if(dataState ==DataLoadSuccess){
    }else if(dataState ==DataLoadEmpty){
        [self setEmptyView];
    }else if(dataState ==NoNetWork){
        [self stepNoNetWorkView];
    } else {
        NSLog(@"未知错误");
        [self stepFailView];
    }

    self.dataState=dataState;

}


-(void)setEmptyView{
    [self setDefaultView:contents_missing_pages alertLable:@"" reloadData:NO];
    
}
-(void)stepFailView{
    [self setDefaultView:loading_missing_pages alertLable:@"" reloadData:YES];
}
-(void)stepNoNetWorkView{
    [self setDefaultView:network_missing_pages alertLable:@"" reloadData:YES];
}
//-(void)setDefaultView:(NSString *)imagePath alertLable:(NSString *)txt reloadData:(BOOL)isReload{
//    
//    if(self.loadingView!=nil){
//        [self.loadingView removeFromSuperview];
//    }
//    self.loadingView=[[UIControl alloc]initWithFrame:self.loadingViewFrame];
//    self.loadingView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:self.loadingView];
//
//    
//    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imagePath ]];
//    [image setCenter:CGPointMake(self.loadingView.frame.size.width / 2, self.loadingView.frame.size.height / 3+20)];
//    [self.loadingView addSubview:image];
//    
//    
//    
//    UILabel *lable=[[UILabel alloc]init];
//    lable.text=txt;
//    lable.textColor=[UIColor blackColor];
//    lable.font= [UIFont systemFontOfSize:13];
//    [self.loadingView addSubview:lable];
//    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(image.mas_bottom).offset(20);
//        make.left.mas_equalTo(self.loadingView.mas_left);
//        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 20));
//    }];
//    
//    if(isReload){
//        [((UIControl *)self.loadingView) addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
//    }
//}

-(void)setDefaultView:(NSString *)imagePath alertLable:(NSString *)txt reloadData:(BOOL)isReload{
    
    if(self.loadingView!=nil){
        [self.loadingView removeFromSuperview];
    }
    self.loadingView=[[UIControl alloc]initWithFrame:self.loadingViewFrame];
    self.loadingView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.loadingView];
//
//
//    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imagePath ]];
//    image.frame = CGRectMake(0, 0, 100, 100);
//    [image setCenter:CGPointMake(self.loadingView.frame.size.width / 2, self.loadingView.frame.size.height / 3)];
//    [self.loadingView addSubview:image];
//
//    UILabel *lable=[[UILabel alloc]init];
//    lable.text=txt;
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.font= [UIFont systemFontOfSize:13];
//    lable.frame = CGRectMake(0, CGRectGetMaxY(image.frame)+15, KSCREENWIDTH, 15);
////    [lable setCenter:CGPointMake(self.loadingView.frame.size.width / 2, self.loadingView.frame.size.height / 3 +15)];
//
////    lable.top=image.bottom+20;
////    lable.left=self.loadingView.width/2-lable.width/2;
//    [self.loadingView addSubview:lable];
    [self.emptyButton setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
     self.emptyButton.frame = CGRectMake(0, 150, KSCREENWIDTH, KSCREENHEIGHT * 0.3);
    [self.emptyButton setTitle:txt forState:UIControlStateNormal];
    [self.loadingView addSubview:self.emptyButton];
    if(isReload){
        [((UIControl *)self.loadingView) addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    }
}



-(void)showToastSuccess:(NSString *)msg{
    [KDSProgressHUD showSuccess:msg toView:self.view completion:^{
        
    }];
}

-(void)showToastError:(NSString *)msg{
    [KDSProgressHUD showFailure:msg toView:self.view completion:^{
        
    }];
}


-(Boolean)isSuccessData:(id)responseObject{
    NSString *errCode=[NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"1"]; 
}

-(Boolean)isEmptyData:(id)responseObject{
    NSString *errCode=[NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"S1000"];
}
-(Boolean)isNoNtework:(id)responseObject{
    NSString *errCode=[NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"-1009"];
}

-(Boolean)isLoginTimeOut:(id)responseObject{
    
    NSString *errCode= [NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"1001"]; 
  
}

-(Boolean)isRandWrong:(id)responseObject{
    NSString *errCode=[NSString stringWithFormat:@"%@", responseObject[@"code"]];
    return [errCode isEqualToString:@"E0025"];
}


-(void)loginTimeDeal:(id)responseObject{
    if ([self isLoginTimeOut:responseObject]) {
        NSLog(@"登录超时");
//        [self showToastError:@"登录超时,请重新登录"];
//        LoginController *myloginVC= [[LoginController alloc]init];
//        myloginVC.hideRightItem = @"隐藏";
//        myloginVC.loginSuccessBlock = ^{
//            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            TabBarController *tabbar=  [[TabBarController alloc] init];
//            appDelegate.window.rootViewController = tabbar;
//            tabbar.selectedIndex = 0;
//        };
//        UINavigationController *navc =[[UINavigationController alloc]initWithRootViewController:myloginVC];
//        navc.modalPresentationStyle =UIModalTransitionStyleCoverVertical;
//        [self presentViewController:navc animated:YES completion:^{
//
//        }];
//        return;
    }
}






@end
