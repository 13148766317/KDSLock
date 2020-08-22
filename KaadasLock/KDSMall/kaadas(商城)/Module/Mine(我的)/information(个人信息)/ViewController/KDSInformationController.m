//
//  KDSInformationController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSInformationController.h"
#import "KDSInformationBaseCell.h"
#import "KDSIconTableCell.h"
#import "KDSPasswordSettingsController.h"
#import "KDSBindingPhoneNumController.h"
#import "KDSBindingWechatController.h"
#import "KDSBindInvitationCodeController.h"

#import "KDSDatePickerController.h"

#import "KDSEditInfoController.h"
#import "KDSGenderAlertController.h"
#import "CustomSheet.h"
#import "KDSPhotoTool.h"
#import "AddressController.h"
#import "KDSMineHttp.h"

@interface KDSInformationController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)NSMutableArray   * titleArray;
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)QZUserModel      * userModel;
@property (nonatomic,strong)NSMutableDictionary   * userDictionary;
@end

@implementation KDSInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userModel = [QZUserArchiveTool loadUserModel];
    //创建UI
    [self createUI];
    
    //获取个人信息
    [self getMineInfo];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userModel = [QZUserArchiveTool loadUserModel];
    [self.tableView reloadData];
}

//获取个人信息
-(void)getMineInfo{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{
                            @"params":@{},
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    
    __weak typeof(self)weakSelf = self;
    
    [KDSMineHttp mineInfoWithParams:dictionary  success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            weakSelf.userModel = (QZUserModel *)obj;
            [weakSelf.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
                
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}

-(void)createUI{
    self.navigationBarView.backTitle = @"个人信息";
    //添加tableview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = self.titleArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = self.titleArray[indexPath.section];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            KDSIconTableCell * cell = [KDSIconTableCell iconCellWithTableView:tableView];
            cell.titleString = array[indexPath.row];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:self.userModel.logo]] placeholderImage:[UIImage imageNamed:@"pic_head_mine"]];
            return cell;
        }else{
            KDSInformationBaseCell  * cell = [KDSInformationBaseCell informationBaseCellWithTableView:tableView];
            cell.titleString = array[indexPath.row];
            if (indexPath.row == 1) {//姓名
                cell.detailString = _userModel.userName;
            }else if (indexPath.row == 2){//性别
                cell.detailString = [KDSMallTool checkISNull:_userModel.genderCN];
            }else if(indexPath.row == 3){//生日
                cell.detailString = [KDSMallTool checkISNull:_userModel.birthday];
            }else if (indexPath.row == 4){//手机号
                cell.detailString = [KDSMallTool checkISNull:_userModel.tel];
            }else if (indexPath.row == 5){//收货地址
                cell.detailString = @"";
            }else{
                cell.detailString = @"";
            }
            
            return cell;
        }
        
    }else{
        KDSInformationBaseCell  * cell = [KDSInformationBaseCell informationBaseCellWithTableView:tableView];
        cell.titleString = array[indexPath.row];
        if (indexPath.row == 0) {
            cell.detailString = [KDSMallTool checkISNull:_userModel.tel];
        }
        return cell;
    }
}


