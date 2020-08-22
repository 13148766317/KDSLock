//
//  KDSProductDetailPhotoController.m
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductDetailPhotoController.h"
#import "KDSProductDetailCell.h"


@interface KDSProductDetailPhotoController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation KDSProductDetailPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
    [self requestDetailData];
}

#pragma mark - 商品详情 请求
-(void)requestDetailData{
    
    NSString * userToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSDictionary * dict = @{
                            @"params": @{
                                    @"id":@(_productModel.ID)  // int 必填 渠道商品id
                                    },
                            @"token":[KDSMallTool checkISNull:userToken]
                            };
    NSLog(@"IDIIIIII:%ld",_productModel.ID);
    __weak typeof(self)weakSelf = self;
    [KDSProgressHUD showHUDTitle:@"" toView:weakSelf.view];
    [KDSProdutDetailHttp productDetailWithParams:dict productDetailType:KDSProductDetailNormal success:^(BOOL isSuccess, id  _Nonnull obj) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        if (isSuccess) {
            weakSelf.detailModel = (KDSProductDetailModel *)obj;

            //收藏
            [weakSelf.tableView reloadData];
            
        }else{
            [KDSProgressHUD showFailure:obj toView:weakSelf.view completion:^{}];
        }
    } failure:^(NSError * _Nonnull error) {
        [KDSProgressHUD hideHUDtoView:weakSelf.view animated:YES];
        [KDSProgressHUD showFailure:error.domain toView:weakSelf.view completion:^{}];
    }];
}

#pragma mark - 创建UI
-(void)createUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(isIPHONE_X ? 88 : 64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(isIPHONE_X ? 0 : 0);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModel.detailImgs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDSProductDetailCell * cell = [KDSProductDetailCell productDetailCellWithTableView:tableView];
    KDSProductImageModel *imageModel  = self.detailModel.detailImgs[indexPath.row];
    NSString * imageString = imageModel.imgUrl;
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:placeholder_h]];
//    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:imageString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"%@",NSStringFromCGSize(image.size));
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [cell.photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(cell.contentView);
//                make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, KSCREENWIDTH * image.size.height / image.size.width));
//                make.bottom.mas_equalTo(cell.contentView.mas_bottom).priorityLow();
//            }];
//        });
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
////        [cell setNeedsLayout];
////        [cell layoutIfNeeded];
//    }];
    return cell;
}


#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100.0f;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}


@end
