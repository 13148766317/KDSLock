//
//  UITextField+Length.h
//  rent
//
//  Created by David on 16/4/28.
//  Copyright © 2016年 whb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Length)
@property (nonatomic,readonly) NSNumber * maxLength;
- (void)setMaxLen:(NSInteger)maxLen;
@end
