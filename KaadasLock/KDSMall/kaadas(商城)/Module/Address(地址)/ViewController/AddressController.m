//
//  AddressController.m
//  Rent3.0
//
//  Created by Apple on 2018/7/31.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "AddressController.h"
#import "AddressListCell.h"
#import "EditAddressController.h"
#import "KDSAddressHttp.h"
#import "CustomBtn.h"
#import "KDSAddressListModel.h"


@interface AddressController ()<UITableViewDataSource ,UITableViewDelegate>{
    int dataPage;

}

@property(nonatomic,strong)NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView.backTitle = @"地址管理";
    dataPage=1;

    [self addTableView];
    [self.tableView.mj_header beginRefreshing];
    [self addRightItem];
}
-(void)addRightItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+新建地址" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    //    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 85, 30);
    [btn addTarget:self action:@selector(addBut) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = btn;
}

#pragma mark - 下拉刷新
-(void)addressListHeaderRefresh{
    dataPage = 1;
    [self addressListData];
}

#pragma mark - 上拉加载更多
-(void)addressListFooterRefresh{
    dataPage++;
    [self addressListData];
}

-(void)addressListData{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary *dic= @{@"token":[KDSMallTool checkISNull:userToken],
                         @"page":@{@"pageSize":@"10",
                                   @"pageNum":[NSNumber numberWithInteger:dataPage]
                                   }
                         };


    __weak typeof(self)weakSelf = self;
    
    [KDSAddressHttp userAddressListWithParams:dic success:^(BOOL isSuccess, id  _Nonnull obj) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            weakSelf.tableView.mj_footer.hidden = NO;
            KDSAddressListModel * model = (KDSAddressListModel *)obj;
            NSArray * array = model.list;
            if (self->dataPage == 1) {
                [weakSelf.listArray removeAllObjects];
                [weakSelf.tableView.mj_footer resetNoMoreData];
            }
            
            [weakSelf.listArray addObjectsFromArray:array];
            [weakSelf.tableView reloadData];
            
            if (model.total <= weakSelf.listArray.count) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        if ([weakSelf.tableView.mj_header isRefreshing]) [weakSelf.tableView.mj_header endRefreshing];
        if ([weakSelf.tableView.mj_footer isRefreshing]) [weakSelf.tableView.mj_footer endRefreshing];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
}


//-(void)loadData:(LoadState)loadState{
//    [super loadData:loadState];
//    self.listArray = [NSMutableArray array];
////    NSDictionary *dic1=@{@"userId":[userDefaults objectForKey:@"userToken"]};
////    NSDictionary *dic = @{@"param":dic1};
//
//    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    NSDictionary *dic= @{@"token":userToken,@"page":@{@"pageSize":@"10",@"pageNum":[NSNumber numberWithInteger:dataPage]}};
//
//    [self loadDataWithBlock:loadState url:addresslist partemer:dic Success:^(id responseObject) {
//        NSLog(@"列表==%@" ,responseObject);
//        if ([self isSuccessData:responseObject]) {
//            //移到异步线程做
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSMutableArray *dataArr = [responseObject objectForKey:@"data"];
//                NSMutableArray * modalArr = [NSMutableArray array];
//                for (NSDictionary *dataDic in dataArr) {
//                    DetailModel *dataModel =[[DetailModel alloc]initWithDictionary:dataDic];
//                    [modalArr addObject:dataModel];
//                }
//                [self.listArray addObjectsFromArray:modalArr];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//
//                });
//            });
//        }
//
//    }];
//}


-(void)addTableView{
    
//        UIButton * addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//         addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [addBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
//        addBtn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
//        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [addBtn addTarget:self action:@selector(addBut) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:addBtn];
//        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.view);
//            make.height.mas_equalTo(50);
//            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-MhomeBarH);
//        }];

        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(self.navigationBarView.mas_bottom);
//            make.bottom.mas_equalTo(addBtn.mas_top);
        }];
    
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
    if (section == 0) {
        return 0.1;
    }
    return 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
//    static NSString * identy = @"foot";
//    UITableViewHeaderFooterView * footV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
//
//    if (!footV) {
//       NSLog(@"section=%li",section);
//        footV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
        UIView *footV =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 50)];
        footV.backgroundColor = [UIColor whiteColor];
        footV.tag = section + 100;
