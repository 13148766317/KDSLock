//
//  WebViewController.m
//  QiZhiClass
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 qizhi. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "ShareSheetView.h"
#import "KDSBindingPhoneNumController.h"

@interface WebViewController ()<WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

{
    NSString *loadurlStr;
}

@property (nonatomic, strong) WKWebView *webView;
@property(nonatomic)bool isShowCloseBtn;
@property (nonatomic, strong) UIProgressView *mProgressView;


@end

@implementation WebViewController


-(id)initWithUrl:(NSString *)url{
    if(self = [super init]) {
        self.url=url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.isShowCloseBtn=false;
    self.view.backgroundColor = [UIColor whiteColor];
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"senderModel"];
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    CGFloat webViewH = KSCREENHEIGHT - MnavcBarH - (isIPHONE_X ? 34 : 0);
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, isIPHONE_X ? 88 : 64, KSCREENWIDTH, webViewH) configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self loadUrl:self.url];
    NSLog(@"self.url: %@",self.url);
    //获取标题title
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    self.navigationBarView.backTitle = self.title;
    [self addTitleAndProgress];
    
    //分享button
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"icon_share_detail_black"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = shareButton;
    self.navigationBarView.rightItem.hidden = YES;
//    self.navigationBarView.backTitle = _rowModel.articleTitle;
    
}

//#pragma mark - 分享事件
//-(void)shareButtonClick{
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//
//    if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
//        WxLoginController * wxloginVC = [[WxLoginController alloc]init];
//        [self presentViewController:wxloginVC animated:YES completion:^{}];
//        return;
//    }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
//        KDSBindingPhoneNumController  * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
//        [self presentViewController:bindPhoneVC animated:YES completion:^{}];
//        return;
//    }else{
//
//    }
//
//    NSLog(@"分享");
//    ShareSheetView * shareV = [[ShareSheetView alloc]initWithTitle:@"微信好友" rightTitles:@"朋友圈"];
//    shareV.btnBlock = ^(int index) {
//        //分享记录
//        [self shareSave];
//
//        if(![WXApi isWXAppInstalled]){
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请安装微信客户端" preferredStyle: UIAlertControllerStyleAlert];
//            [alert addAction:[ UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            }]];
//            [self presentViewController:alert animated:true completion:nil];
//            return ;
//        }
//
////        WXWebpageObject *webObj = [WXWebpageObject object];
////        webObj.webpageUrl = self.url;//链接
////        NSLog(@"%@",self.url);
////        WXMediaMessage *message = [WXMediaMessage message];
////        //分享图文链接
//////        message.title = self.rowModel.articleTitle;//标题
////        message.description = self.rowModel.articleTitle;//描述
////        [message setThumbImage:[UIImage imageNamed:@"logo"]];//缩略图˜
//////        [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[KDSMallTool checkISNull:self.rowModel.articleCoverUrl]]] scale:0.5]];
////        message.mediaObject = webObj;
////
////        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
////        sendReq.bText = NO;
////        sendReq.message = message;
////        sendReq.scene = index;
////        [WXApi sendReq:sendReq];
//
//        NSString *parterq = [NSString stringWithFormat:@"?id=%ld&type=banner_list_invitation&customid=%ld",_rowModel.ID,userModel.ID];
//        NSString *urlStr = @"";
//
//        if (_activity) {
//           urlStr = [[NSString stringWithFormat:@"%@activity",webBaseUrl] stringByAppendingString:parterq];
//        }else{
//            urlStr = [webBaseUrl stringByAppendingString:parterq];
//        }
//        NSLog(@"分享URL：%@",urlStr);
//        WXWebpageObject *webObj = [WXWebpageObject object];
//        webObj.webpageUrl = urlStr;//链接
//
//        WXMediaMessage *message = [WXMediaMessage message];
//        //分享图文链接
//        if (index == 0) {
//             message.description = _rowModel.articleTitle;//描述
//        }else if (index == 1){
//            message.title = _rowModel.articleTitle;//标题
//        }
//
//
//        [message setThumbImage:[UIImage imageNamed:@"logo"]];//缩略图˜
////                message.thumbData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[KDSMallTool checkISNull:rowModel.articleCoverUrl]]];
////                [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[KDSMallTool checkISNull:rowModel.articleCoverUrl]]] scale:0.5]];
//        message.mediaObject = webObj;
//
//
//        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
//        sendReq.bText = NO;
//        sendReq.message = message;
//        sendReq.scene = index;
//        [WXApi sendReq:sendReq];
//
//
//    };
//    [shareV show];
//}

