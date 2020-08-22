//
//  ComentController.m
//  kaadas
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "ComentController.h"
#import "KDSContentCell.h"
#import "KDSEvaliateModel.h"

//#import "StarEvaluationView.h"
//#import "UIViewController+ImagePicker.h"
//#import "UIButton+NSString.h"
//#import "CustomBtn.h"
@interface ComentController ()<UITableViewDelegate,UITableViewDataSource,KDSContentCellDelegate>{
//    BOOL hideName;
//    NSString *score;//评分
//    NSString *conformityScore;//商品符合度
//    NSString *dispatchingScore;//配送评分
//    NSString *installScore;//安装满意度
//
//    StarEvaluationView *fuheView;
//    StarEvaluationView *peisongView;
//    StarEvaluationView *manyiView;

}
//@property(nonatomic,strong) UITextView *textView;
//@property(nonatomic,strong)UIView *contentView;
//@property(nonatomic,strong)UIScrollView *myscrollView;
//
//@property(nonatomic,strong) StarEvaluationView *topStarView;

@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)NSMutableArray   * dataArray;

@end

@implementation ComentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
//    self.navigationBarView.backTitle = @"评价";
//
//    UIButton *  rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 50, 30);
//    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
//    [rightBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#ca2128"] forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [rightBtn addTarget:self action:@selector(submitActon) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationBarView.rightItem =rightBtn;
//
//
//    CGFloat contH =285+170;
//    self.myscrollView = [[UIScrollView alloc] init];
//    self.myscrollView.frame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, contH);
//    [self.view addSubview:self.myscrollView];
//
//    self.contentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, contH)];
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    [self.myscrollView addSubview:self.contentView];
//
//    [self addUI];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
   KDSContentCell  *  cell = [KDSContentCell contentCellWithTableView:tableView];
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - KDSContentCellDelegate
-(void)contentCellDelegateWithModel:(KDSEvaliateModel *)model indexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);

}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"评价";
    _dataArray = [NSMutableArray array];
    
    for (int i = 0; i < self.indeInfoArr.count; i++) {
        NSDictionary * dict = self.indeInfoArr[i];
        KDSEvaliateModel * model = [[KDSEvaliateModel alloc]init];
        model.qty = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"qty"]]];
        model.indentId = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"indentId"]]];
        model.ID =  [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"id"]]];
        model.price = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"price"]]];
        model.productName = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"productName"]]];
        
        model.productLabels = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"productLabels"]]];
        model.productId = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"productId"]]];
        model.logo = [NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:dict[@"logo"]]];
        [_dataArray addObject:model];
    }
   
    UIButton *  rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(submitActon) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem =rightBtn;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? -34 : 0);
    }];
    
}
#pragma mark - 提交事件
-(void)submitActon{
    
//    NSString *isAnonymous = @"false";
//    if (hideName) {
//        NSLog(@"匿名");
//        isAnonymous = @"true";
//    }
//
//    NSLog(@"self.indeInfoArr=%@" ,self.indeInfoArr);
//
//    NSLog(@"score=%@" ,score);
//    NSLog(@"conformityScore=%@" ,conformityScore);
//    NSLog(@"dispatchingScore=%@" ,dispatchingScore);
//    NSLog(@"installScore=%@" ,installScore);
//
//    if (self.textView.text.length < 1) {
//        [self showToastError:@"请输入您的评价内容"];
//        return;
//    }
//
//
    for (int i = 0 ; i < self.dataArray.count; i++) {
        KDSEvaliateModel * model = (KDSEvaliateModel *)self.dataArray[i];
        if ([KDSMallTool checkISNull:model.content].length <= 0) {
                [self showToastError:@"请输入您的评价内容"];
                return;
        }
    }
    
    NSMutableArray  * imageArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        KDSEvaliateModel * model = self.dataArray[i];
        if (model.imageArray.count > 0) {
            [imageArray addObject:model.imageArray];
        }
    }
    
