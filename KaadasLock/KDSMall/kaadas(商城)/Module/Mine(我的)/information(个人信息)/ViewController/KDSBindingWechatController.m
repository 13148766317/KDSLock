//
//  KDSBindingWechatController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/24.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBindingWechatController.h"

@interface KDSBindingWechatController ()

@end

@implementation KDSBindingWechatController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"绑定微信";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
    
    UIView * whiteBgView = [[UIView alloc]init];
    whiteBgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [self.view addSubview:whiteBgView];
    
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(whiteBgView.mas_width).multipliedBy(0.5);
    }];
    
    
//    icon_bind
    UIImageView * iconbind = [[UIImageView alloc]init];
    iconbind.image = [UIImage imageNamed:@"icon_bind"];
    [whiteBgView addSubview:iconbind];
    [iconbind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(whiteBgView);
        make.size.mas_equalTo(CGSizeMake(50, 18));
    }];
    
    
    //头像
    CGFloat iconWidth = 60.0f;
    UIImageView * iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"pic_head_mine"];
    [whiteBgView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(iconbind.mas_left).mas_offset(-30);
        make.size.mas_equalTo(CGSizeMake(iconWidth, iconWidth));
        make.centerY.mas_equalTo(iconbind.mas_centerY);
    }];
    
    
    //微信图片
    UIImageView * wechatImageView = [[UIImageView alloc]init];
    wechatImageView.image = [UIImage imageNamed:@"weichat_bind"];
    [whiteBgView addSubview:wechatImageView];
    [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconbind.mas_right).mas_offset(30);
        make.centerY.mas_equalTo(iconbind.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(iconWidth, iconWidth));
    }];
    
    //绑定微信button
    UIButton * bingdingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bingdingButton setTitle:@"绑定微信" forState:UIControlStateNormal];
    [bingdingButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#ffffff"] forState:UIControlStateNormal];
    bingdingButton.titleLabel.font = [UIFont systemFontOfSize:18];
    bingdingButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    [bingdingButton addTarget:self action:@selector(bingdingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bingdingButton];
    [bingdingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteBgView.mas_left);
        make.right.mas_equalTo(whiteBgView.mas_right);
        make.top.mas_equalTo(whiteBgView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
    }];
}


#pragma mark -  绑定微信 点击事件
-(void)bingdingButtonClick{
    NSLog(@"绑定微信");
}

@end
