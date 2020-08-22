//
//  KDSHomeBannerView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/7.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeBannerView.h"
#import "KDSFirstPartModel.h"
@interface KDSHomeBannerView ()
<SDCycleScrollViewDelegate>

@end

@implementation KDSHomeBannerView

-(void)setBannerArray:(NSArray *)bannerArray{
    if ([KDSMallTool checkObjIsNull:bannerArray]) {
        return;
    }
    _bannerArray = bannerArray;
    
    NSMutableArray * imageUrlArray = [NSMutableArray array];
    for (KDSFirstPartBannerModel * model in _bannerArray) {
        [imageUrlArray addObject:[KDSMallTool checkISNull:model.imgUrl]];
    }
    _bannerView.imageURLStringsGroup = imageUrlArray;
   
}


-(void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray ;
    _bannerView.imageURLStringsGroup = _imageUrlArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
//        _bannerView.currentPageDotImage = [UIImage imageNamed:@"hengxian_select"];
//        _bannerView.pageDotImage = [UIImage imageNamed:@"hengxian"] ;
//        _bannerView.pageControlDotSize = CGSizeMake(20, 18);
//        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _bannerView.pageControlBottomOffset = -12;
//        _bannerView.autoScrollTimeInterval = 5.0f;
        _bannerView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#F2F2F2"];
        _bannerView.showPageControl = NO;
        _bannerView.placeholderImage = [UIImage imageNamed:placeholder_w];
         _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bannerView.autoScrollTimeInterval = 3;
        [self addSubview:_bannerView];
    }
    return self;
}

-(void)layoutSubviews{
    _bannerView.frame = self.bounds;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    if ([_delegate respondsToSelector:@selector(homeBannerViewSelectItemAtIndex:)]) {
        [_delegate homeBannerViewSelectItemAtIndex:index];
    }
    
}
@end
