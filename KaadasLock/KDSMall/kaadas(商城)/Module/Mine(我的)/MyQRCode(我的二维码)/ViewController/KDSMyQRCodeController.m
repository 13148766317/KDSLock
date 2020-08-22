//
//  KDSMyQRCodeController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/15.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyQRCodeController.h"
#import "KDSMyQRCodeDetailView.h"
#import "ShareSheetView.h"
@interface KDSMyQRCodeController ()
@property (nonatomic,strong)UIScrollView   * scrollView;
@property (nonatomic,strong)UIView         * svContentView;

//我的邀请码
@property (nonatomic,strong)UILabel                 * myInviteCodeLabel;
//二维码详情控件
@property (nonatomic,strong)KDSMyQRCodeDetailView   * QRCodeDetailView;
@end

@implementation KDSMyQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建UI
    [self createUI];
}

#pragma mark - 复制 点击事件
-(void)copyButtonClick{
    UIPasteboard * pboard = [UIPasteboard generalPasteboard];
    NSString *  invitationString =  self.myInviteCodeLabel.text;
    pboard.string = invitationString;
//    [KDSProgressHUD showTextOnly:@"已复制链接到粘贴板" toView:nil completion:^{}];
}


#pragma mark - 创建UI
-(void)createUI{
    
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    
//    self.navigationBarView.backTitle = @"我的二维码";
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.right.bottom.left.mas_equalTo(self.view);
    }];
    
    
    _svContentView = [[UIView alloc]init];
    _svContentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
    [_scrollView addSubview:_svContentView];
    [_svContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.height.mas_equalTo(1000);
    }];
    
    //我的邀请码
    NSString * myInviteCodeString = [NSString stringWithFormat:@"我的邀请码：%@",[KDSMallTool checkISNull:userModel.randomCode]];
    _myInviteCodeLabel = [KDSMallTool createLabelString:myInviteCodeString textColorString:@"#333333" font:15];
    [_svContentView addSubview:_myInviteCodeLabel];
    [_myInviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(53);
        make.top.mas_equalTo(34);
    }];
    _myInviteCodeLabel.hidden = YES;
    
    //复制button
    UIButton * copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    copyButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
    copyButton.layer.cornerRadius = 25 / 2;
    copyButton.layer.masksToBounds = YES;
    [copyButton addTarget:self action:@selector(copyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_svContentView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-53);
        make.centerY.mas_equalTo(self.myInviteCodeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    copyButton.hidden = YES;
    
    //二维码详情控件
    _QRCodeDetailView = [[KDSMyQRCodeDetailView alloc]init];
    _QRCodeDetailView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    _QRCodeDetailView.layer.cornerRadius = 10;
    _QRCodeDetailView.layer.shadowColor = [UIColor hx_colorWithHexRGBAString:@"e6e6e6"].CGColor;
    _QRCodeDetailView.layer.shadowOpacity = 12;
    _QRCodeDetailView.layer.shadowOffset = CGSizeMake(0, 0);
    
    [_svContentView addSubview:_QRCodeDetailView];
    [_QRCodeDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myInviteCodeLabel.mas_left);
        make.right.mas_equalTo(copyButton.mas_right);
        make.height.mas_equalTo(self.QRCodeDetailView.mas_width).mas_equalTo(0);
        make.top.mas_equalTo(self.myInviteCodeLabel.mas_bottom).mas_offset(22);
    }];
    
    //分享button
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [shareButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_svContentView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.QRCodeDetailView);
        make.top.mas_equalTo(self.QRCodeDetailView.mas_bottom).mas_offset(30);
        make.height.mas_offset(44);
    }];
    
    [_svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(KSCREENWIDTH);
        make.bottom.mas_equalTo(shareButton.mas_bottom).mas_offset(50);
    }];
}

-(void)shareButtonClick{

    NSLog(@"分享");
    ShareSheetView * shareV = [[ShareSheetView alloc]initWithTitle:@"微信好友" rightTitles:@"朋友圈"];
    shareV.btnBlock = ^(int index) {
        if(![WXApi isWXAppInstalled]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请安装微信客户端" preferredStyle: UIAlertControllerStyleAlert];
            [alert addAction:[ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alert animated:true completion:nil];
            return ;
        }
        
        WXMediaMessage *message = [WXMediaMessage message];
        //分享纯图片
        WXImageObject *imgobject = [WXImageObject object];
        UIImage * image = _QRCodeDetailView.QRCodeImageView.image;
        //        UIImage *image =[UIImage imageNamed:@"pic_banner"];
        imgobject.imageData = UIImageJPEGRepresentation(image, 0.5);
        message.mediaObject = imgobject;
        
        //        //分享图文链接
        //        message.title = @"分享标题";//标题
        //        message.description = @"分享描述分享描述分享描述分享描述分享描述分享描述分享描述";//描述
        //        [message setThumbImage:[UIImage imageNamed:@"icon_home_sel"]];//缩略图˜
        //        WXWebpageObject *webObj = [WXWebpageObject object];
        //        webObj.webpageUrl =@"https://www.baidu.com";//链接
//        message.mediaObject = webObj;
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;
        sendReq.message = message;
        sendReq.scene = index;
        [WXApi sendReq:sendReq];
    };
    [shareV show];
}


@end
