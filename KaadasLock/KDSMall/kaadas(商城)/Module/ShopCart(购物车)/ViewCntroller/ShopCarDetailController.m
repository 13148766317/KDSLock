//
//  ShopCarDetailController.m
//  kaadas
//
//  Created by Apple on 2019/5/18.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "ShopCarDetailController.h"
#import "OrderListCell.h"
#import "TotallCell.h"
#import "DefaultAdrCell.h"
#import "UIButton+NSString.h"
#import "CustomBtn.h"
#import "AddressController.h"
#import "MyDateTimeView.h"
#import "OrderListController.h"
#import "KDSTabBarController.h"

#import "KDSPayController.h"
#import "KDSActivityOrderController.h"
#import "KDSCouponsVC.h"
#import "KDSCoupon1Model.h"

@interface ShopCarDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *bottomLab;
    UITextField *msgField;
    
    
    NSString *totalQty;
    NSString *totalPrice;
    NSString *remark;
    NSString *couponValue;
    NSString * couponID;

}
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) MyDateTimeView *dateView;

@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSMutableArray *dataArrR;
@property (nonatomic, strong) NSString       *installDate;
@property (nonatomic,copy)NSString           * moneyShow;
@property (nonatomic,strong)NSMutableArray   * couponArray;

@end

@implementation ShopCarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    couponID = @"";
    self.navigationBarView.backTitle = @"填写订单";
    [self addTableView];
    self.loadingViewFrame =CGRectMake(0, MnavcBarH, KSCREENWIDTH, KSCREENHEIGHT - MnavcBarH);
    
    if (_type == KDSProductDetail_noraml) {
        //请求优惠券列表
        [self getCouponList:^(NSArray *array) {}];
    }
}

-(NSMutableArray *)modelArr{
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _modelArr;
}
-(NSMutableArray *)addressArray{
    if (_addressArray == nil) {
        _addressArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _addressArray;
}
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.estimatedRowHeight = 115;
    }
    return _tableView;
}


-(void)loadData:(LoadState)loadState{
    [super loadData:loadState];
    NSDictionary *dic =  nil;
    if (_type == KDSProductDetail_noraml) {
         dic =   @{@"params":@{@"shopcarIds":self.productIDArray}, @"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
        [self loadDataWithBlock:loadState url:@"indent/previewBaseIndent" partemer:dic Success:^(id responseObject) {
            NSLog(@"订单详情=%@" ,responseObject);
            
            totalQty = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"totalQty"]]; //商品总数
            totalPrice = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"totalPrice"]];//商品总价
            
            if ([[[responseObject objectForKey:@"data"] allKeys]containsObject:@"coupon"]) {
                remark = [NSString stringWithFormat:@"%@" ,[[[responseObject objectForKey:@"data"] objectForKey:@"coupon"] objectForKey:@"remark"]];//优惠券描述
                couponValue = [NSString stringWithFormat:@"%@" ,[[[responseObject objectForKey:@"data"] objectForKey:@"coupon"] objectForKey:@"couponValue"]];//优惠券金额
                couponID = [NSString stringWithFormat:@"%@" ,[[[responseObject objectForKey:@"data"] objectForKey:@"coupon"] objectForKey:@"id"]];//优惠券ID
            }
            
            NSMutableArray *dataArr =  [[responseObject objectForKey:@"data"] objectForKey:@"shopcar"];
            for (NSDictionary *dataDic in dataArr) {
                DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:dataDic];
                [self.modelArr addObject:detailModel];
                
                detailModel.productName =[NSString stringWithFormat:@"%@" ,dataDic[@"skuProductName"]];
                detailModel.productLabels =[NSString stringWithFormat:@"%@" ,dataDic[@"attributeComboName"]];
                NSString *priceS=[NSString stringWithFormat:@"¥%@" ,dataDic[@"price"]];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
                detailModel.priceAtribute = AttributedStr;
                
                self.dataArrR = [NSMutableArray arrayWithObjects:totalPrice,[KDSMallTool checkISNull:couponValue], nil];
                
            }