//    NSLog(@"%@----%ld",imageArray,imageArray.count);
    
    if (imageArray.count > 0) {//有图片
        dispatch_group_t  group = dispatch_group_create();
        for (int i = 0; i < imageArray.count; i++) {
            NSArray * array =  imageArray[i];
             KDSEvaliateModel * model = self.dataArray[i];
             model.imagesArray = [NSMutableArray array];
            for (int j = 0 ; j < array.count; j++) {
                UIImage * image =  array[j];
                dispatch_group_enter(group);
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [KDSNetworkManager POSTUploadDatawithPics:image progress:^(NSProgress * _Nullable uploadProgress) {
                        
                    } success:^(NSInteger code, id  _Nullable json) {
                         dispatch_group_leave(group);
                        NSLog(@"%d--%d",i,j);
                       KDSEvaliateModel * model = self.dataArray[i];
                        [model.imagesArray addObject:[KDSMallTool checkISNull:json[@"data"][@"fileRewriteFullyQualifiedPath"]]];
                    } failure:^(NSError * _Nullable error) {
                        
                    }];
                });
            }
    
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"所有请求完成，进行下一步操作");
            [self saveContent];
        });
        
        
    }else{//无图片
       [self saveContent];
    }

}

-(void)saveContent{
        NSMutableArray *listArr = [NSMutableArray array];
        for (KDSEvaliateModel * model in self.dataArray) {
    
            NSString *productId = [NSString stringWithFormat:@"%@" ,[KDSMallTool checkISNull:model.productId]];
            NSString *productLabels = [NSString stringWithFormat:@"%@" ,[KDSMallTool checkISNull:model.productLabels]];
            NSString *indentId = [NSString stringWithFormat:@"%@" ,[KDSMallTool checkISNull:model.indentId]];
    
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            [dic setValue:productId forKey:@"productId"];
            [dic setValue:productLabels forKey:@"productLabels"];
            [dic setValue:indentId forKey:@"indentId"];
    
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)model.productScore] forKey:@"score"];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)model.conformityScore] forKey:@"conformityScore"];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)model.dispatchingScore] forKey:@"dispatchingScore"];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)model.installScore] forKey:@"installSatisfiedScore"];
            [dic setValue:[KDSMallTool checkISNull:model.content] forKey:@"content"];
            [dic setValue:[KDSMallTool checkISNull:model.isAnonymous] forKey:@"isAnonymous"];
            if (model.imagesArray.count > 0) {
                   NSString * idString = [model.imagesArray componentsJoinedByString:@","];
                [dic setValue:idString forKey:@"imgs"];
            }else{
                 [dic setValue:@"" forKey:@"imgs"];
            }
            //imgs 没有
    
            [listArr addObject:dic];
        }
    
        NSLog(@"参数数组=%@" ,listArr);
        NSDictionary *dic = @{@"params":@{@"list":listArr},@"token":ACCESSTOKEN};
        [self submitDataWithBlock:@"tbComment/save" partemer:dic Success:^(id responseObject) {
            NSLog(@"responseObject=%@" ,responseObject);
            if ([self isSuccessData:responseObject]) {
                [self.navigationController popViewControllerAnimated:YES];
                if (self.comentBlock) {
                    self.comentBlock();
    
                }
            }
        }];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//-(void)addUI{