//#pragma mark - 分享记录
//-(void)shareSave{
//    
//    NSString * type = @"";
//    if ([self.title isEqualToString:@"行业动态"]) {
//        type = @"share_type_article";
//    }else if ([self.title isEqualToString:@"帖子"]){
//        type = @"share_type_invitation";
//    }else if ([self.title isEqualToString:@"活动"]){
//        type = @"share_type_activity";
//    }
//    
//    if ([KDSMallTool checkISNull:type].length <= 0) {
//        return;
//    }
//    
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    NSDictionary * dict = @{@"params":@{
//                                    @"type":type, //类型（商品，活动，文章）
//                                    @"businessId":@(_rowModel.ID) //分享的类容编号
//                                    },
//                            @"token": [KDSMallTool checkISNull:userToken]
//                            };
//    [KDSNetworkManager POSTRequestBodyWithServerUrlString:shareSave paramsDict:dict success:^(NSInteger code, id  _Nullable json) {
//        if (code == 1) {
//            NSLog(@"分享记录成功");
//        }else{
//            NSLog(@"分享记录失败");
//        }
//    } failure:^(NSError * _Nullable error) {
//        NSLog(@"分享记录成功%@",error);
//    }];
//}


-(void)addTitleAndProgress{
    CGFloat progressBarHeight = 2.0f;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
//    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    CGRect  barFrame = CGRectMake(0, isIPHONE_X ? 87 : 62, KSCREENWIDTH, progressBarHeight);
    _mProgressView = [[UIProgressView alloc] initWithFrame:barFrame];
//    _mProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _mProgressView.progressTintColor = [UIColor hx_colorWithHexRGBAString:@"#FF6A78"];
//    [self.navigationController.navigationBar addSubview:_mProgressView];
    [self.view addSubview:_mProgressView];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
    
    if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
        self.navigationBarView.rightItem.hidden = YES;
    }else{
         self.navigationBarView.rightItem.hidden = NO;
    }
    
    self.navigationBarView.rightItem.hidden = _rightButtonHidden;
    
    
     [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    if (self.title) {
        self.navigationBarView.backTitle = self.title;
        return;
    }else{
//        self.navigationItem.title =@"新手宝典";
//        if ([self.url containsString:@"openVipDetail"]) {
//            self.navigationItem.title =@"开通VIP";
//
//            QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
//            if ([QZTool checkISNull:userModel.cardNo].length > 0){
//                self.navigationItem.title =@"VIP续费";
//            }
//        }
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    _mProgressView.hidden = YES;
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"estimatedProgress"]){
        if (object == self.webView){
            self.mProgressView.alpha = 1;
            [self.mProgressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    self.mProgressView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.mProgressView setProgress:0.0f animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){
//        self.navigationBarView.backTitle = self.webView.title;
        NSLog(@"webView.title : %@",self.webView.title);
    }
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"name==%@" ,message.name);
    NSLog(@"body==%@" ,message.body);
    
    NSDictionary *dic = [self dictionaryWithJsonString:message.body];
    NSLog(@"dic=%@" ,dic);
//    [self.navigationController popViewControllerAnimated:YES];
//    if (self.webViewResultBlock) {
//        self.webViewResultBlock(dic);
//    }
    
//    if([[dic allKeys] containsObject:@"page"]){
//        NSString *text = [NSString stringWithFormat:@"%@" ,dic[@"page"]];
//        if ([text isEqualToString:@"bindcode"]) {
//            QZBindInvitationCodeController*bindVc=[[QZBindInvitationCodeController alloc]init];
//            bindVc.bindCodeSuccessBlock = ^{
//                [self reloadData];
//            };
//            [self.navigationController pushViewController:bindVc animated:YES];
//        }
//        if ([text isEqualToString:@"vipcardactivate"]) {
//            QZVIPTiedActivationController*activeVc = [[QZVIPTiedActivationController alloc]init];
//            [self.navigationController pushViewController:activeVc animated:YES];
//        }if ([text isEqualToString:@"vipactivate"]) {
//            QZPayViewController *payVc = [[QZPayViewController alloc]init];
//            [self.navigationController pushViewController:payVc animated:YES];
//        }
//    }
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



/// 2 页面开始加载

//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"2页面开始加载时调用");
//    [self setLoadAnimation];
//}
///3在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"3加载URL=%@" ,navigationResponse.response.URL);
    
    loadurlStr = [NSString stringWithFormat:@"%@",navigationResponse.response.URL] ;

    if ([loadurlStr containsString:@"mobile/#/center?ids"]) {
        NSLog(@"去第四个");
        
    }
    
    
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"loadurlStr=%@" ,loadurlStr);
    
    //    // 不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    
}


/// 5 页面加载完成之后调用

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"5页面加载完成之后调用");
//
//
//    [self.loadingView removeFromSuperview];
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    NSLog(@"页面加载失败时调用");
//    [self.loadingView removeFromSuperview];
//    [self stepDefaultView:@"加载失败" alertLable:@"加载失败" reloadData:NO];
//}

-(void)reloadData{
    [self loadUrl:self.url];
}



#pragma mark 解析URL
-(NSString *) jiexi:(NSString *)CS webaddress:(NSString *)webaddress
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}

#pragma mark webview 操作

-(void)loadUrl:(NSString *)url{
    [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:url]]];
}
-(void)actionback{
    [self goBack];
}
-(void)goBack{
    if(self.webView.canGoBack) {
        [self.webView goBack];
        if(!self.isShowCloseBtn){
            self.isShowCloseBtn=true;
            //            [self showCloseBtn];
        }
        
    } else {
        [self webViewClose];
    }
    
    //    if(self.webView.canGoBack) {
    //        [self webViewClose];
    //    }
}
-(void)webViewClose{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewCloseAndUpdateMessage
{
   
    [self webViewClose];
}


-(void)showCloseBtn{
    UIBarButtonItem *myLeftItem1 = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(webViewClose)];
    myLeftItem1.tintColor = [UIColor blackColor];
    NSArray *leftBtns=@[self.navigationItem.leftBarButtonItem,myLeftItem1];
    self.navigationItem.leftBarButtonItems=leftBtns;
}


@end