//            NSLog(@"count==%lu" ,(unsigned long)self.modelArr.count);
            [self setAddress:responseObject];
            [self setShowPrice];
            
            [self.tableView reloadData];
            
        }];
    }else{
        dic = @{
            @"params":_activityDict,
            @"token": [KDSMallTool checkISNull:ACCESSTOKEN]                     //（必填）（str）
        };
        
        [self loadDataWithBlock:loadState url:@"indent/previewActivityIndent" partemer:dic Success:^(id responseObject) {
            NSLog(@"活动商品预览:%@",responseObject);
            
            totalQty = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"totalQty"]]; //商品总数
            totalPrice = [NSString stringWithFormat:@"%@" ,[[responseObject objectForKey:@"data"] objectForKey:@"totalPrice"]];//商品总价
            
            if ([[[responseObject objectForKey:@"data"] allKeys]containsObject:@"coupon"]) {
                remark = [NSString stringWithFormat:@"%@" ,[[[responseObject objectForKey:@"data"] objectForKey:@"coupon"] objectForKey:@"remark"]];//优惠券描述
                couponValue = [NSString stringWithFormat:@"%@" ,[[[responseObject objectForKey:@"data"] objectForKey:@"coupon"] objectForKey:@"couponValue"]];//优惠券金额
            }
            
//            NSMutableArray *dataArr =  [[responseObject objectForKey:@"data"] objectForKey:@"shopcar"];
//            for (NSDictionary *dataDic in dataArr) {
            NSDictionary *dataDic = responseObject[@"data"][@"agentProduct"];
                DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:dataDic];
                [self.modelArr addObject:detailModel];
                
                detailModel.productName =[NSString stringWithFormat:@"%@" ,dataDic[@"skuProductName"]];
                detailModel.productLabels =[NSString stringWithFormat:@"%@" ,dataDic[@"attributeComboName"]];
                NSString *priceS=[NSString stringWithFormat:@"¥%@" ,dataDic[@"price"]];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
                detailModel.priceAtribute = AttributedStr;
                
                self.dataArrR = [NSMutableArray arrayWithObjects:totalPrice,[KDSMallTool checkISNull:couponValue], nil];
                
//            }
//            NSLog(@"count==%lu" ,(unsigned long)self.modelArr.count);
            [self setAddress:responseObject];
            [self setShowPrice];
            
            [self.tableView reloadData];
        }];
        
    }
  
}

-(void)setShowPrice{
    CGFloat allPrice = [totalPrice floatValue]   - [couponValue floatValue];
    NSString *moneyShow = [NSString stringWithFormat:@"%.2f" ,allPrice];
    _moneyShow = moneyShow;
    [self addAttibute: [@"¥" stringByAppendingString:moneyShow] andCount:totalQty];
}

-(void)setAddress:(id)responseObject{
    
    if ([[[responseObject objectForKey:@"data"] allKeys] containsObject:@"address"]) {
        NSDictionary *dataDic = [[responseObject objectForKey:@"data"] objectForKey:@"address"];
        DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:dataDic];
        detailModel.transportName =[NSString stringWithFormat:@"%@" ,dataDic[@"name"]];
        detailModel.transportPhone =[NSString stringWithFormat:@"%@" ,dataDic[@"phone"]];
        detailModel.transportAddress =[NSString stringWithFormat:@"%@" ,dataDic[@"address"]];
        [self.addressArray addObject:detailModel];
        if (self.addressArray.count <1) {
            [KDSMallAC alertControllerWithTitle:@"提示" message:@"收货地址为空,是否前往添加?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
//                AddressController *addressVC=[[AddressController alloc]init];
//                没GV好几个环节
//                [self.navigationController pushViewController:addressVC animated:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self chooseAddress];
                });
                
            } cancelBlock:^{
            }];
        }
    }else{
        
        [KDSMallAC alertControllerWithTitle:@"提示" message:@"收货地址为空,是否前往添加?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self chooseAddress];
            });
        } cancelBlock:^{
        }];
        
    }
    
}