//
//
//    UIImageView *imgV= [[UIImageView alloc]init];
//    imgV.backgroundColor = KViewBackGroundColor;
//    [self.contentView addSubview:imgV];
//    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
//
//    UILabel* scoreLab = [[UILabel alloc]init];
//    scoreLab.text = @"产品评分";
//    scoreLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
//    scoreLab.textAlignment = NSTextAlignmentLeft;
//    scoreLab.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:scoreLab];
//    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(imgV.mas_right).mas_offset(20);
//        make.top.mas_equalTo(self.contentView.mas_top);
//        make.size.mas_equalTo(CGSizeMake(65, 60));
//    }];
//
//    self.topStarView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
//        NSLog(@"\n\n给了铁哥哥：%ld星好评！！!\n\n",count);
//        score = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
//    }];
//    [self.contentView addSubview:self.topStarView];
//    self.topStarView.spacing = 0.35;
//    self.topStarView.starCount = 5;
//    [self.topStarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(scoreLab.mas_right);
//        make.top.mas_equalTo(self.contentView.mas_top);
//        make.size.mas_equalTo(CGSizeMake(190, 60));
//    }];
//
//    UILabel *topL = [[UILabel alloc]init];
//    topL.backgroundColor = KViewBackGroundColor;
//    [self.contentView addSubview:topL];
//    [topL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.contentView);
//        make.right.mas_equalTo(-15);
//        make.top.mas_equalTo(60);
//        make.height.mas_equalTo(1);
//    }];
//
//    self.textView = [[UITextView alloc] init];
//    self.textView.font = [UIFont systemFontOfSize:15];
////    self.textView.backgroundColor = KViewBackGroundColor;
//    [self.contentView addSubview:self.textView];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.top.mas_equalTo(topL.mas_bottom).mas_offset(20);
//        make.height.mas_equalTo(110);
//    }];
//    UILabel *placeHolderLabel = [[UILabel alloc] init];
//    placeHolderLabel.text = @"请输入您的评价内容";
//    placeHolderLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
////    [placeHolderLabel sizeToFit];
//    [self.textView addSubview:placeHolderLabel];
//    placeHolderLabel.font = [UIFont systemFontOfSize:15];
//    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
//    [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(self.textView);
//        make.height.mas_equalTo(15);
//    }];
//
//    UIButton *firstBtn;
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
////        btn.idString = @"0";
//        btn.tag = 1000+i;
//        [self.contentView addSubview:btn];
//        [arr addObject:btn];
//        if (i == 0) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"icon_camera_add"] forState:UIControlStateNormal];
//            firstBtn = btn;
//        }
//    }
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:KSCREENWIDTH-60-180];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(0);
//        make.height.mas_equalTo(60);
//    }];
//
//
//    UILabel *midL = [[UILabel alloc]init];
//    midL.backgroundColor = KViewBackGroundColor;
//    [self.contentView addSubview:midL];
//    [midL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(firstBtn.mas_bottom).mas_offset(20);
//        make.height.mas_equalTo(15);
//    }];
//
//
//
//    NSArray *arrs = @[@"商品符合度",@"配送速度",@"安装满意度"];
//    for (int i = 0; i < arrs.count; i ++) {
//        UILabel* lab = [[UILabel alloc]init];
//        lab.text = arrs[i];
////        lab.backgroundColor = [UIColor purpleColor];
//        lab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
//        lab.textAlignment = NSTextAlignmentLeft;
//        lab.font = [UIFont systemFontOfSize:15];
//        [self.contentView addSubview:lab];
//        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.top.mas_equalTo(midL.mas_bottom).mas_offset(10+i*50);
//            make.size.mas_equalTo(CGSizeMake(80, 50));
//        }];
//
//        if (i==0) {
//            fuheView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
//                NSLog(@"\n\n给了铁哥：%ld星好评！！!\n\n",count);
//                conformityScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
//            }];
//            fuheView.starCount = 5;
//            [self.contentView addSubview:fuheView];
//            fuheView.spacing = 0.35;
//            [fuheView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(lab.mas_right).mas_offset(10);
//                make.top.mas_equalTo(lab.mas_top);
//                make.size.mas_equalTo(CGSizeMake(200, 50));
//            }];
//        }if (i==1) {
//            peisongView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
//                NSLog(@"\n\n给了铁哥：%ld星好评！！!\n\n",count);
//                dispatchingScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
//            }];
//            peisongView.starCount = 5;
//            [self.contentView addSubview:peisongView];
//            peisongView.spacing = 0.35;
//            [peisongView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(lab.mas_right).mas_offset(10);
//                make.top.mas_equalTo(lab.mas_top);
//                make.size.mas_equalTo(CGSizeMake(200, 50));
//            }];
//        }if (i==2) {
//            manyiView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
//                NSLog(@"\n\n给了铁哥：%ld星好评！！!\n\n",count);
//                installScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
//            }];
//            manyiView.starCount = 5;
//            [self.contentView addSubview:manyiView];
//            manyiView.spacing = 0.35;
//            [manyiView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(lab.mas_right).mas_offset(10);
//                make.top.mas_equalTo(lab.mas_top);
//                make.size.mas_equalTo(CGSizeMake(200, 50));
//            }];
//        }
//
////        StarEvaluationView *starView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
////            NSLog(@"\n\n给了铁哥：%ld星好评！！!\n\n",count);
////            NSLog(@"tag=%ld" ,(long)starView.tag);
////            conformityScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
////            dispatchingScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
////            installScore = [NSString stringWithFormat:@"%lu" ,(unsigned long)count];
////
////        }];
////        starView.starCount = 5;
////        [self.contentView addSubview:starView];
////        starView.tag = 1000+i;
////        starView.spacing = 0.35;
////        [starView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.mas_equalTo(lab.mas_right).mas_offset(10);
////            make.top.mas_equalTo(lab.mas_top);
////            make.size.mas_equalTo(CGSizeMake(200, 50));
////        }];
////
//
//
//    }
//
//
//
//    UIView *botL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentView.frame), KSCREENWIDTH, 80)];
//    botL.backgroundColor = KViewBackGroundColor;
//    [self.contentView addSubview:botL];
//
//    UIButton *btn = [[CustomBtn alloc]initWithBtnFrame:CGRectMake(15,CGRectGetMaxY(self.contentView.frame), 90, 40) btnType:ButtonImageLeft titleAndImageSpace:10 imageSizeWidth:15 imageSizeHeight:15];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [btn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"产品选中"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(hideNameAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
//    [btn setTitle:@"匿名评价" forState:UIControlStateNormal];
//    [self.contentView addSubview: btn];
//    [btn setSelected:YES];
//    hideName = YES;
//
//    CGFloat botH =CGRectGetMaxY(btn.frame);
//    NSLog(@"botH===%f" ,botH);
//    self.contentView.frame = CGRectMake(0, 0, KSCREENWIDTH, botH);
//    self.myscrollView.frame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, botH);
//    self.myscrollView.contentSize =CGSizeMake(KSCREENWIDTH, botH+40);
//
//}
//
//-(void)hideNameAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    hideName = sender.selected;
//}
//
////这里三个按钮进来都能点击  需要做处理
//-(void)btnClick:(UIButton *)sender{
//
//    [self pickImageWithCompletionHandler:^(NSData *imageData, UIImage *image) {
//        [sender setBackgroundImage:image forState:UIControlStateNormal];
//        sender.userInteractionEnabled = NO;
//        if (sender.tag <1002) {
//            UIButton *btn = [self.view viewWithTag:sender.tag +1];
//            [btn setBackgroundImage:[UIImage imageNamed:@"pic_add_contact"] forState:UIControlStateNormal];
//        }
//    }];
//}
//
//
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
//
//-(void)submitActon{
//
//    NSString *isAnonymous = @"false";
//    if (hideName) {
//        NSLog(@"匿名");
//        isAnonymous = @"true";
//    }
//
//    NSLog(@"self.indeInfoArr=%@" ,self.indeInfoArr);
//
//    NSLog(@"score=%@" ,score);
//    NSLog(@"conformityScore=%@" ,conformityScore);
//    NSLog(@"dispatchingScore=%@" ,dispatchingScore);
//    NSLog(@"installScore=%@" ,installScore);
//
//    if (self.textView.text.length < 1) {
//        [self showToastError:@"请输入您的评价内容"];
//        return;
//    }
//
//
//    NSMutableArray *listArr = [NSMutableArray array];
//    for (NSMutableDictionary *allDic in self.indeInfoArr) {
//
//        NSString *productId = [NSString stringWithFormat:@"%@" ,allDic[@"productId"]];
//        NSString *productLabels = [NSString stringWithFormat:@"%@" ,allDic[@"productLabels"]];
//        NSString *indentId = [NSString stringWithFormat:@"%@" ,allDic[@"indentId"]];
//
//        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
//        [dic setValue:productId forKey:@"productId"];
//        [dic setValue:productLabels forKey:@"productLabels"];
//        [dic setValue:indentId forKey:@"indentId"];
//
//        [dic setValue:score forKey:@"score"];
//        [dic setValue:conformityScore forKey:@"conformityScore"];
//        [dic setValue:dispatchingScore forKey:@"dispatchingScore"];
//        [dic setValue:installScore forKey:@"installSatisfiedScore"];
//        [dic setValue:self.textView.text forKey:@"content"];
//        [dic setValue:isAnonymous forKey:@"isAnonymous"];
//        [dic setValue:@"" forKey:@"imgs"];
//
//        //imgs 没有
//
//        [listArr addObject:dic];
//    }
//
//    NSLog(@"参数数组=%@" ,listArr);
//    NSDictionary *dic = @{@"params":@{@"list":listArr},@"token":ACCESSTOKEN};
//    [self submitDataWithBlock:@"tbComment/save" partemer:dic Success:^(id responseObject) {
//        NSLog(@"responseObject=%@" ,responseObject);
//        if ([self isSuccessData:responseObject]) {
//            [self.navigationController popViewControllerAnimated:YES];
//            if (self.comentBlock) {
//                self.comentBlock();
//
//            }
//        }
//    }];
//
//}
@end
