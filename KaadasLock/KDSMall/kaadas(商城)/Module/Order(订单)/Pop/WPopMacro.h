//
//  WPopMacro.h
//  Demo
//
//  Created by 王皇保 on 2019/6/18.
//  Copyright © 2019 WellsCai. All rights reserved.
//

#ifndef WPopMacro_h
#define WPopMacro_h


#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef void(^YCCompleteHandle)(BOOL presented);

typedef NS_ENUM(NSUInteger, YCPopoverType){
    YCPopoverTypeActionSheet = 1,
    YCPopoverTypeAlert = 2
};
#endif /* WPopMacro_h */