//-(void)loadDefaultData{
//
//    NSDictionary *dic= @{@"token":ACCESSTOKEN, @"page":@{@"pageSize":@"10", @"pageNum":[NSNumber numberWithInteger:1]} };
//    [JavaNetClass JavaNetRequestWithPort:@"userAddressApp/page" andPartemer:dic Success:^(id responseObject) {
//        NSLog(@"地址=%@",responseObject);
//
//        if ([self isSuccessData:responseObject]) {
//            NSMutableArray *dataArr = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
//            NSMutableArray * modalArr = [NSMutableArray array];
//            for (NSDictionary *dataDic in dataArr) {
//                DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:dataDic];
//                detailModel.transportName =[NSString stringWithFormat:@"%@" ,dataDic[@"name"]];
//                detailModel.transportPhone =[NSString stringWithFormat:@"%@" ,dataDic[@"phone"]];
//                detailModel.transportAddress =[NSString stringWithFormat:@"%@" ,dataDic[@"address"]];
//                [modalArr addObject:detailModel];
//            }
//            [self.addressArray addObjectsFromArray:modalArr];
//
//            if (self.addressArray.count <1) {
//                [KDSAlertController alertControllerWithTitle:@"提示" message:@"收货地址为空,是否前往添加?" okTitle:@"确定" cancelTitle:@"取消" OKBlock:^{
//                    AddressController *addressVC=[[AddressController alloc]init];
//                    [self.navigationController pushViewController:addressVC animated:YES];
//                } cancelBlock:^{
//                }];
//            }
//            [self.tableView reloadData];
//        }
//    }];
//
//}

