//
//  KDSFeedbackController.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSFeedbackController.h"
#import "KDSTextView.h"
#import "KDSMineHttp.h"

@interface KDSFeedbackController ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView         * svContentView;
@property(nonatomic,strong)KDSTextView     * textView;


@end

@implementation KDSFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UI
    [self createUI];
}

#pragma mark - 提交事件
-(void)submitButtonClick{
//    NSLog(@"提交");
    if ([KDSMallTool checkISNull:_textView.text].length <= 0) {
        [KDSProgressHUD showTextOnly:@"请输入反馈内容..." toView:self.view completion:^{
            
        }];
        return;
    }
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary = @{@"params":@{@"content" :[KDSMallTool checkISNull:_textView.text]}, // String 必填   反馈内容
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };
    
    __weak typeof(self)weakSelf = self;
    [KDSMineHttp feedbackSaveWithParams:dictionary success:^(BOOL isSuccess, id  _Nonnull obj) {
        if (isSuccess) {
            [KDSProgressHUD showTextOnly:@"提交成功" toView:weakSelf.view completion:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"意见反馈";
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.right.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(isIPHONE_X ? - 34 : 0);
    }];
    
    
    _svContentView = [[UIView alloc]init];
    _svContentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
    [_scrollView addSubview:_svContentView];
    [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.height.mas_equalTo(1000);
    }];

    
    //输入框背景
    UIView * bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [_svContentView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    //输入框
    _textView = [[KDSTextView alloc]init];
    _textView.placeholder = @"请输入您宝贵的意见...";
    _textView.font = [UIFont systemFontOfSize:15];
//    _textView.leftSpacing = 10;
    _textView.placeholderCorlor = [UIColor hx_colorWithHexRGBAString:@"999999"];
    [bg addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(bg.mas_bottom);
    }];
    
    //提交
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    submitButton.layer.cornerRadius = 2;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    submitButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_svContentView addSubview:submitButton];
    submitButton.layer.cornerRadius = 44 /2;
    submitButton.layer.masksToBounds = YES;
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    
    [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.bottom.mas_equalTo(submitButton.mas_bottom).mas_offset(50);
    }];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}



@end
