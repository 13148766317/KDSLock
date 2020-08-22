//
//  KDSShopCartViewController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/6.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSShopCartController.h"
#import "StoreCell.h"
#import "StoreModel.h"
#import "CustomBtn.h"
#import "ShopCarDetailController.h"
#import "KDSProductDetailNormalController.h"
#import "KDSBindingPhoneNumController.h"

#import "KDSLoginViewController.h"

@interface KDSShopCartController ()<UITableViewDataSource ,UITableViewDelegate,StoreCellDelegate>
{
    UIButton *submitBtn;
    CustomBtn *allSelectBtn;
    UILabel *allPriceLab;
    UIView *footView;
}
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *selectArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KDSShopCartController


- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(shopCartHeaderRefresh)];
//        _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
//        }];
        _tableView.estimatedRowHeight = 130;
        
    }
    return _tableView;
}
-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_hiddenArrow) {
           self.navigationBarView.backImage = nil;
    }else{
        
    }

    self.navigationBarView.backTitle = @"购物车";
    self.loadingViewFrame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT-MnavcBarH);
    [self addTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSelf) name:@"刷新购物车" object:nil];
    
}

#pragma mark - 下拉刷新
-(void)shopCartHeaderRefresh{
    [self refreshSelf];
}
-(void)refreshSelf{
    [self loadData:refreshData];
}

-(void)setHeaderFooterRefresh{
    
        self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//                dataPage = 1;
                [self loadData:refreshData];
            } completion:^(BOOL finished) {
                [self.tableView.mj_header endRefreshing];
    
            }];
        }];
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
////            dataPage += 1;
//            [self loadData:refreshData];
//        } completion:^(BOOL finished) {
//            [self.tableView.mj_footer endRefreshing];
//        }];
//
//    }];
    
}

-(void)addRightItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"管理" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = btn;
}


-(void)loadData:(LoadState)loadState{
    [super loadData:loadState];
    NSDictionary *dic = @{@"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
    [self loadDataWithBlock:loadState url:@"shopcar/list" partemer:dic Success:^(id responseObject) {
        NSLog(@"订单列表=%@" ,responseObject);
        [self dealData:responseObject];
    }];
}

-(void)dealData:(id)responseObject{
    self.listArray = [NSMutableArray array];
    if ([self isSuccessData:responseObject]) {
        NSMutableArray *dataArr =  [[responseObject objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray * modalArr = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            StoreModel *dataModel =[[StoreModel alloc]initWithDictionary:dataDic];
            [modalArr addObject:dataModel];
        }
        [self.listArray addObjectsFromArray:modalArr];
        NSLog(@"count==%lu" ,(unsigned long)self.listArray.count);
        [self.tableView reloadData];
    }
    if (self.listArray.count  >0) {
        [self addFootView];
        [self addRightItem];
    }else{
        NSLog(@"无数据");
        self.navigationBarView.rightItem.hidden = YES;
        [self setDefaultView:cart_missing_pages alertLable:@"" reloadData:NO];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 10)];
    label.backgroundColor =KViewBackGroundColor;
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 10)];
    label.backgroundColor =KViewBackGroundColor;
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"indentify";
    StoreCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StoreCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    if (self.listArray.count > 0) {
        cell.storeModel = self.listArray[indexPath.section];
        
    }
    cell.selectBtn.tag = 1000+indexPath.section;
    [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

//选中按钮点击事件
-(void)selectBtnAction:(UIButton*)sender{
    
    NSInteger aSection = sender.tag - 1000;
    StoreModel *model = self.listArray[aSection];
    if (model.isSelectState)
    {
        model.isSelectState = NO;
    }
    else
    {
        model.isSelectState = YES;
    }
    
    //刷新当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:aSection];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //    //回到之前位置
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionNone) animated:NO];
    //    });
    //
    
    /** 指定section的最顶部的rect */
    [self.tableView rectForSection:aSection];
    /** 指定cell的rect */
    [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:aSection]];

    [self allTotalPrice];
    
    NSMutableArray *aaa = [NSMutableArray array];
    for (StoreModel *amodel in self.listArray) {
        if (amodel.isSelectState) {
            [aaa addObject:amodel];
        }
    }
    NSLog(@"selectNum=%lu" ,(unsigned long)aaa.count);
    if (aaa.count == self.listArray.count) {
        [self allSelectClick];
    }else{
        [allSelectBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
        allSelectBtn.selected = NO;
    }
}


