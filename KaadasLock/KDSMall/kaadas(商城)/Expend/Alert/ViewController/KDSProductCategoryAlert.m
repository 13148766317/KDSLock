//
//  KDSProductCategoryController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/28.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductCategoryAlert.h"
#import "KDSProductCategoryCell.h"


static UIWindow                  * __window = nil;
static KDSProductCategoryAlert   * __categoryVC = nil;

static CGFloat bgImageViewWidth = 150;
//static CGFloat bgImageViewheight = 200;
@interface KDSProductCategoryAlert ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UITableView        * tableView;
@property (nonatomic,assign)CGRect              rect;
@property (nonatomic,strong)UIButton           * button;
@property (nonatomic,assign)CGPoint             titlePoint;
@property (nonatomic,strong)NSArray            * dataArray;
@property (nonatomic,strong)UIImageView        * bgImageView;
@property (nonatomic,copy)KDSProductBlock        productBlock;
@end

@implementation KDSProductCategoryAlert

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加背景图
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.image = [UIImage imageNamed:@"bg_product_detail"];
    _bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImageView];

    //添加tableview
    [_bgImageView addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //坐标转换  button坐标转换当前控件的坐标
    _titlePoint = [_button convertPoint:_button.imageView.frame.origin toView:self.view];
    
    //设置背景图的frame
    CGFloat buttonMaxX = CGRectGetMaxX(_button.frame);
     _bgImageView.frame = CGRectMake(buttonMaxX - bgImageViewWidth / 2, _titlePoint.y + 25 , bgImageViewWidth, 50 * self.dataArray.count);
    //设置tableview的frame
    self.tableView.frame = CGRectMake(0,  10, CGRectGetWidth(self.bgImageView.frame), CGRectGetHeight(self.bgImageView.frame));
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self closeWindow];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDSProductCategoryCell * cell = [KDSProductCategoryCell productCategoryCellWithTableView:tableView];
    cell.titleStr = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.productBlock) {
        self.productBlock(indexPath.row);
    }
    
    [self closeWindow];
}


+(instancetype)productCategoryShowDataArray:(NSArray *)dataArray Rect:(CGRect)rect  button:(UIButton *)button productBlock:(KDSProductBlock)productBlock{
    
    __categoryVC = [[KDSProductCategoryAlert alloc]init];
    __categoryVC.rect  = rect;
    __categoryVC.button = button;
    __categoryVC.dataArray = dataArray;
    __categoryVC.productBlock = productBlock;
    
    
    //创建UIWindow
    __window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    __window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    __window.windowLevel = UIWindowLevelStatusBar;
    __window.hidden = NO;
    //设置window的主控制器
    __window.rootViewController = __categoryVC;
    return __categoryVC;
    
}

-(void)closeWindow{
    __categoryVC = nil;
    __window.hidden = YES;
    __window = nil;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource  = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
    }
    return _tableView;
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
