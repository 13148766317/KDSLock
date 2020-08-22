//
//  KDSHomeMoreAlertController.m
//  kaadas
//
//  Created by 中软云 on 2019/8/26.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeMoreAlertController.h"

#import "KDSHomeMoreAlertCell.h"
static UIWindow                     * __window = nil;
static KDSHomeMoreAlertController   * __alertVC = nil;

static CGFloat cellHeight = 50.0f;

@interface KDSHomeMoreAlertController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UIView           * positionView;
@property (nonatomic,copy)HomeMoreClickBlock   moreClickBlock;
@property (nonatomic,strong)UITableView      * tableView;
@property (nonatomic,strong)UIImageView      * bgImageView;
@property (nonatomic,strong)NSMutableArray   * titleArray;
@property (nonatomic,strong)NSMutableArray   * imageArray;
@end

@implementation KDSHomeMoreAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //添加背景
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [UIImage imageNamed:@"首页跟多矩形"];
    [self.view addSubview:_bgImageView];
    
    //添加tableview
    [_bgImageView addSubview:self.tableView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//设置frame
    //背景frame
    CGFloat bgImageViewW = 130;
    CGFloat bgImageViewX = CGRectGetMinX(_positionView.frame) - bgImageViewW + CGRectGetWidth(_positionView.frame) + 5;
    CGFloat bgImageViewY = CGRectGetMaxY(_positionView.frame) - 5;
    CGFloat bgImageViewH = self.titleArray.count * cellHeight + 10;
    _bgImageView.frame = CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH);
    
    //tableView的frame
    CGFloat tableViewW = bgImageViewW;
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 10;
    CGFloat tableViewH = bgImageViewH - 10;
    self.tableView.frame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    
    //刷新tableview
    [self.tableView reloadData];
}

+(instancetype)homeMoreShowView:(UIView *)view homeMoreClickBlock:(HomeMoreClickBlock)homeMoreClickBlock{
    
    __alertVC = [[KDSHomeMoreAlertController alloc]init];
    __alertVC.positionView  = view;
    __alertVC.moreClickBlock = homeMoreClickBlock;
    
    //创建窗口
    __window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    __window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    __window.windowLevel = UIWindowLevelStatusBar;
    __window.hidden = NO;
    //设置window的主控制器
    __window.rootViewController = __alertVC;
    
    return __alertVC;
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSHomeMoreAlertCell * cell = [KDSHomeMoreAlertCell homeMoreWithTableView:tableView];
    cell.titleStr = self.titleArray[indexPath.row];
    cell.imageStr = self.imageArray[indexPath.row];
    if (self.titleArray.count == indexPath.row + 1) {
        cell.lastCell = YES;
    }else{
        cell.lastCell = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.moreClickBlock) {
        self.moreClickBlock(indexPath.row);
    }
    
    [self closeWindow];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self closeWindow];
}

#pragma mark - 关闭弹框
-(void)closeWindow{
    __alertVC = nil;
    __window.hidden = YES;
    __window = nil;
}
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = cellHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.bounces = NO;
    }
    return _tableView;
}

-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray arrayWithObjects:@"消息",@"订单",@"反馈中心",@"个人信息", nil];
    }
    return _titleArray;
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray arrayWithObjects:@"icon_home_news",@"order",@"customer_feedback_icon",@"information",nil];
    }
    return _imageArray;
}

//#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
