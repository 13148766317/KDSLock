//
//  KDSTextView.m
//  kaadas
//
//  Created by 宝弘 on 2019/5/14.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "KDSTextView.h"

@implementation KDSTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        _leftSpacing = 5;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

/**
 *监听文字改变
 */
-(void)textDidChange{
    //重绘（重新调用）
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    //setNeedsDisplay会在下有一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //如果有输入文字，就直接返回
    if (self.hasText) {
        return;
    }
    //文字属性
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderCorlor?self.placeholderCorlor:[UIColor lightGrayColor];
    
    CGFloat x = _leftSpacing;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
@end
