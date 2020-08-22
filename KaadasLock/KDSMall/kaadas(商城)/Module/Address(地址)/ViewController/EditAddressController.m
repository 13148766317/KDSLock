//
//  EditAddressController.m
//  Rent3.0
//
//  Created by Apple on 2018/7/31.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "EditAddressController.h"
#import "AddressCell.h"
#import "DXLAddressPickView.h"
@interface EditAddressController ()<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *areaTF;
    UITextField *detailAddressTF;
    NSString *defaulValue;
    UITextView *contentTextView;
    UITableView *myTableView;
    DXLAddressPickView *_pickerView;
    
    CGFloat ah;
    
    

}
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *cityArrayy;

@property(nonatomic,strong)NSString *provinceStr;
@property(nonatomic,strong)NSString *cityStr;
@property(nonatomic,strong)NSString *areaStr;





@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.enterType isEqualToString:@"添加"]) {
        self.navigationBarView.backTitle = @"添加地址";
    }else{
        self.navigationBarView.backTitle = @"修改地址";
    }

    ah = 0;
    if ( isIPHONE_X) {
        ah = 34;
    }
    [self addTableView];
//    [self addGesture];
    
}


-(NSMutableArray *)dataArray{
    if (_cityArrayy == nil) {
        _cityArrayy = [NSMutableArray arrayWithCapacity:1];
    }
    return _cityArrayy;
}
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor =KseparatorColor;
        _tableView.backgroundColor = KViewBackGroundColor;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}
-(void)addTableView{
    
    UIButton * addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal]; ;
    [addBtn addTarget:self action:@selector(saveBut) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = addBtn;
//    [self.view addSubview:addBtn];
//    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(50);
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ah);
//    }];
//
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
//        make.bottom.mas_equalTo(addBtn.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-ah);
    }];
//    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);

    [self addFoot];
}
-(void)addFoot{
    UIView *vvv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 100)];
    vvv.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = vvv;
    UILabel * leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 90, 16)];
    leftLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#525252"]; // #272727
    leftLabel.font =[UIFont systemFontOfSize:16];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.text =@"详细地址:";
    [vvv addSubview:leftLabel];
    contentTextView = [self addTextView];
    contentTextView.frame = CGRectMake(80, 12, KSCREENWIDTH-95, 80);
    [vvv addSubview:contentTextView];
    contentTextView.text = self.dataModel.address;
}

#pragma mark - 限制详细地址输入框的个数
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 40) {
        textView.text = [textView.text substringToIndex:40];
    }
}
-(NSString *)getStr{
    
//        NSMutableArray *arr = [self arrayWithJsonString:self.dataModel.area];
        NSString *finalStr=@"";
    finalStr = [NSString stringWithFormat:@"%@ %@ %@",[KDSMallTool checkISNull:self.dataModel.province],[KDSMallTool checkISNull:self.dataModel.city],[KDSMallTool checkISNull:self.dataModel.area]];
    self.provinceStr = [KDSMallTool checkISNull:self.dataModel.province];
    self.cityStr = [KDSMallTool checkISNull:self.dataModel.city];
    self.areaStr = [KDSMallTool checkISNull:self.dataModel.area];
    
//        for (NSDictionary *dic in arr) {
//            NSString *aname = [NSString stringWithFormat:@"%@" ,dic[@"name"]];
//            finalStr = [NSString stringWithFormat:@"%@ %@",finalStr, aname];
//        }
    return finalStr;
  
}
-(NSMutableArray *)arrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49 ;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 15)];
    label.backgroundColor =KViewBackGroundColor;
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{

    return 15;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0 ,0, KSCREENWIDTH, 1)];
    label.backgroundColor =KViewBackGroundColor;
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *cellIdentifier = @"个人资料";
    AddressCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array=@[@"收货人",@"手机号",@"地址"];
    cell.leftLabel.text = array[indexPath.row];
    if (indexPath.row == 0) {
        nameTF=[self creatTF];
        nameTF.text = self.dataModel.name;
        nameTF.delegate = self;
        [cell addSubview:nameTF];
        nameTF.placeholder = @"请填写收货人";
    }if (indexPath.row == 1) {
        phoneTF=[self creatTF];
        phoneTF.text = self.dataModel.phone;
        [phoneTF setMaxLen:11];
        phoneTF.keyboardType = UIKeyboardTypePhonePad;
        [cell addSubview:phoneTF];
        phoneTF.placeholder = @"请填写手机号";

    }if (indexPath.row == 2) {
        areaTF=[self creatTF];
        areaTF.userInteractionEnabled = NO;
        areaTF.placeholder = @"请输入地址";
        [cell addSubview:areaTF];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        if (![self.enterType isEqualToString:@"添加"]) {
            areaTF.text =[self getStr];

        }
//        if ([self getStr].length >0) {
//            areaTF.text =[self getStr];
//        }
        areaTF.frame =CGRectMake(100,  0, KSCREENWIDTH-130 , 49);

    }
