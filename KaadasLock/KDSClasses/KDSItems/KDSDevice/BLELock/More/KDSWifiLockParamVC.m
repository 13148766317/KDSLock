//
//  KDSWifiLockParamVC.m
//  KaadasLock
//
//  Created by zhaona on 2019/12/20.
//  Copyright © 2019 com.Kaadas. All rights reserved.
//

#import "KDSWifiLockParamVC.h"
#import "KDSMQTT.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+Extension.h"
#import "KDSWifiLockModel.h"
#import "KDSHttpManager.h"
#import "KDSHttpManager+WifiLock.h"
#import "KDSLockMoreSettingCell.h"
#import "KDSAllPhotoShowImgModel.h"


@interface KDSWifiLockParamVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSArray *titles;
///锁的功能集是否是包含26OTA
@property (nonatomic, assign) BOOL supportFaceOTA;

@end

@implementation KDSWifiLockParamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitleLabel.text = Localized(@"deviceInfo");
    self.tableView.rowHeight = 60;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wifimqttEventNotification:) name:KDSMQTTEventNotification object:nil];
    ///支持人脸OTA升级
    self.supportFaceOTA =  [KDSLockFunctionSet[self.lock.wifiLockFunctionSet] containsObject:@28] ?: NO;
    if (self.lock.wifiDevice.isAdmin.intValue == 1) {
        if (self.supportFaceOTA) {
            self.titles = @[@"设备型号",@"序列号",@"门锁固件版本",@"Wi-Fi模块固件版本",@"人脸模组版本"];
        }else{
            self.titles = @[@"设备型号",@"序列号",@"门锁固件版本",@"Wi-Fi模块固件版本"];
        }
        
    }else{
        if (self.supportFaceOTA) {
            self.titles = @[@"设备名称",@"设备型号",@"消息免打扰",@"序列号",@"门锁固件版本",@"Wi-Fi模块固件版本",@"人脸模组版本"];
        }else{
            self.titles = @[@"设备名称",@"设备型号",@"消息免打扰",@"序列号",@"门锁固件版本",@"Wi-Fi模块版本"];
        }
        
    }

}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseId = NSStringFromClass([self class]);
    KDSLockMoreSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell)
    {
        cell = [[KDSLockMoreSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    NSString * product;
    if ([self.lock.wifiDevice.productModel isEqualToString:@"K13"]) {
        product= @"兰博基尼传奇";
    }else{
        product = self.lock.wifiDevice.productModel;
        for (NSString * productModel in [[KDSAllPhotoShowImgModel shareModel].productModel allKeys]) {
            if ([productModel isEqualToString:self.lock.wifiDevice.productModel]) {
                product = [[KDSAllPhotoShowImgModel shareModel].productModel objectForKey:self.lock.wifiDevice.productModel];
                break;
            }
        }
    }
    cell.title = self.titles[indexPath.row];
    cell.hideSeparator = indexPath.row == self.titles.count - 1;
    cell.clipsToBounds = YES;
    cell.hideArrow = YES;
    NSArray * contentArr;
    if (self.supportFaceOTA) {
        contentArr  = @[self.lock.wifiDevice.productModel ?: @"",self.lock.wifiDevice.wifiSN ?: @"",self.lock.wifiDevice.lockFirmwareVersion ?: @"",self.lock.wifiDevice.wifiVersion ?: @"",self.lock.wifiDevice.faceVersion ?: @""];
    }else{
        contentArr  = @[self.lock.wifiDevice.productModel ?: @"",self.lock.wifiDevice.wifiSN ?: @"",self.lock.wifiDevice.lockFirmwareVersion ?: @"",self.lock.wifiDevice.wifiVersion ?: @""];
    }
    
     if (self.lock.wifiDevice.isAdmin.intValue == 1) {
        cell.hideSwitch = YES;
        if (indexPath.row == 0) {
            cell.subtitle = product;
        }else{
            if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
                cell.hideArrow = NO;
            }else{
                cell.hideArrow = YES;
            }
            cell.subtitle = contentArr[indexPath.row];
        }
    }else{
        switch (indexPath.row) {
            case 0://设备名称
                cell.subtitle = self.lock.wifiDevice.lockNickname ?: self.lock.wifiDevice.wifiSN;
                cell.hideSwitch = YES;
                break;
            case 1://设备型号
                cell.subtitle = product;
                cell.hideSwitch = YES;
                break;
            case 2://消息免打扰
                {
                    cell.subtitle = nil;
                    cell.hideSwitch = NO;
                    cell.switchEnable = YES;
                    if (self.lock.wifiDevice.pushSwitch.intValue == 2) {
                        ///关闭推送（消息免打扰开启）
                        cell.switchOn = YES;
                    }else{
                        ///开启推送（消息免打扰关闭:1/0）
                        cell.switchOn = NO;
                    }
                    __weak typeof(self) weakSelf = self;
                    cell.switchStateDidChangeBlock = ^(UISwitch * _Nonnull sender) {
                        [weakSelf switchClickSetNotificationMode:sender];
                    };
                }
                break;
            case 3://序列号
                 cell.subtitle = self.lock.wifiDevice.wifiSN ?: @"";
                 cell.hideSwitch = YES;
                break;
            case 4://门锁固件版本
                cell.subtitle = self.lock.wifiDevice.lockFirmwareVersion ?: @"";
                cell.hideSwitch = YES;
                break;
            case 5://Wi-Fi版本
                cell.subtitle = self.lock.wifiDevice.wifiVersion ?: @"";
                cell.hideSwitch = YES;
                break;
            case 6://人脸模组版本
                cell.subtitle = self.lock.wifiDevice.faceVersion ?: @"";
                cell.hideSwitch = YES;
            break;
        }
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 && self.lock.wifiDevice.isAdmin.intValue == 1) {
        //门锁固件版本:2为WIFI锁
        [self checkWiFiLockOTA:self.lock.wifiDevice.lockSoftwareVersion withDevNum:2];
    }else if (indexPath.row == 3 && self.lock.wifiDevice.isAdmin.intValue == 1) {
        //检查wifi模块版本:1为WIFI模块
        [self checkWiFiLockOTA:self.lock.wifiDevice.wifiVersion withDevNum:1];
    }else if (indexPath.row == 4 && self.lock.wifiDevice.isAdmin.intValue == 1){
        //检查人脸模组版本:3为人脸模组模块
         [self checkWiFiLockOTA:self.lock.wifiDevice.wifiVersion withDevNum:3];
    }
}
///检查wifi锁/模块是否需要升级
- (void)checkWiFiLockOTA:(NSString *)content withDevNum:(int)devNum{
    NSLog(@"--{Kaadas}--检查OTA的softwareRev:%@",content);
    NSLog(@"--{Kaadas}--检查OTA的deviceSN:%@",self.lock.wifiDevice.wifiSN);
    
    [[KDSHttpManager sharedManager] checkWiFiOTAWithSerialNumber:self.lock.wifiDevice.wifiSN withCustomer:1 withVersion:content withDevNum:devNum success:^(id  _Nullable responseObject) {
        NSString *message ;

        if([responseObject[@"devNum"] isEqualToNumber:@2]){
            message = [NSString stringWithFormat:@"%@%@,%@",Localized(@"newWiFiLockImage"),responseObject[@"fileVersion"],Localized(@"WhetherToUpgrade")];
        }else if ([responseObject[@"devNum"] isEqualToNumber:@3]){
            message = [NSString stringWithFormat:@"%@%@,%@",@"检测到人脸模组版本",responseObject[@"fileVersion"],Localized(@"WhetherToUpgrade")];
        }else{
            message = [NSString stringWithFormat:@"%@%@,%@",Localized(@"newWiFiModuleImage"),responseObject[@"fileVersion"],Localized(@"WhetherToUpgrade")];
        }
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@""/*Localized(@"tips")*/ message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"--{Kaadas}--responseObject==%@",responseObject);
            //确认升级
            [self WiFiLockOTA:responseObject];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:Localized(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [cancelAction setValue:UIColor.blackColor forKey:@"titleTextColor"];
        [ac addAction:cancelAction];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
        
    } error:^(NSError * _Nonnull error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@""/*Localized(@"Lock OTA upgrade")*/ message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
        
    } failure:^(NSError * _Nonnull error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@""/*Localized(@"Lock OTA upgrade")*/ message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
    }];

}
///检查蓝牙固件是否需要升级
- (void)WiFiLockOTA:(id  _Nullable)responseObject{
    
    NSLog(@"--{Kaadas}--发送responseObject=%@",(NSDictionary *)responseObject);

    [[KDSHttpManager sharedManager] wifiDeviceOTAWithSerialNumber:self.lock.wifiDevice.wifiSN withOTAData:(NSDictionary *)responseObject success:^{
       NSLog(@"--{Kaadas}--发送OTA成功");
        if([responseObject[@"devNum"] isEqualToNumber:@2])
        {
            [MBProgressHUD showSuccess:Localized(@"newWiFiLockImageOTA")];
        }else if([responseObject[@"devNum"] isEqualToNumber:@3])
        {
            UIAlertController * alerVC = [UIAlertController alertControllerWithTitle:@"请唤醒门锁" message:@"请确保门锁有充足的电量\n人脸模组升级中，门锁面容识别不可用" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alerVC animated:YES completion:nil];
            [self performSelector:@selector(dismiss:) withObject:alerVC afterDelay:5.0];
        }
        else{
            [MBProgressHUD showSuccess:Localized(@"newWiFiModuleImageOTA")];
        }

    } error:^(NSError * _Nonnull error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle: @""/*Localized(@"Lock OTA upgrade")*/ message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
        
    } failure:^(NSError * _Nonnull error) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@""/*Localized(@"Lock OTA upgrade")*/ message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
    }];
}