-(void)chooseAddress{
    AddressController *addListVC=[[AddressController alloc]init];
    addListVC.chooseBlock = ^(KDSAddressListRowModel *amodel) {
        
    DetailModel *detailModel =[[DetailModel alloc]initWithDictionary:@{}];
    detailModel.transportName =[NSString stringWithFormat:@"%@" ,amodel.name];
    detailModel.transportPhone =[NSString stringWithFormat:@"%@" ,amodel.phone];
    detailModel.transportAddress =[NSString stringWithFormat:@"%@" ,amodel.address];
    detailModel.province = [NSString stringWithFormat:@"%@",amodel.province];
    detailModel.city = [NSString stringWithFormat:@"%@",amodel.city];
    detailModel.area = [NSString stringWithFormat:@"%@",amodel.area];
    detailModel.myId =[NSString stringWithFormat:@"%ld" ,(long)amodel.ID];
        
    self.addressArray = [NSMutableArray array];
    [self.addressArray addObject:detailModel];
        
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
    });
   };
    [self.navigationController pushViewController:addListVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.modelArr.count;
    }if (section ==2) {
        return 2;
    }if (section ==3) {
        if (_type == KDSProductDetail_noraml) {
//            return couponValue.length > 0 ? 1 : 0;
            return 1;
        }
        return 0;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect rect =CGRectZero;
    if (section == 1) {
        rect =CGRectMake(0 ,0, KSCREENWIDTH, 50);
    }
    NSString * identy1 = [NSString stringWithFormat:@"%ld" ,(long)section];
    UITableViewHeaderFooterView * headV1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy1];
    if (!headV1) {
        headV1 = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy1];
        UIView *view =[[UIView alloc]initWithFrame:rect];
        view.backgroundColor = [UIColor whiteColor];
        [headV1 addSubview:view];
        if (section ==1) {
            UIButton *btn = [[CustomBtn alloc]initWithBtnFrame:CGRectMake(0,0, 100, 50) btnType:ButtonImageLeft titleAndImageSpace:10 imageSizeWidth:15 imageSizeHeight:17];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setImage:[UIImage imageNamed:@"icon_order"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
            [btn setTitle:@"凯迪仕" forState:UIControlStateNormal];
            [view addSubview: btn];
        }
        
    }
    return headV1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    if (section == 1) {
        return 50;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    static NSString * identy = @"foot";
    UITableViewHeaderFooterView * FootV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
    if (!FootV) {
        FootV = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
        UIView *view =[[UIView alloc]initWithFrame:CGRectZero];
        view.backgroundColor =KViewBackGroundColor;
        [FootV addSubview:view];
    }
    return FootV;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    if ((section == 2)||(section == 3)) {
        return 15;
    }
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"地址";
        DefaultAdrCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell == nil) {
            cell = [[DefaultAdrCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.fillOrder = YES;
        if (self.addressArray.count > 0) {
            cell.detailModel = self.addressArray[indexPath.row];
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"商品列表";
//        NSString *CellIdentifier = [NSString stringWithFormat:@"%ld%ld%ld", (long)[indexPath section], (long)[indexPath row],(long)cellInteger];//以indexPath来唯一确定cell

        OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell == nil) {
            cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.modelArr.count >0) {
            cell.detailModel = self.modelArr[indexPath.row];
        }
        
        return cell;
        
    }
//    static NSString *CellIdentifier = @"描述";
    NSString *CellIdentifier = [NSString stringWithFormat:@"%ld%ld" ,(long)indexPath.section,(long)indexPath.row];
    TotallCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TotallCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section ==2) {
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        NSArray *arrl=@[@"期望安装日期",@"留言"];
        NSArray *arrr=@[@"选择安装日期",@"填写留言(选填)"];
        cell.leftLab.text = arrl[indexPath.row];
        cell.rightField.placeholder = arrr[indexPath.row];
        if (indexPath.row == 1) {
            msgField = cell.rightField;
        }
        [cell.rightField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        if ( indexPath.row ==0) {
            __weak __typeof(self) weakSelf = self;
            cell.rightField.textAlignment = NSTextAlignmentRight;
            
            if (!weakSelf.dateView) {
                weakSelf.dateView = [[MyDateTimeView alloc]initWithFrame:CGRectMake(KSCREENWIDTH-160, 1, 130, 48)];
                weakSelf.dateView.field.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
                weakSelf.dateView.field.textAlignment = NSTextAlignmentRight;
                weakSelf.dateView.field.backgroundColor = [UIColor clearColor];
                weakSelf.dateView.pickerViewMode = MyDatePickerViewDateYearMonthDayMode;
                weakSelf.dateView.dateBlock = ^(NSString *dateStr) {
                    NSLog(@"选择日期=%@" ,dateStr);
                    if ([self durationTime:dateStr]) {
                        [KDSProgressHUD showFailure:@"请选择今天之后的时间" toView:self.view completion:^{
                            
                        }];
                        weakSelf.dateView.field.text = @"";
                        weakSelf.dateView.backgroundColor = [UIColor clearColor];
                        weakSelf.installDate = @"";
                    }else{
                        cell.rightField.text = @"";
                        weakSelf.dateView.backgroundColor = [UIColor whiteColor];
                        weakSelf.installDate = dateStr;
                    }
                };
                [cell addSubview:weakSelf.dateView];
            }
            
        }
        if (indexPath.row == 1) {
            cell.rightField.userInteractionEnabled = YES;
            cell.rightField.textAlignment = NSTextAlignmentLeft;
        }
    }
    if (indexPath.section ==3) {
//        cell.rightField.userInteractionEnabled = YES;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.leftLab.text = @"优惠券";
        if ([KDSMallTool checkISNull:couponID].length <= 0) {
            cell.rightField.text = @"";
            cell.rightField.placeholder = @"暂无可用券";
        }else{
            cell.rightField.text = [NSString stringWithFormat:@"优惠券￥%@",[KDSMallTool checkISNull:couponValue]];
            cell.rightField.placeholder = @"";
        }
      
        [cell.rightField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
    }
    
    
    if (indexPath.section ==4) {
        NSArray *arrl=@[@"商品金额",@"现金券"];
        cell.leftLab.text = arrl[indexPath.row];
        cell.rightField.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];

        if (self.dataArrR.count > 0) {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString: [@"¥" stringByAppendingString:self.dataArrR[indexPath.row]]];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
            cell.rightField.attributedText = AttributedStr;

            if (cell.rightField.text.length ==1) {
                cell.rightField.text = @"";
            }
        }
    }
    return cell;
}