//加减按钮
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //获取到当期行数据源内容，改变数据源内容，刷新表格
            StoreModel *model = self.listArray[index.section];
            if (model.qty > 1)
            {
                model.qty --;
            }
        }
            break;
        case 12:
        {
            //做加法
            StoreModel *model = self.listArray[index.section];
            model.qty ++;
        }
            break;
            
        default:
            
            break;
            
    }
    StoreModel *aamodel = self.listArray[index.section];
    [self updateCount:aamodel];
    
    //刷新当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index.section];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //    //回到之前位置
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionNone) animated:NO];
    //    });
    //
    
    /** 指定section的最顶部的rect */
    [self.tableView rectForSection:index.section];
    /** 指定cell的rect */
    [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index.section]];
    
    [self allTotalPrice];
    
}

-(void)updateCount:(StoreModel *)model{
    NSDictionary *dic1=@{@"id":model.myId,@"qty":[NSString stringWithFormat:@"%ld" ,(long)model.qty]};
    NSDictionary *dic=@{@"params":dic1,@"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
    [JavaNetClass JavaNetRequestWithPort:@"shopcar/updateQty" andPartemer:dic Success:^(id responseObject) {
        NSLog(@"responseObject=%@" ,responseObject);
    }];
}

-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        if (self.navigationController.viewControllers.count <= 1) {
            make.bottom.mas_equalTo(-50);
        }else{
            make.bottom.mas_equalTo(isIPHONE_X ? -84 : -50);
        }
    }];
    
    [self  setHeaderFooterRefresh];
}

-(void )addFootView{
    
    if (footView!=nil) {
        [footView removeFromSuperview];
    }
    
    footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.navigationController.viewControllers.count <= 1) {
            make.bottom.mas_equalTo(0);
        }else{
            make.bottom.mas_equalTo(isIPHONE_X ? - 34 : 0);
        }
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 50));
    }];
    
    
    allSelectBtn= [[CustomBtn alloc]initWithBtnFrame:CGRectMake(15,0, 65, 50) btnType:ButtonImageLeft titleAndImageSpace:13 imageSizeWidth:15 imageSizeHeight:15];
    allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    allSelectBtn.backgroundColor = [UIColor cyanColor];
    [allSelectBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
    [allSelectBtn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
    [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectBtn addTarget:self action:@selector(allSelectClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview: allSelectBtn];
    
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"去结算" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:submitBtn];
    submitBtn.layer.cornerRadius = 40 / 2;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    allPriceLab = [[UILabel alloc]init];
    allPriceLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
    allPriceLab.font = [UIFont systemFontOfSize:18];
    allPriceLab.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:allPriceLab];
    [allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.centerX.mas_equalTo(footView.mas_centerX).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-250, 50));
    }];
    [self addAttibute:@"¥0"];
    
}

#pragma  计算价格给总价文本赋值

-(void)addAttibute:(NSString *)priceS{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString: [@"合计: " stringByAppendingString:priceS]];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#333333"] range:NSMakeRange(0, 3)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(4, 1)];
    allPriceLab.attributedText = AttributedStr;
    
}

