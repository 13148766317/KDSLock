//
//  EditAddressController.h
//  Rent3.0
//
//  Created by Apple on 2018/7/31.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSAddressListModel.h"
typedef void(^AddSuccess)(void);
@interface EditAddressController :BaseDataLoadController
@property(nonatomic , strong)KDSAddressListRowModel *dataModel;
@property (nonatomic, copy) AddSuccess addBlock;
@property(nonatomic , strong)NSString *enterType;

@end
