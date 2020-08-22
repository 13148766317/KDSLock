//
//  KDSInviteFriendController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/23.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSInviteFriendController.h"
#import "KDSInviteFriendCell.h"

@interface KDSInviteFriendController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView   * tableView;
@end

@implementation KDSInviteFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KDSInviteFriendCell * cell = [KDSInviteFriendCell inviteFriendCellWithTableView:tableView];

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     UIView * view  =[[UIView alloc]init];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
    return view;
}

#pragma mark - 创建UI
-(void)createUI{
    self.navigationBarView.backTitle = @"邀请好友";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
}


#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.sectionHeaderHeight = 15.0f;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
