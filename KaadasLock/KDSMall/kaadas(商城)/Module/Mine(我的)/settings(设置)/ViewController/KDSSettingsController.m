//
//  KDSSettingsController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSettingsController.h"
#import "KDSSettingsCell.h"
#import "QZAccountLoginController.h"
#import "KDSRegisterLoginHttp.h"
#import "AddressController.h"
#import "QZClearCacheTool.h"
#import "KDSOnlineServiceController.h"

@interface KDSSettingsController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)NSMutableArray   * titleArray;
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,assign)NSInteger          cacheSize;
@end

@implementation KDSSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI{
    //设置title
    self.navigationBarView.backTitle = @"设置";
    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取缓存的大小
    [self getTotalCacheSize];
}
#pragma mark - 获取缓存大小
-(void)getTotalCacheSize{
    //沙盒路径
    _cacheSize = 0;
    //获取Caches路径
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    //获取视频缓存的大小
//    _cacheSize += [QZClearCacheTool getCacheSizeWithFilePath:[cachePath stringByAppendingPathComponent:@"video"]];
    //获取图片缓存的大小
    _cacheSize += [QZClearCacheTool getCacheSizeWithFilePath:[cachePath stringByAppendingPathComponent:@"com.hackemist.SDImageCache/default"]];
    //
    [self.tableView reloadData];
    
}

#pragma mark - 清理缓存
-(void)clearCacheData{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString * videoPath = [cachePath stringByAppendingPathComponent:@"video"];
//    [QZClearCacheTool clearCacheWithFilePath:videoPath];
    NSString * imageCachePath = [cachePath stringByAppendingPathComponent:@"com.hackemist.SDImageCache/default"];
    [QZClearCacheTool clearCacheWithFilePath:imageCachePath];
    _cacheSize = 0;
    
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = self.titleArray[section];
    
    return  array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    KDSSettingsCell * cell = [KDSSettingsCell settingsCellWithTableView:tableView];
    NSArray * array = self.titleArray[indexPath.section];
    cell.titleString = array[indexPath.row];
    if (indexPath.section == (self.titleArray.count - 1)) {
        cell.hiddenArrow = YES;
    }else{
        cell.hiddenArrow = NO;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            cell.isClear = YES;
            cell.cacheSize = _cacheSize;
        }else{
            cell.isClear = NO;
        }
    }else{
        cell.isClear = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AddressController * addressVC = [[AddressController alloc]init];
            [self.navigationController pushViewController:addressVC animated:YES];
        }else if (indexPath.row == 1){
            [self clearCacheData];
            [KDSProgressHUD showTextOnly:@"清除完成" toView:self.view completion:^{
                
            }];
        }
//        if (indexPath.row == 0) {//个人信息
//
//        }else if (indexPath.row ==1){//意见反馈
//
//        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//关于我们
            WebViewController * webView = [[WebViewController alloc]init];
            webView.url = [NSString stringWithFormat:@"%@aboutUs",webBaseUrl];;
            webView.title = @"关于我们";
            webView.rightButtonHidden = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }else{
            KDSOnlineServiceController * onlineServiceVC = [[KDSOnlineServiceController alloc]init];
            [self.navigationController pushViewController:onlineServiceVC animated:YES];
        }
      
    }else if (indexPath.section == 2){
//        if (indexPath.row == 0) {//关于我们
//
//        }else if (indexPath.row == 1){//联系客服
//
//        }
//    }else if (indexPath.section == 3){//退出当前账号
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:couponDate];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * OKAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self logoutRequest];
            }];
            UIAlertAction * cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:OKAlert];
            [alertVC addAction:cancelAlert];
            [self presentViewController:alertVC animated:YES completion:^{
                
            }];
        });
        
     

    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0f;
}

-(void)logoutRequest{
//    NSUserDefaults * userTaken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//
//    __weak typeof(self)weakSelf = self;
//
//    [KDSProgressHUD showHUDTitle:@"正在退出" toView:weakSelf.view];
//    [KDSRegisterLoginHttp loginOutWithParams:@{@"token":userTaken} success:^(BOOL isSuccess, id  _Nonnull obj) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        if (isSuccess) {
//            //在主线程改变keyWindow.rootViewController
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //移除token
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//
//                //清空数据
//                [QZUserArchiveTool clearUserModel];
//                //跳转到
//                QZAccountLoginController * loginVc = [[QZAccountLoginController alloc]init];
//                KDSNavigationController  * nav = [[KDSNavigationController alloc]initWithRootViewController:loginVc];
//
//                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//            });
//        }else{
//            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
//
//            }];
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
//        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
//
//        }];
//    }];
    
//    //移除所有tag
//    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//        NSLog(@"退出删除tag %ld , iTags:%@ ,seq %ld:",iResCode,iTags,seq);
//    } seq:0];
//    
    //在主线程改变keyWindow.rootViewController
    dispatch_async(dispatch_get_main_queue(), ^{
        //移除token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];

        //清空数据
        [QZUserArchiveTool clearUserModel];
        //跳转到
    
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSNavigationController alloc]initWithRootViewController:[[WxLoginController alloc]init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[KDSTabBarController alloc]init];
    });

}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 55.0f;
        _tableView.estimatedSectionHeaderHeight = 10.0f;
    }
    return _tableView;
}

-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray arrayWithObjects:@[@"地址管理",@"清除缓存"],
                                                       @[@"关于我们",@"联系客服"],
                                                       @[@"退出当前账号"],
                       nil];
    }
    return _titleArray;
}

@end