-(BOOL)durationTime:(NSString *)dateStr{
    NSArray * dateArray = [dateStr componentsSeparatedByString:@" "];

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate * startDate = [dateFormatter dateFromString:[dateArray firstObject]];
    NSDate *endDate = [NSDate date];

    DTTimePeriod *timePeriod =[[DTTimePeriod alloc] initWithStartDate:startDate endDate:endDate];
    double  durationInSeconds = [timePeriod durationInHours];  //相差秒
    NSLog(@"durationInSeconds:%f",durationInSeconds);
    return durationInSeconds;
}

-(void)addAttibute:(NSString *)priceS andCount:(NSString *)countS{
    NSString *text =[NSString stringWithFormat:@"%@  共%@件" ,priceS,countS];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString: text];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#333333"] range:NSMakeRange(text.length-1, 1)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    NSString *as = [NSString stringWithFormat:@"%@  " ,priceS];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(as.length, text.length-as.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"#333333"] range:NSMakeRange(as.length, 1)];
    
    bottomLab.attributedText = AttributedStr;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self chooseAddress];
        
    }else if (indexPath.section == 3){
          if (_type == KDSProductDetail_noraml) {

              [self getCouponList:^(NSArray *array) {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      NSLog(@"传的值 couponID:%@",couponID);
                      [KDSCouponsVC showWithcouponID:couponID data:(NSMutableArray *)array selectBlock:^(NSString * _Nonnull selectCouponID, KDSCoupon1Model * _Nonnull model) {
                            NSLog(@"%@----%@ ---- %ld",couponID,model.ID,(long)model.select);
                          if ([KDSMallTool checkISNull:selectCouponID].length <= 0) {
                              couponID = [KDSMallTool checkISNull:selectCouponID];//优惠券ID
                              couponValue = @"0";
                          }else{
                              couponID = [KDSMallTool checkISNull:selectCouponID];//优惠券ID
                              couponValue = [KDSMallTool checkISNull:model.couponValue];
                          }
                       
                          [self setShowPrice];
                          [self.tableView reloadData];
                      }];

                  });
              }];
          }
    }
}

#pragma mark - 获取现金券列表
-(void)getCouponList:(void(^)(NSArray * array))couponBlock{
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSDictionary * paramsDict = @{@"params": @{@"shopcarIds":_productIDArray},     //（必填）（int）购物车Id数组，至少包含一个
                                  @"token": [KDSMallTool checkISNull:userToken]  //（必填）（str）
                                  };
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:@"coupon/getMyList" paramsDict:paramsDict success:^(NSInteger code, id  _Nullable json) {
        if (code == 1) {
            [self.couponArray removeAllObjects];
            NSArray * array  = [KDSCoupon1Model mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
            [self.couponArray addObjectsFromArray:array];
    
            if (![KDSMallTool checkObjIsNull:self.couponArray]) {
                 couponBlock(self.couponArray);
            }else{
                couponBlock([NSArray new]);
            }
           
        }else{
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)addTableView{
    UIView *botView = [[UIView alloc]init];
    botView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:botView];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-MhomeBarH);
    }];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:submitBtn];
    submitBtn.layer.cornerRadius = 40 / 2;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(botView.mas_centerY);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    bottomLab = [[UILabel alloc]init];
    bottomLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
    bottomLab.font = [UIFont systemFontOfSize:20];
    bottomLab.textAlignment = NSTextAlignmentLeft;
    //    bottomLab.backgroundColor = [UIColor cyanColor];
    [botView addSubview:bottomLab];
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(botView.mas_left).mas_offset(15);
        make.top.mas_equalTo(botView).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH-100, 50));
    }];
    //    [self addAttibute:@"¥2888" andCount:@"2"];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.bottom.mas_equalTo(botView.mas_top);
    }];
    
}

