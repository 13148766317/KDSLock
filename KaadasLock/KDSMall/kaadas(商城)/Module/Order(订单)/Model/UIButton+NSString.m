//
//  UIButton+NSString.m
//  Rent3.0
//
//  Created by Apple on 2018/7/24.
//  Copyright © 2018年 whb. All rights reserved.
//

#import "UIButton+NSString.h"
#import <objc/runtime.h>
static const void *MaxLengthKey = @"MaxLengthKey";
static const void *IndentInfoArrKey = @"IndentInfoKey";

@implementation UIButton (NSString)

-(void)setIdString:(NSString *)idString{
    objc_setAssociatedObject(self, MaxLengthKey,idString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(NSString *)idString{
    return objc_getAssociatedObject(self, MaxLengthKey) ;

}

-(void)setIndentInfoArr:(NSMutableArray *)indentInfoArr{
    objc_setAssociatedObject(self, IndentInfoArrKey,indentInfoArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(NSMutableArray *)indentInfoArr{
    return objc_getAssociatedObject(self, IndentInfoArrKey) ;

}

@end
