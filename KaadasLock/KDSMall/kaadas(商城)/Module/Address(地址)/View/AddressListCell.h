//
//  AddressListCell.h
//  rent
//
//  Created by David on 16/5/9.
//  Copyright © 2016年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDSAddressListModel.h"
@interface AddressListCell : UITableViewCell
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *phoneLabel;
@property(nonatomic ,strong)UILabel *addressLabel;
@property(nonatomic ,strong)UILabel *defaultLabel;

@property(nonatomic,strong)KDSAddressListRowModel *detailModel;
@end