-(void)submitAction{
    
    if (self.addressArray.count  <1) {
        [self showToastError:@"请添加收货地址"];
        return;
    }
    
    if (self.installDate.length  <1) {
        [self showToastError:@"请选择安装日期"];
        return;
    }
    
    DetailModel *detailModel = self.addressArray[0];
    NSString *addressID = [NSString stringWithFormat:@"%@" ,detailModel.myId];
    NSString *msgStr =[KDSMallTool checkISNull:msgField.text];
    NSString*dateStr =[KDSMallTool checkISNull:self.installDate];
    
    NSDictionary *dic = nil;
    NSString     * createOrder = @"";
    if (_type == KDSProductDetail_noraml) {
        createOrder = @"indent/createBaseIndent";
        dic = @{@"params":@{@"shopcarIds":self.productIDArray,@"addressId":addressID,@"couponId":[KDSMallTool checkISNull:couponID],@"buyerMsg":msgStr,@"installationDate":dateStr,@"freight":@"0"}, @"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
    }else{
        createOrder = @"indent/createActivityIndent";
        dic = @{@"params": @{
                        @"addressId":addressID,               //（必填）（int）收货地址Id
                        @"buyerMsg": msgStr,                  //（选填）（str）买家留言
                        @"installationDate": dateStr,         //（选填）（str）门店安装时间
                        @"businessId": _activityDict[@"businessId"],           //（必填）（int）活动Id
                        @"agentProductId": _activityDict[@"agentProductId"],   //（必填）（int）渠道商品Id
                        @"qty": _activityDict[@"qty"],                         //（必填）（int）购买数量
                        @"type":_activityDict[@"type"]                         //（必填）（string）活动商品类型
                        },
                @"token": [KDSMallTool checkISNull:ACCESSTOKEN]                    //  （必填）（str）
                };
    }
    
    NSLog(@"dicdic=%@" ,dic);
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:self.view];
    [self submitDataWithBlock:createOrder partemer:dic Success:^(id responseObject) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        
        if ([weakSelf isSuccessData:responseObject]) {
            NSString * orderNo = [KDSMallTool checkISNull:responseObject[@"data"][@"orderNo"]];
            [KDSPayController showPay:_moneyShow orderNo:orderNo payResult:^(PayResultCodeType recustCode) {
    
                    switch (recustCode) {
                        case PayResultCodeType_success:{//成功
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                            [self enterOrderList:2];
                        }
                            break;
                        case PayResultCodeType_Cancel:{//用户点击取消并返回
                            if (_type == KDSProductDetail_noraml) {
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                                [self enterOrderList:1];
                            }else{
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
                                [self enterOrderList:-1];
                            }
                            
                        }
                            break;
                        case PayResultCodeType_fail:{
                            NSLog(@"支付失败");
                        }
                            break;
                        default:
                            break;
                    }
            } cancelButtonClick:^{
                    if (_type == KDSProductDetail_noraml){
                         [weakSelf enterOrderList:1];
                    }else{
                        [weakSelf enterOrderList:0];
                    }
            }];

        }else{
            [KDSProgressHUD showFailure:@"未知错误" toView:self.view completion:^{}];
        }
    }];
    
}

