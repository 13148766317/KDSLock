//
//  KDSPostSaleController.m
//  kaadas
//
//  Created by 中软云 on 2019/7/25.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSPostSaleController.h"
#import "KDSPostSaleCell.h"

@interface KDSPostSaleController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView   * tableView;
@end

@implementation KDSPostSaleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - 提交事件
-(void)submitButtonClick{
    NSLog(@"提交");
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"售后";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(isIPHONE_X ? - 34 : 0);
    }];
    
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#1F96F7"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarView.rightItem = submitButton;
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDSPostSaleCell * cell = [KDSPostSaleCell postSaleWithTableView:tableView];
   
    return cell;
}

#pragma mark - 懒加载tableview
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


@end
