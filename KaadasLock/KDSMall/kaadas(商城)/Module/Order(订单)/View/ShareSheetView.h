//
//  ShareSheetView.h
//  FMActionSheet
//
//  Created by David on 2017/7/17.
//  Copyright © 2017年 Subo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickblock)(int index);

@interface ShareSheetView : UIView
@property(nonatomic ,copy)clickblock btnBlock;
@property(nonatomic ,strong) UIView* contentView;

- (instancetype)initWithTitle:(NSString *)title
                  rightTitles:(NSString *)titlee;

- (void)show;
-(void)dismiss;

@end

