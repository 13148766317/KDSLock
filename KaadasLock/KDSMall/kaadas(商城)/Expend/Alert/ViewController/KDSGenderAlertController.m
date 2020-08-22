//
//  KDSGenderAlertController.m
//  kaadas
//
//  Created by 中软云 on 2019/5/13.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSGenderAlertController.h"
#import "KDSGenderTableCell.h"


static CGFloat genderRowHeight = 60.0f;
static UIWindow * __widown = nil;

static KDSGenderAlertController * __genderAlert = nil;

@interface KDSGenderAlertController ()
<
UITableViewDelegate,
UITableViewDataSource,
KDSGenderCellDelegate
>
//创建底部半透明的view
@property (nonatomic,strong)UIView            *  backgroundView;
//白色背景
@property (nonatomic,strong)UIView            * whitebgView;

@property (nonatomic,strong)UITableView       * tableView;

@property (nonatomic,strong)NSMutableArray    * dataArray;
@property (nonatomic,assign)NSInteger           selectIndex;
@property (nonatomic,copy)KDSGenderBlock        genderBlock;
@property (nonatomic,copy)NSString              * gender;
@end

@implementation KDSGenderAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //创建UI
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"_gender:%@",_gender);
    if ([_gender isEqualToString:@"男"]) {
        _selectIndex = 0;
    }else if([_gender isEqualToString:@"女"]){
        _selectIndex = 1;
    }else{
        _selectIndex = 0;
    }
    
    [self.tableView reloadData];
}


#pragma mark - 弹框
-(void)createUI{
    //设置view背景颜色为透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //创建底部半透明的view
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    _backgroundView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_backgroundView];
    
    
    CGFloat bgViewX = 38.0f;
    CGFloat bgViewWidth = KSCREENWIDTH - bgViewX * 2;
    CGFloat bgViewHeigh = 200;
    
    _whitebgView = [[UIView alloc]init];
    _whitebgView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [self.view addSubview:_whitebgView];
    
    _whitebgView.frame = CGRectMake(bgViewX, 100, bgViewWidth, bgViewHeigh);
    
    //性别title
    UILabel * genderTitle = [KDSMallTool createbBoldLabelString:@"性别" textColorString:@"#333333" font:15];
    genderTitle.textAlignment = NSTextAlignmentCenter;
    [_whitebgView addSubview:genderTitle];
    genderTitle.frame = CGRectMake(0, 36, bgViewWidth, 20);
    
    [_whitebgView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(genderTitle.frame) + 30, CGRectGetWidth(_whitebgView.frame), self.dataArray.count * genderRowHeight);
    
    
    //重新设置whiteBgView的frame

     bgViewHeigh = CGRectGetMaxY(self.tableView.frame) + 40;
    CGFloat bgViewY  = (KSCREENHEIGHT - bgViewHeigh ) /2.0;
    _whitebgView.frame = CGRectMake(bgViewX, bgViewY, bgViewWidth, bgViewHeigh);
    
//    [self selectGender];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark -
+(instancetype)genderAlertGender:(NSString *)gender resultBlock:(KDSGenderBlock)resultBlock{
    __genderAlert = [[KDSGenderAlertController alloc]init];
    __genderAlert.genderBlock = resultBlock;
    __genderAlert.gender = gender;
    
    
    //创建UIWindow
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    //设置window的优先级
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    //设置window的主控制器
    window.rootViewController = __genderAlert;
    __widown = window;
    
    return __genderAlert;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSGenderTableCell * cell = [KDSGenderTableCell genderCellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.selectIndex = _selectIndex;
    cell.delegate = self;
    if (indexPath.row == (self.dataArray.count - 1)) {
        cell.hiddenDividing = YES;
    }else{
        cell.hiddenDividing = NO;
    }
    cell.titltString = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [self.tableView reloadData];
    
    [self selectGender];
}

#pragma mark - KDSGenderCellDelegate
-(void)genderCellSelect:(NSInteger)index{
    _selectIndex = index;
    [self.tableView reloadData];
    [self selectGender];
}

-(void)selectGender{
    KDSGenderType type = -1;
    switch (_selectIndex) {
        case 0:{
            type = KDSGenderType_male;
        }
            
            break;
        case 1:{
            type = KDSGenderType_female;
        }
            break;
        default:
            break;
    }
    
    if (type < 0) {
        return;
    }
    
    if (self.genderBlock) {
        self.genderBlock(type);
    }
    
    
    [self closeVC];
}

-(void)closeVC{
    __widown.hidden = YES;
    __genderAlert = nil;
    __widown = nil;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = genderRowHeight;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
    }
    return _dataArray;
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
