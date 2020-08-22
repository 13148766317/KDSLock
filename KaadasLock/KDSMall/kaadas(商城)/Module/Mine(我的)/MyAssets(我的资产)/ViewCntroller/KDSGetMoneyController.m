//
//  KDSGetMoneyController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/19.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSGetMoneyController.h"
#import "KDSGetMoneyCell.h"
#import "KDSMyAssetsHttp.h"
#import "KDSWithdrawalDesModel.h"

@interface KDSGetMoneyController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSGetMoneyCellDelegate
>
@property (nonatomic,strong)UITableView             * tableView;
@property (nonatomic,strong)UIView                  * footerView;
//商户提现说明model
@property (nonatomic,strong)KDSWithdrawalDesModel   * withdrawalDesModel;
@end

@implementation KDSGetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI{
    
    self.navigationBarView.backTitle = @"提现";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //获取商户提现说明
    [self withdrawRemark];
}

//商户提现说明
-(void)withdrawRemark{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    __weak typeof(self)weakSelf = self;
    NSDictionary * paramDict = @{
                                 @"params":  @{},
                                 @"token": [KDSMallTool checkISNull:userToken]
                                 };
    [KDSMyAssetsHttp withdrawRemarkWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            _withdrawalDesModel = (KDSWithdrawalDesModel *)obj;
            [self.tableView reloadData];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    KDSGetMoneyCell * cell = [KDSGetMoneyCell getMoneyCellWithTableView:tableView];
    cell.delegate = self;
    cell.desModel = _withdrawalDesModel;
    return cell;
}

#pragma mark - KDSGetMoneyCellDelegate 点击绑定银行卡  代理
-(void)bindBankCardBgButtonClick{
    [self.view endEditing:YES];
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    WebViewController * webView =   [[WebViewController alloc]init];
    webView.rightButtonHidden = YES;
//    webView.webViewResultBlock = ^(id obj) {
//        NSDictionary * dict = (NSDictionary *)obj;
//        _withdrawalDesModel.bankcard = dict[@"bankCardNo"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    };
    webView.url = [NSString stringWithFormat:@"%@banklist?token=%@",webBaseUrl,[KDSMallTool checkISNull:userToken]];
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - 提现button 点击事件
-(void)getMoneyButtonClick{
    [self.view endEditing:YES];
    
    KDSGetMoneyCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    if (cell.text.length <= 0) {
        [KDSProgressHUD showSuccess:@"请输入提现金额" toView:self.view completion:^{}];
        return;
    }
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * paramDict = @{@"params":@{@"cardNo":[KDSMallTool checkISNull:_withdrawalDesModel.bankcard], //提现银行卡号
                                            @"totalAmount":[KDSMallTool checkISNull:cell.text] //提现金额
                                     },
                                 @"token":[KDSMallTool checkISNull:userToken]
                                 };
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:self.view];
    [KDSMyAssetsHttp withdrawalMoneyrWithParams:paramDict success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [KDSProgressHUD showSuccess:@"申请提现成功，请耐心等待打款！" toView:weakSelf.view completion:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

-(UIView *)footerView{
    
    if (_footerView == nil) {
        _footerView = [[UIView alloc]init];
        _footerView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        _footerView.frame = CGRectMake(0, 0, KSCREENWIDTH, 50);
    
        UIButton * getButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        getButton.frame = CGRectMake(10, 0, KSCREENWIDTH - 20, 50);
        getButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        [getButton addTarget:self action:@selector(getMoneyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [getButton setTitle:@"提 现" forState:UIControlStateNormal];
        [_footerView addSubview:getButton];
        
    }
    return _footerView;
}

@end
