//
//  KDSEditInfoController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/16.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSEditInfoController.h"

@interface KDSEditInfoController ()
@property (nonatomic,strong)UITextField   * textField;
@end

@implementation KDSEditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //创建UI
    [self createUI];
}

-(void)okButtonClick{
    if (self.editInfo) {
        self.editInfo(_textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = self.titleText;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    //确定button
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(45);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    //输入框
    _textField = [[UITextField alloc]init];
    _textField.text = _text;
    [_textField becomeFirstResponder];
    [self.view addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(okButton.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(okButton.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    //分割线
    UIView * dividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
    [self.view addSubview:dividing];
    [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.textField.mas_left);
        make.right.mas_equalTo(okButton.mas_right);
        make.height.mas_equalTo(dividinghHeight);
    }];
    
}



@end