///点击免打扰cell中的开关时设置锁报警信息本地通知功能或设置wifi锁开锁通知功能
- (void)switchClickSetNotificationMode:(UISwitch *)sender
{
    int switchNumber;
    if (sender.on) {
        switchNumber = 2;
    }else{
        switchNumber = 1;
    }
    NSLog(@"消息免打扰的值：%d",switchNumber);
    [[KDSHttpManager sharedManager] setUserWifiLockUnlockNotification:switchNumber withUid:[KDSUserManager sharedManager].user.uid wifiSN:self.lock.wifiDevice.wifiSN completion:^{
        [MBProgressHUD showSuccess:Localized(@"setSuccess")];
        self.lock.wifiDevice.pushSwitch = [NSString stringWithFormat:@"%d",switchNumber];
    } error:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:Localized(@"setFailed")];
        [sender setOn:!sender.on animated:YES];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:Localized(@"setFailed")];
        [sender setOn:!sender.on animated:YES];
    }];
}

#pragma mark 通知

///mqtt上报事件通知。
- (void)wifimqttEventNotification:(NSNotification *)noti
{
    MQTTSubEvent event = noti.userInfo[MQTTEventKey];
    NSDictionary *param = noti.userInfo[MQTTEventParamKey];
   if ([event isEqualToString:MQTTSubEventWifiLockStateChanged]){
       if ([param[@"wfId"] isEqualToString:self.lock.wifiDevice.wifiSN]){
           self.lock.wifiDevice.volume = param[@"volume"];
           self.lock.wifiDevice.language = param[@"language"];
           [self.tableView reloadData];
       }
       
    }
}

- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
