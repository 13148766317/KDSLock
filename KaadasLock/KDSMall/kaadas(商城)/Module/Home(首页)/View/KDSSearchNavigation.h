//
//  KDSSearchNavigation.h
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KDSSearchNavigationDelegate <NSObject>

-(void)searchNavigationSearchClick:(NSString *_Nullable)searchStr;
-(void)searchTextFieldShouldClear;
-(void)textFieldChange:(NSString *_Nullable)text;
-(void)textFieldReturn:(NSString *_Nullable)text;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KDSSearchNavigation : UIView
@property (nonatomic,weak)id <KDSSearchNavigationDelegate> delegate;
@property (nonatomic,copy)NSString      * text;
@property (nonatomic,strong)UIButton   * backButton;
@end

NS_ASSUME_NONNULL_END
