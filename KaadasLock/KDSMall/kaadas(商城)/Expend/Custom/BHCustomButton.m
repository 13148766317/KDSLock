//
//  BHCustomButton.m
//   王宝弘
//
//  Created by 宝弘 on 2019/6/19.
//  Copyright © 2019年  王宝弘. All rights reserved.
//

#import "BHCustomButton.h"

@implementation BHCustomButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
}
@end