-(void)allSelectClick
{
    NSLog(@"全部选中");
    allSelectBtn.selected = !allSelectBtn.selected;
    
    if (allSelectBtn.selected)
    {
        [allSelectBtn setImage:[UIImage imageNamed:@"selectbox_select"] forState:UIControlStateNormal];
        
    }else{
        [allSelectBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
    }
    //改变单元格选中状态
    for (int i=0; i<self.listArray.count; i++)
    {
        StoreModel *model = [self.listArray objectAtIndex:i];
        model.isSelectState = allSelectBtn.isSelected;
    }
    
    //计算价格
    [self allTotalPrice];
    //刷新
    [self.tableView reloadData];
    
}

//计算价格
-(void)allTotalPrice
{
    float allPrice = 0.0;
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for ( int i =0; i<self.listArray.count; i++)
    {
        StoreModel *model = [self.listArray objectAtIndex:i];
        if (model.isSelectState)
        {
            allPrice = allPrice + model.qty *[model.price floatValue];
        }
    }
    //总价文本赋值
    [self addAttibute:[NSString stringWithFormat:@"¥%.f",allPrice]];
    NSLog(@"总价=%f",allPrice);
}


-(void)editAction:(UIButton *)sender{
    
    NSLog(@"title=%@" ,self.navigationItem.rightBarButtonItem.title);
    if ([sender.titleLabel.text isEqualToString:@"管理"]) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [self deleteItem];
    }else{
        [sender setTitle:@"管理" forState:UIControlStateNormal];
        [self resetDeleteItem];
    }
}
-(void)deleteItem{
    [submitBtn setTitle:@"删除" forState:UIControlStateNormal];
    allPriceLab.hidden = YES;

}
-(void)resetDeleteItem{
    [submitBtn setTitle:@"去结算" forState:UIControlStateNormal];
    allPriceLab.hidden = NO;
}

-(void)submitAction:(UIButton *)sender{
    
    self.selectArray = [NSMutableArray array];
    for (StoreModel *model in self.listArray) {
        if (model.isSelectState) {
            NSInteger selectIndex = [self.listArray indexOfObject:model];
            NSLog(@"选中的行=%ld" ,(long)selectIndex);
            NSLog(@"myId=%@" ,model.myId);
            [self.selectArray addObject:model.myId];
        }
    }
    NSLog(@"selectArray=%@" ,self.selectArray);
    
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        if (self.selectArray.count <1) {
            [self showToastError:@"请选择要删除的商品"];
            return;
        }
        [self deleteAction];  //删除
        
    }else{
        NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        QZUserModel * userModel = [QZUserArchiveTool loadUserModel];
        
//        if (([KDSMallTool checkISNull:userToken].length <=0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)) {//未授权 未绑定手机号
////            WxLoginController * wxloginVC = [[WxLoginController alloc]init];
//            KDSLoginViewController * wxloginVC = [[KDSLoginViewController alloc]init];
//
//            [self presentViewController:wxloginVC animated:YES completion:^{
//                
//            }];
//            return;
//        }else if (([KDSMallTool checkISNull:userToken].length >0 ) && ([KDSMallTool checkISNull:userModel.tel].length <= 0)){//已授权  未绑定手机号
//            KDSBindingPhoneNumController * bindPhoneVC = [[KDSBindingPhoneNumController alloc]init];
//            [self presentViewController:bindPhoneVC animated:YES completion:^{ }];
//            return;
//        }else{
//            
//        }
        
        
        if (self.selectArray.count <1) {
            [self showToastError:@"请选择要购买的商品"];
            return;
        }
        
        [self buyAction]; //结算
    }
    
}

-(void)deleteAction{
    
    NSDictionary *dic=@{@"params":@{@"shopcarIds":self.selectArray} ,@"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
    [JavaNetClass JavaNetRequestWithPort:@"shopcar/delete" andPartemer:dic Success:^(id responseObject) {
        if ([self isSuccessData:responseObject]) {
            [self showToastSuccess:@"删除成功"];
            [self loadData:refreshData];
        }
    }];
}

-(void)buyAction{
    NSLog(@"self.selectArray: %@",self.selectArray);
    ShopCarDetailController *detailVC=[[ShopCarDetailController alloc]init];
    detailVC.productIDArray = self.selectArray;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel *model = self.listArray[indexPath.section];
    NSLog(@"myId=%@" ,model.myId);
    KDSSecondPartRowModel * rowModel  = [[KDSSecondPartRowModel alloc]init];
    rowModel.ID = model.agentProductId;
    KDSProductDetailNormalController   * productDetaiVC = [[KDSProductDetailNormalController alloc]init];
    productDetaiVC.rowModel =  rowModel;
    [self.navigationController pushViewController:productDetaiVC animated:YES];

}

@end
