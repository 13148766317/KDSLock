//
//  KDSProductDetailPhotoController.h
//  kaadas
//
//  Created by 中软云 on 2019/6/4.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSBaseController.h"
#import "KDSSecondPartModel.h"
#import "KDSProdutDetailHttp.h"
#import "KDSProductDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KDSProductDetailPhotoController : KDSBaseController
//传值属性
@property (nonatomic,strong)KDSSecondPartRowModel    * productModel;

//以下属性本类及子类使用
@property (nonatomic,strong)UITableView              * tableView;
@property (nonatomic,strong)KDSProductDetailModel    * detailModel;
@end

NS_ASSUME_NONNULL_END
