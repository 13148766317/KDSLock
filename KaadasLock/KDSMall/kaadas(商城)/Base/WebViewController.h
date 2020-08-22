//
//  WebViewController.h
//  QiZhiClass
//
//  Created by Apple on 2019/4/1.
//  Copyright © 2019年 qizhi. All rights reserved.
//

#import "KDSBaseController.h"
//#import "KDSSocialRowModel.h"


@interface WebViewController : KDSBaseController
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy)NSString *returnUrl;
//@property (nonatomic,strong)KDSSocialRowModel   * rowModel;
@property (nonatomic,assign)BOOL                  activity;
@property (nonatomic,assign)BOOL                  rightButtonHidden;
//@property (nonatomic,copy)WebViewResultBlock      webViewResultBlock;

-(id)initWithUrl:(NSString *)url;
-(void)reloadData;

@end
