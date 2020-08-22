//
//  KDSOnlineServiceController.m
//  kaadas
//
//  Created by 中软云 on 2019/7/5.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSOnlineServiceController.h"
#import "KDSOnlineServiceHeaderView.h"
#import "KDSOnlineServiceQCodeCell.h"
#import "KDSMineHttp.h"
#import "KDSOnlineServiceModel.h"
@interface KDSOnlineServiceController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSOnlineServiceHeaderViewDelegate
>
@property (nonatomic,strong)UITableView        * tableView;
@property (nonatomic,strong)NSMutableArray     * dataArray;
@property (nonatomic,assign)BOOL               arrowButtonSelect;
@property (nonatomic,strong)KDSOnlineServiceModel   * model;
@end

@implementation KDSOnlineServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrowButtonSelect = YES;
    //创建UI
    [self createUI];
    //请求
    [self requestData];
}


-(void)requestData{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramsDict = @{@"params": @{},
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSMineHttp onlineServiceWithParams:paramsDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            _model = (KDSOnlineServiceModel *)obj;
            for (int i = 0; i < self.dataArray.count; i++) {
                if (i == 1) {
                    NSMutableDictionary * dict = (NSMutableDictionary *)self.dataArray[i];
                    [dict setValue:_model.qq forKey:@"des"];
                }else if (i == 2){
                    NSMutableDictionary * dict = (NSMutableDictionary *)self.dataArray[i];
                    [dict setValue:_model.email forKey:@"des"];
                }
            }
            
            [weakSelf.tableView reloadData];
            NSLog(@"self.dataArray:%@",self.dataArray);
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{
                
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"客户服务";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(isIPHONE_X ? - 34 : 0);
    }];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return _arrowButtonSelect ? 1 : 0;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KDSOnlineServiceHeaderView * headerView = [KDSOnlineServiceHeaderView onlineSericeHeaderWithTableView:tableView];
    headerView.dict = self.dataArray[section];
    headerView.delegate = self;
    headerView.section = section;
    if (section == 3) {
        headerView.arrowSelect = _arrowButtonSelect;
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    KDSOnlineServiceQCodeCell * cell = [KDSOnlineServiceQCodeCell onlineServiceQCodeCellWithTableView:tableView];
    cell.qrCode = _model.wxUrl;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - KDSOnlineServiceHeaderViewDelegate
-(void)onlineServiceHeaderViewButtonType:(KDSOnlineServiceButtonType)buttontype section:(NSInteger)section buttonSelect:(BOOL)buttonSelect{
    switch (buttontype) {
        case KDSOnlineServiceCall:{
            switch (section) {
                case 0:{//拨打电话
                    NSString * phoneNum = [KDSMallTool checkISNull:_model.phone];
                    if (phoneNum.length > 0) {
                        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                    }
                }
                    
                    break;
                case 1:{//QQ复制
                    UIPasteboard * pboard = [UIPasteboard generalPasteboard];
                    pboard.string = [KDSMallTool checkISNull:_model.qq];
                    [KDSProgressHUD showSuccess:@"QQ复制成功" toView:self.view completion:^{}];
                }
                    
                    break;
                case 2:{//邮箱复制
                    UIPasteboard * pboard = [UIPasteboard generalPasteboard];
                    pboard.string = [KDSMallTool checkISNull:_model.email];
                    [KDSProgressHUD showSuccess:@"邮箱复制成功" toView:self.view completion:^{}];
                }
            
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
        case KDSOnlineServiceQRCode:{
            _arrowButtonSelect =buttonSelect;
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionHeaderHeight = 80.0f;
        _tableView.estimatedRowHeight = 100.0f;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray  = [NSMutableArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon_tel_csh",@"image",@"客服电话",@"title",@"点击拨打客服电话",@"des", nil],
                       [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon_qq_csh",@"image",@"QQ客服",@"title",@"",@"des",nil],
                       [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon_email_csh",@"image",@"客服邮箱",@"title",@"",@"des", nil],
                       [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon_wechat_csh",@"image",@"客服微信",@"title",@"扫码添加客服微信",@"des", nil],
                       nil];
        
        NSLog(@"%@",_dataArray);
    }
    return _dataArray;
}

@end