-(void)uploadImage:(UIImage *)image{
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSNetworkManager POSTUploadDatawithPics:image progress:^(NSProgress *uploadProgress) {} success:^(NSInteger code, id json) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (code == 1) {
            NSString * logoUrl = json[@"data"][@"fileRewriteFullyQualifiedPath"];
            [self saveData:logoUrl];
        }else{
            [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError *error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}


-(void)saveData:(NSString *)logoUrl{
    
    NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
    if ([KDSMallTool checkISNull:logoUrl].length > 0) {//上传头像
        [userDict setValue:logoUrl forKey:@"logo"];
    }else{
        [userDict addEntriesFromDictionary:self.userDictionary];
    }
    
    NSLog(@"userDict:%@",userDict);
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramDictionary = @{
                                       @"params":userDict,
                                       @"token":[KDSMallTool checkISNull:userToken]
                                       };
    
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    
    [KDSMineHttp updateUserInfoWithParams:paramDictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            if ([KDSMallTool checkISNull:logoUrl].length > 0) {
                [KDSProgressHUD showTextOnly:@"头像修改成功" toView:weakSelf.view completion:^{}];
            }
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{ }];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    } getInfo:^(BOOL isSuccess) {
        if (isSuccess) {
             weakSelf.userModel = [QZUserArchiveTool loadUserModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:0];
            });
        }
    }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        __weak typeof(self)weakSelf = self;
        if (indexPath.row == 0) {//头像
            KDSIconTableCell * cell =  [self.tableView cellForRowAtIndexPath:indexPath];
            CustomSheet *sheetV = [[CustomSheet alloc]initWithHeadView:nil cellArray:@[@"相册",@"拍照"] cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
                switch (index) {
                    case 0:{//相册
                        [[KDSPhotoTool sharedInstance] photoPickerControllerSourceTypePhotoLibraryWithViewController:self maxImagesCount:1 didFinishPickingPhotosHandle:^(NSArray<UIImage *> * _Nonnull photos, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
                            NSLog(@"拍照%@",photos);
                            if (photos.count > 0) {
                                UIImage * image = [photos firstObject];
                                if (image) {
                                    cell.iconImageView.image = image;
                                    [weakSelf uploadImage:image];
                                }
                            }
                        }];
                    }
                        break;
                    case 1:{//拍照
                        [[KDSPhotoTool sharedInstance] photoPickerControllerSourceTypeCameraWithViewController:self didFinishPickingMediaWithimage:^(UIImage * _Nonnull image) {
                            NSLog(@"相册%@",image);
                            cell.iconImageView.image = image;
                            [weakSelf uploadImage:image];
                        }];
                        
                    }
                        break;
                    default:
                        break;
                }
                
            } cancelBlock:^{
                
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
        }else if (indexPath.row == 1){//昵称
             __block KDSInformationBaseCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
            KDSEditInfoController * editInfoVC = [[KDSEditInfoController alloc]init];
            editInfoVC.text = weakSelf.userModel.userName;
            editInfoVC.titleText = @"昵称";
            editInfoVC.editInfo = ^(NSString *str) {
                if (str.length > 0 && ![str isEqualToString:weakSelf.userModel.userName]) {
                    [self.userDictionary removeAllObjects];
                    cell.detailString = str;
                    [weakSelf.userDictionary setValue:str forKey:@"userName"];
                    [weakSelf saveData:@""];
                }
                
            };
            [self.navigationController pushViewController:editInfoVC animated:YES];
        }else if (indexPath.row == 2){//性别
            
          __block KDSInformationBaseCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [KDSGenderAlertController genderAlertGender:[KDSMallTool checkISNull:weakSelf.userModel.genderCN] resultBlock:^(KDSGenderType type) {
                NSString * genderStr = @"";
                switch (type) {
                    case KDSGenderType_male:{
                        genderStr = @"男";
                        cell.detailString = genderStr;
                    }
                        break;
                    case KDSGenderType_female:{
                        genderStr =  @"女";
                        cell.detailString = genderStr;
                    }
                    default:
                        break;
                }
                
                if (![weakSelf.userModel.genderCN isEqualToString:genderStr]) {
                    [self.userDictionary removeAllObjects];
                    if ([genderStr isEqualToString:@"男"]) {
                        [weakSelf.userDictionary setValue:@(1) forKey:@"gender"];
                    }else if ([genderStr isEqualToString:@"女"]){
                        [weakSelf.userDictionary setValue:@(0) forKey:@"gender"];
                    }
                    [weakSelf saveData:@""];
                    weakSelf.userModel.genderCN = genderStr;
                }
            }];
           
        }else if (indexPath.row == 3){//生日
            __block KDSInformationBaseCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
            KDSDatePickerController * date = [[KDSDatePickerController alloc]init];
            [date show];
            date.datePickerBlock = ^(NSString *dateString) {
                [self.userDictionary removeAllObjects];
                cell.detailString = dateString;
                [weakSelf.userDictionary removeAllObjects];
                [weakSelf.userDictionary setValue:dateString forKey:@"birthday"];
                [weakSelf saveData:@""];
            };
        }else if (indexPath.row == 4){//手机号  绑定
            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
            if ([KDSMallTool checkISNull:userModel.tel].length <= 0) {
                KDSBindingPhoneNumController * bindingPhoneNumVC = [[KDSBindingPhoneNumController alloc]init];
                [self.navigationController pushViewController:bindingPhoneNumVC animated:YES];
            }
        }else if (indexPath.row == 5){//收货地址
                AddressController * addressVC = [[AddressController alloc]init];
                [self.navigationController pushViewController:addressVC animated:YES];
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//绑定手机
            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
            if ([KDSMallTool checkISNull:userModel.tel].length <= 0) {
                KDSBindingPhoneNumController * bindingPhoneNumVC = [[KDSBindingPhoneNumController alloc]init];
                [self.navigationController pushViewController:bindingPhoneNumVC animated:YES];
            }
        }
//        if (indexPath.row == 0) {//地址管理
//            AddressController * addressVC = [[AddressController alloc]init];
//            [self.navigationController pushViewController:addressVC animated:YES];
//        }else if (indexPath.row == 1){//密码设置
//            KDSPasswordSettingsController * pwdSettingsVC = [[KDSPasswordSettingsController alloc]init];
//            [self.navigationController pushViewController:pwdSettingsVC animated:YES];
//        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {//绑定手机
            KDSBindingPhoneNumController * bindingPhoneNumVC = [[KDSBindingPhoneNumController alloc]init];
            [self.navigationController pushViewController:bindingPhoneNumVC animated:YES];
        }else if (indexPath.row == 1){//绑定微信
            KDSBindingWechatController * bindingWechatVC = [[KDSBindingWechatController alloc]init];
            [self.navigationController pushViewController:bindingWechatVC animated:YES];
        }else if (indexPath.row == 2){//绑定邀请码
            KDSBindInvitationCodeController * bindinvitationCodeVC = [[KDSBindInvitationCodeController alloc]init];
            [self.navigationController pushViewController:bindinvitationCodeVC animated:YES];
        }
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

#pragma mark - 懒加载
-(NSMutableArray *)titleArray{
    if (_titleArray== nil) {
        _titleArray = [NSMutableArray arrayWithObjects:@[@"头像",@"昵称",@"性别",@"生日",@"手机号",@"收货地址"], nil];
        //        _titleArray = [NSMutableArray arrayWithObjects:@[@"头像",@"昵称",@"性别",@"生日"],
        //                                                       @[@"手机号"],
        ////                                                       @[@"地址管理",@"密码设置"],
        ////                                                       @[@"绑定手机",@"绑定微信",@"绑定邀请码"],
        //                                                       nil];
    }
    return _titleArray;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 55.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionHeaderHeight = 10.0f;
    }
    return _tableView;
}

-(NSMutableDictionary *)userDictionary{
    if (_userDictionary == nil) {
        _userDictionary = [NSMutableDictionary dictionary];
    }
    return _userDictionary;
}

@end