//    if (indexPath.row == 3) {
//        detailAddressTF=[self creatTF];
//        detailAddressTF.text = self.dataModel.address;
//        detailAddressTF.delegate = self;
//        [cell addSubview:detailAddressTF];
//
//    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        _pickerView = [[DXLAddressPickView alloc] init];
        [_pickerView show];
        __weak typeof(self) weakSelf = self;
        __weak typeof(UITextField) *weakSareafield = areaTF;

        _pickerView.cityBlock = ^(NSMutableArray *cityArrr) {
            NSLog(@"cityArrr=%@",cityArrr);
            weakSelf.cityArrayy = cityArrr;
        };
        _pickerView.determineBtnBlock = ^(NSString *shengId, NSString *shiId, NSString *xianId, NSString *shengName, NSString *shiName, NSString *xianName, NSString *postCode) {
            NSLog(@"省=%@",shengName);
            NSLog(@"省id=%@",shengId);
            NSLog(@"市=%@",shiName);
            NSLog(@"市id=%@",shiId);
            NSLog(@"区=%@",xianName);
            NSLog(@"区id=%@",xianId);
            weakSareafield.text = [NSString stringWithFormat:@"%@ %@ %@",shengName,[KDSMallTool checkISNull:shiName],[KDSMallTool  checkISNull:xianName]];
            
            weakSelf.provinceStr = shengName;
            weakSelf.cityStr = [KDSMallTool checkISNull:shiName];
            weakSelf.areaStr = [KDSMallTool checkISNull:xianName];

        };

    }
}

-(UITextView *)addTextView{
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(13, 0, KSCREENWIDTH - 2*13, 85)];
    contentTextView.delegate = self;
    contentTextView.showsVerticalScrollIndicator = NO;
    contentTextView.textColor = [UIColor hx_colorWithHexRGBAString:@"#888888"];
    contentTextView.font = [UIFont systemFontOfSize:14];
   
//    contentTextView.contentInset = UIEdgeInsetsMake(6, 0, 0, 0);//UIEdgeInsetsMake(6, 10, 0, 0);
    return contentTextView;
    
}


-(UITextField *)creatTF{
    UITextField *field =[[UITextField alloc]initWithFrame:CGRectMake(100,  0, KSCREENWIDTH-115 , 49)];
    field.font =[UIFont systemFontOfSize:16];
    field.textAlignment = NSTextAlignmentRight;
    field.textColor =[UIColor hx_colorWithHexRGBAString:@"#888888"];
    [field setMaxLen:40];
    return field;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)saveBut{
    NSLog(@"save");
//    [self hideKeyBoard];
    
    if (nameTF.text.length < 1) {
        [self showToastError:@"请输入收货人姓名"];
        return;
    }
    if (phoneTF.text.length < 1) {
        [self showToastError:@"请输入收货人手机"];
        return;
    }

    if (areaTF.text.length < 1) {
        [self showToastError:@"请输入省市区"];
        return;
    }

    if (contentTextView.text.length < 1) {
        [self showToastError:@"请输入详细地址"];
        return;
    }
    
    
    if ([self.enterType isEqualToString:@"添加"]) {
        [self addAddress];
    }
    
    if ([self.enterType isEqualToString:@"编辑"]) {
        [self editAddress];
    }
    
    
}


