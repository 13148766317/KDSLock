//
//  KDSCateyeMoreCell.h
//  KaadasLock
//
//  Created by zhaona on 2019/5/9.
//  Copyright © 2019 com.Kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDSCateyeMoreCell : UITableViewCell

@property(nonatomic,readonly,copy,class)NSString * ID;
@property (nonatomic,readwrite,strong)UILabel * titleNameLb;
@property (nonatomic,readwrite,strong)UIButton * selectBtn;

@end

NS_ASSUME_NONNULL_END