-(void)enterOrderList:(NSInteger)selectIndex{
    
     if (_type == KDSProductDetail_noraml) {
//         KDSTabBarController *rootViewController =(KDSTabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
//         rootViewController.selectedIndex = 4;
//         [self.navigationController popToRootViewControllerAnimated:YES];
//         UINavigationController * nvc = rootViewController.viewControllers[4];
//         OrderListController * listVC = [[OrderListController alloc] init];
//         listVC.selectIndex = selectIndex;
//         [nvc pushViewController:listVC animated:YES];
          OrderListController * listVC = [[OrderListController alloc] init];
          listVC.selectIndex = selectIndex;
          listVC.backPopToRoot = YES;
          [self.navigationController pushViewController:listVC animated:YES];
         
     }else{
         if (selectIndex <= 0) {
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             KDSTabBarController *rootViewController =(KDSTabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
             rootViewController.selectedIndex = 4;
             [self.navigationController popToRootViewControllerAnimated:YES];
             UINavigationController * nvc = rootViewController.viewControllers[4];
             
             KDSActivityOrderController * activityOrderVC = [[KDSActivityOrderController alloc]init];
             NSMutableDictionary * dict = [NSMutableDictionary dictionary];
             [dict setValue:[KDSMallTool checkISNull:_activityDict[@"type"] ] forKey:@"key"];
             if (_type == KDSProductDetail_seckill) {
                 [dict setValue:@"秒杀订单" forKey:@"value"];
                 [dict setValue:@"product_type_seckill" forKey:@"key"];
             }else if(_type == KDSProductDetail_group){
                 [dict setValue:@"团购订单" forKey:@"value"];
                 [dict setValue:@"product_type_group" forKey:@"key"];
             }else if (_type == KDSProductDetail_bargain){
                 [dict setValue:@"砍价订单" forKey:@"value"];
                 [dict setValue:@"product_type_bargain" forKey:@"key"];
             }else if (_type == KDSProductDetail_crowdfunding){
                 [dict setValue:@"众筹订单" forKey:@"value"];
                 [dict setValue:@"product_type_crowd" forKey:@"key"];
             }
             activityOrderVC.dict = dict;
             [nvc pushViewController:activityOrderVC animated:YES];
         }
         
         
     }
}

-(NSMutableArray *)couponArray{
    if (_couponArray == nil) {
        _couponArray = [NSMutableArray array];
    }
    return _couponArray;
}

#pragma mark - 下单请求
//-(void)payOrderPayType:(YSEPayChannel)payType cancel:(BOOL)isCancel{
//    DetailModel *detailModel = self.addressArray[0];
//    NSString *addressID = [NSString stringWithFormat:@"%@" ,detailModel.myId];
//    NSString *msgStr =[KDSMallTool checkISNull:msgField.text];
//    NSString*dateStr =[KDSMallTool checkISNull:self.installDate];
//
//    NSDictionary *dic = nil;
//    NSString     * createOrder = @"";
//    if (_type == KDSProductDetail_noraml) {
//        createOrder = @"indent/createBaseIndent";
//        dic = @{@"params":@{@"shopcarIds":self.productIDArray,@"addressId":addressID,@"couponId":[KDSMallTool checkISNull:couponID],@"buyerMsg":msgStr,@"installationDate":dateStr,@"freight":@"0"}, @"token":[KDSMallTool checkISNull:ACCESSTOKEN]};
//    }else{
//        createOrder = @"indent/createActivityIndent";
//        dic = @{@"params": @{
//                   @"addressId":addressID,               //（必填）（int）收货地址Id
//                    @"buyerMsg": msgStr,                 //（选填）（str）买家留言
//                    @"installationDate": dateStr,      //（选填）（str）门店安装时间
//                    @"businessId": _activityDict[@"businessId"],           //（必填）（int）活动Id
//                    @"agentProductId": _activityDict[@"agentProductId"],   //（必填）（int）渠道商品Id
//                    @"qty": _activityDict[@"qty"],                         //（必填）（int）购买数量
//                    @"type":_activityDict[@"type"]                         //（必填）（string）活动商品类型
//                },
//                @"token": [KDSMallTool checkISNull:ACCESSTOKEN]                               //  （必填）（str）
//                };
//    }
//
//    NSLog(@"dicdic=%@" ,dic);
//    [self submitDataWithBlock:createOrder partemer:dic Success:^(id responseObject) {
//        NSLog(@"下订单:responseObject%@",responseObject);
//        if ([self isSuccessData:responseObject]) {
//            if (isCancel) {//取消
//                [self enterOrderList:1];
//            }else{//支付
//                NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//                NSString * ID = responseObject[@"data"][@"id"];
//                NSDictionary * dictionary = @{@"params":
//                                                  @{ @"indentId":[KDSMallTool checkISNull:ID]
//
//                                                     },
//                                              @"token":token
//                                              };            //订单ID
//                //支付请求
//                [self submitDataWithBlock:@"payApp/payment" partemer:dictionary Success:^(id responseObject) {
//                    NSLog(@"支付成功%@",responseObject);
//                     if ([self isSuccessData:responseObject]) {
//                            [[NSNotificationCenter defaultCenter]postNotificationName:@"刷新购物车" object:nil];
//                            [self enterOrderList:2];
//                     }
//                }];
//            }
//        }
//    }];
//}

@end