#pragma mark 新增地址
-(void)addAddress{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.cityArrayy
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString=%@" ,jsonString);
    
    
   NSString * userToken =  [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary *dic = @{@"params":@{@"name" :nameTF.text,              //收货人姓名
                                      @"phone":phoneTF.text,             //手机号
                                      @"zipCode":@"",                    //邮政编码
                                      @"province":self.provinceStr,      //省
                                      @"city":self.cityStr ,             //市
                                      @"area":self.areaStr ,             //区
                                      @"address":contentTextView.text    //地址
                                    },
                          @"token":[KDSMallTool checkISNull:userToken]
                          };
  
  
//  @{@"token":userToken,@"status":@"0",@"name":nameTF.text,@"phone":phoneTF.text,@"province":self.provinceStr ,@"city":self.cityStr,@"area":self.areaStr ,@"address":detailAddressTF.text};
//    NSLog(@"%@",dic);
    [self submitDataWithBlock:addAddress partemer:dic Success:^(id responseObject) {

        if ( [self isSuccessData:responseObject]) {
            [self showToastSuccess:@"添加成功"];
            if (self.addBlock) {
                self.addBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }
        }

    }];
    
}


#pragma mark 修改地址

-(void)editAddress{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dictionary =  @{
                                   @"params": @{
                                           @"id"         :@(self.dataModel.ID),      //主键
                                           @"name"       :nameTF.text,       //收货人姓名
                                           @"phone"      :phoneTF.text,       //手机号
                                           @"zipCode"    :[KDSMallTool checkISNull:self.dataModel.zipCode],       //邮政编码
                                           @"province"   :self.provinceStr,   //省                      String
                                           @"city"       :self.cityStr ,       //市                      String
                                           @"area"       :self.areaStr ,       //区                      String
                                           @"address"    :contentTextView.text,      //地址                    String
                                           @"isDefault"  :[KDSMallTool checkISNull:self.dataModel.isDefault]       //是否默认地址                bit
                                       },
                                    @"token": [KDSMallTool checkISNull:userToken]
                                   };

    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSNetworkManager POSTRequestBodyWithServerUrlString:updateAddress paramsDict:dictionary success:^(NSInteger code, id  _Nullable json) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (code == 1) {
            [KDSProgressHUD showSuccess:@"修改成功" toView:weakSelf.view completion:^{
                if (self.addBlock) {
                    self.addBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            [KDSProgressHUD showFailure:json[@"msg"] toView:weakSelf.view completion:^{
                
            }];
        }
    } failure:^(NSError * _Nullable error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{
            
        }];
    }];
    
    
//    NSMutableArray *arr=[self arrayWithJsonString:self.dataModel.areaCode];
//    NSString *finalstr = [self stringWithArr:arr];
//
//    NSDictionary *dic = @{@"userId":[userDefaults objectForKey:@"userToken"],@"status":self.dataModel.status,@"personName":nameTF.text,@"phone":phoneTF.text,@"areaCode":finalstr,@"address":detailAddressTF.text,@"id":self.dataModel.myId};
//    [self submitDataWithBlock:@"device/userAddress/update" partemer:dic Success:^(id responseObject) {
//        if ([self isSuccessData:responseObject]) {
//            [self showToastSuccess:@"修改成功"];
//            if (self.addBlock) {
//                self.addBlock();
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        }
//
//    }];
    
}



-(NSString *)stringWithArr:(NSMutableArray *)arr{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:kNilOptions
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSLog(@"jsonStr==%@",jsonString);
    return jsonString;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