//        [footV addSubview:view];
        
        UIButton *btn = [[CustomBtn alloc]initWithBtnFrame:CGRectMake(0,0, 153, 50) btnType:ButtonImageLeft titleAndImageSpace:10 imageSizeWidth:15 imageSizeHeight:15];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [footV addSubview: btn];
        btn.tag = 1000+section;
        [btn addTarget:self action:@selector(defaultAddress:) forControlEvents:UIControlEventTouchUpInside];
        KDSAddressListRowModel *model =self.listArray[section];
        NSString *sattus = [NSString stringWithFormat:@"%@" ,model.isDefault];
        NSLog(@"sattus=%@" ,sattus);
        if ([sattus isEqualToString:@"1"]) {
            [btn setImage:[UIImage imageNamed:@"产品选中"] forState:UIControlStateNormal];
        }
        
        
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        delBtn.tag = 3000+section;
        [delBtn setImage:[UIImage imageNamed:@"icon_mian_del"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
        [footV addSubview:delBtn];
        [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(footV.mas_right);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(footV.mas_centerY);
        }];
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.tag = 2000+section;
        [editBtn setImage:[UIImage imageNamed:@"icon_mian_editor"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        [footV addSubview:editBtn];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(delBtn.mas_left).mas_offset(-7);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(footV.mas_centerY);
        }];
  
//    }
    
    return footV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"addressList";
    AddressListCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil) {
        cell = [[AddressListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailModel = self.listArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSAddressListRowModel *model =self.listArray[indexPath.section];
    if (self.chooseBlock) {
        self.chooseBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }

}


#pragma makr 默认收货地址
-(void)defaultAddress:(UIButton *)control{
    KDSAddressListRowModel * model = self.listArray[control.tag - 1000];
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * dictionary = @{@"params":@{@"id":@(model.ID)},
                                  @"token":[KDSMallTool checkISNull:userToken]
                                  };

    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:setDefaultAddress paramsDict:dictionary success:^(NSInteger code, id  _Nullable json) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (code == 1) {
            [KDSProgressHUD showSuccess:@"设置成功" toView:self.view completion:^{
                
            }];
            [weakSelf.tableView.mj_header beginRefreshing];
        }else{
            [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{

            }];
        }
    } failure:^(NSError * _Nullable error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{

        }];
    }];
    
    
}

#pragma makr 编辑收货地址
-(void)editAddress:(UIControl *)control{
    NSLog(@"tag :   %ld",control.tag - 2000);
    KDSAddressListRowModel *model =self.listArray[control.tag - 2000];
    NSLog(@"%@---%ld",model.name,(long)model.ID);
    EditAddressController *editAddressVC =[[EditAddressController alloc]init];
    editAddressVC.enterType = @"编辑";
    editAddressVC.dataModel = model;
    editAddressVC.addBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:editAddressVC animated:YES];
    
}

#pragma makr 删除收货地址
-(void)deleteAddress:(UIControl *)control{
    
    __weak typeof(self)weakSelf = self;
    [KDSMallAC alertControllerWithTitle:@"提示" message:@"确定删除吗?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
        KDSAddressListRowModel *model =self.listArray[control.tag - 3000];
        NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        NSDictionary * dictionary = @{@"params":@{@"id":@[@(model.ID)]},  //int 收货地址信息主键id
                                       @"token":[KDSMallTool checkISNull:userToken]
                                      };
        [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
        [KDSNetworkManager POSTRequestBodyWithServerUrlString:deleteAddress paramsDict:dictionary success:^(NSInteger code, id  _Nullable json) {
            [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
            if (code == 1) {
                [weakSelf.tableView.mj_header beginRefreshing];
            }else{
                [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{}];
            }
        } failure:^(NSError * _Nullable error) {
            [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
            [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
        }];

    } cancelBlock:^{
        
    }];
}



#pragma makr 添加收货地址
-(void)addBut{
    EditAddressController *editAddressVC =[[EditAddressController alloc]init];
    editAddressVC.enterType = @"添加";
    editAddressVC.addBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:editAddressVC animated:YES];
}



#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.estimatedRowHeight = 175;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(addressListHeaderRefresh)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addressListFooterRefresh)];
        _tableView.mj_footer.hidden = YES;
        // 设置了底部inset
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 忽略掉底部inset
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = isIPHONE_X ? 34 : 10;
    }
    return _tableView;
}

-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
