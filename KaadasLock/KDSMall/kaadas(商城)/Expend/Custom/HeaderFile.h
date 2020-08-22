//
//  HeaderFile.h
//  kaadas_demo
//
//  Created by 中软云 on 2019/9/9.
//  Copyright © 2019 kaadas. All rights reserved.
//

#ifndef HeaderFile_h
#define HeaderFile_h

//三方库
#import <HexColors/HexColors.h>
#import <AFNetworking.h>
#import <Masonry.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <MBProgressHUD.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <SDWebImageDownloader.h>
#import <YBImageBrowser/YBImageBrowser.h>
#import <DateTools.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
//#import <JPUSHService.h>
////定位
//#import <BMKLocationKit/BMKLocationComponent.h>
////地图
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//

//自定义文件
//#import "KDSTool.h"
#import "KDSProgressHUD.h"
#import "KDSNavigationController.h"
#import "KDSTabBarController.h"
#import "KDSVariable.h"
#import "KDSNetworkManager.h"
#import "KDSNetworkMonitor.h"
#import "KDSURL.h"
#import "KDSNavigationBar.h"
#import "JXLayoutButton.h"
#import "QZUserModel.h"
#import "QZUserArchiveTool.h"
#import "WebViewController.h"
#import "GCDTimerTool.h"
#import "WxLoginController.h"
#import "HelperTool.h"
#import "ios-ntp.h"
#import "QZAccountLoginController.h"
//#import "KDSBaiduLoacationMap.h"

//枚举文件
#import "KDSEnumeration.h"

//******************************************************//

#import "BaseDataLoadController.h"

#define KViewBackGroundColor [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"] //屏幕背景色
#define KseparatorColor [UIColor hx_colorWithHexRGBAString:@"#e6e6e6"] //分割线颜色
#define userDefaults    [NSUserDefaults standardUserDefaults]
#define ACCESSTOKEN     [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_TOKEN"]
#define LOGINSTATE      !(ACCESSTOKEN==nil || [ACCESSTOKEN isEqualToString:@""])

#import "DetailModel.h"
#import "RegexUitl.h"
#import "UITextField+Length.h"
#import "KDSAlertController.h"

#define  textFieldWidth 65

//*******************************************************//

//宏
//是否为iPhone X , iPhone XR , iPhone XS , iPhone XS MAX
#define isIPHONE_X      (([UIScreen mainScreen].bounds.size.height == 812.0) || ([UIScreen mainScreen].bounds.size.height == 896.0f))
//5s以下版本（包括5s）
#define isIphone5sBelow  [UIScreen mainScreen].bounds.size.width <= 320

//屏幕宽高
#define KSCREENWIDTH    [[UIScreen mainScreen] bounds].size.width
#define KSCREENHEIGHT   [[UIScreen mainScreen] bounds].size.height
#define KwidthSacle      1//KSCREENWIDTH/375
#define KheightSacle     1//KSCREENHEIGHT/667

#define MtabBarH   (isIPHONE_X ? 83.f : 49.f) // Tabbar高度.    49 + 34 = 83    49+0 = 49
#define MnavcBarH  (isIPHONE_X ? 88.f : 64.f) //导航高度         44+44=88   44+20=64
#define MhomeBarH  (isIPHONE_X ? 34.f : 0.f)  //iphoneX时 home高度

//背景颜色
#define KBackgroundColor  [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"]

#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr, "\nfunction:%s line:%d content:%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif



#endif /* HeaderFile_h */

