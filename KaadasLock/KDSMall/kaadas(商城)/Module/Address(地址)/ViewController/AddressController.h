//
//  AddressController.h
//  Rent3.0
//
//  Created by Apple on 2018/7/31.
//  Copyright © 2018年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSAddressListModel.h"
typedef void(^ChooseClick)(KDSAddressListRowModel *amodel);

@interface AddressController : BaseDataLoadController
@property (nonatomic, copy) ChooseClick chooseBlock;

@end
