//
//  UITextField+Length.m
//  rent
//
//  Created by David on 16/4/28.
//  Copyright © 2016年 whb. All rights reserved.
//

#import "UITextField+Length.h"
static const void *MaxLengthKey = &MaxLengthKey;
@implementation UITextField (Length)
@dynamic maxLength;

- (NSNumber *)maxLength {
    return objc_getAssociatedObject(self, MaxLengthKey);
}

- (void)setMaxLength:(NSNumber *)maxLength{
    objc_setAssociatedObject(self, MaxLengthKey, maxLength, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)setMaxLen:(NSInteger)maxLen {
    
    self.maxLength=[[NSNumber alloc]initWithInteger:maxLen] ;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > self.maxLength.integerValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            textField.text = [textField.text substringToIndex:self.maxLength.integerValue];
            
        });
    }
}

@end
