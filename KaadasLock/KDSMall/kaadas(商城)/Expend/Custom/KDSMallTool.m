//
//  QZTool.m
//  QiZhiClass
//
//  Created by 中软云 on 2019/3/12.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import "KDSMallTool.h"
//#import <PHPhotoLibrary.h>
@implementation KDSMallTool

// 创建label
+(UILabel*)createLabelString:(NSString *)string  textColorString:(NSString *)colorString font:(CGFloat)font{
    UILabel * label =[[UILabel alloc]init];
    label.text = string;
    label.textColor = [UIColor hx_colorWithHexRGBAString:colorString];
    label.font = [UIFont systemFontOfSize:font];
    return label;
}
// 创建粗体label
+(UILabel*)createbBoldLabelString:(NSString *)string  textColorString:(NSString *)colorString font:(CGFloat)font{
    UILabel * label =[[UILabel alloc]init];
    label.text = string;
    label.textColor = [UIColor hx_colorWithHexRGBAString:colorString];
    label.font = [UIFont boldSystemFontOfSize:font];
    return label;
}
//创建UITextField
+(UITextField *)createTextfieldpPlaceholder:(NSString *)placeHolder{
    UITextField * textfield = [[UITextField alloc]init];
    textfield.placeholder = placeHolder;
    
    return textfield;
}

//根据颜色生成图片
+ (UIImage *)createImageWithColor:(UIColor*)color {
    CGRect rect= CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    //  拿到当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    //  一定要要手动关闭上下文
    UIGraphicsEndImageContext();
    return theImage;
}

//计算文本长度
+(float)getStringWidth:(NSString*)str font:(CGFloat)Font {
    float width=0.0f;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:Font]};
    CGSize sizeName = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0)
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    width = sizeName.width;
    return width;
}

//计算文本高度
+(float)getNSStringHeight:(NSString*)str textMaxWith:(CGFloat)maxWidth font:(CGFloat)font {
    float height=0.0f;
    
    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6; // 调整行间距
    
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
   
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paragraphStyle};
    CGSize sizeName = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                        options: NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    
    height = sizeName.height;
    return height;
}

//计算文本高度
+(float)getNSStringHeight:(NSString*)str textMaxWith:(CGFloat)maxWidth font:(CGFloat)font lineSpacing:(CGFloat)lineSpacing{
    float height=0.0f;
    
    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing; // 调整行间距
    
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paragraphStyle};
    CGSize sizeName = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                        options: NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    
    height = sizeName.height;
    return height;
}

//分割线控件
+(UIView *)createDividingLineWithColorstring:(NSString *)colorstr{
    UIView * dividingLine = [[UIView alloc]init];
    dividingLine.backgroundColor = [UIColor hx_colorWithHexRGBAString:colorstr];
    return dividingLine;
}
//设置字体的间隔
+(NSMutableAttributedString *)attributedString:(NSString*)str lineSpacing:(CGFloat)lineSpacing{
    
    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing; // 调整行间距
//    [attribut addAttributes:dict range:range];
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    return attribut;
}
//设置字体的样式
+(NSMutableAttributedString *)attributedString:(NSString*)str dict:(NSDictionary *)dict range:(NSRange)range lineSpacing:(CGFloat)lineSpacing{
    
    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing; // 调整行间距
    [attribut addAttributes:dict range:range];
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    return attribut;
}
//设置字体的样式
+(NSMutableAttributedString *)attributedString:(NSString*)str dict:(NSDictionary *)dict range:(NSRange)range lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment{
    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing; // 调整行间距
    paragraphStyle.alignment = alignment;
    [attribut addAttributes:dict range:range];
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    return attribut;
}

//常见渐变
+(CAGradientLayer *)createGradientlayer:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray<NSNumber *>*)locations{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = startPoint;
    gl.endPoint = endPoint;
    gl.colors = colors;
    gl.locations = locations;
    return gl;
}

+(NSString *)checkISNull:(id)obj {
    if (obj == [NSNull null]||obj== nil) {
        return @"";
    }else {
        return obj;
    }
}
+(BOOL)checkObjIsNull:(id)obj{
    if (obj == [NSNull null] || obj == nil) {
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)numToString:(NSInteger)num{
    if (num >10000) {
        double result = (double)num / 10000.0;
        return  [NSString stringWithFormat:@"%@万",[self numberForString:result maximumFractionDigits:1]];
    }else{
        return  [NSString stringWithFormat:@"%ld",(long)num];
    }
}

+(NSString *)numberForString:(double)num maximumFractionDigits:(NSUInteger)mixNum{
    NSNumber * number = [NSNumber numberWithDouble:num];
    NSNumberFormatter * formater  = [[NSNumberFormatter alloc]init];
    //不四舍五入
    formater.roundingMode = kCFNumberFormatterRoundFloor;
    //做少保留两位小数
    formater.maximumFractionDigits = mixNum;
    
    NSString * newNumStr = [formater stringFromNumber:number];
    return newNumStr;
}

// 获得Info.plist数据字典
+ (NSDictionary *)getInfoDictionary {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return infoDict ? infoDict : @{};
}


/// Return YES if Authorized 返回YES如果得到了授权
//+ (BOOL)authorizationStatusAuthorized {
//    NSInteger status = [PHPhotoLibrary authorizationStatus];
//    if (status == 0) {
//        /**
//         * 当某些情况下AuthorizationStatus == AuthorizationStatusNotDetermined时，无法弹出系统首次使用的授权alertView，系统应用设置里亦没有相册的设置，此时将无法使用，故作以下操作，弹出系统首次使用的授权alertView
//         */
//        [self   requestAuthorizationWithCompletion:^{
//
//        }];
//    }
//
//    return status == 3;
//}
//
//+ (void)requestAuthorizationWithCompletion:(void (^)(void))completion {
//    void (^callCompletionBlock)(void) = ^(){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (completion) {
//                completion();
//            }
//        });
//    };
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            callCompletionBlock();
//        }];
//    });
//}
//+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value {
//    NSBundle *bundle = [TZImagePickerConfig sharedInstance].languageBundle;
//    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
//    return value1;
//}

//保存登陆名
+(void)saveAccount:(NSString *)account{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"userAccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//取登录名
+(NSString *)loadAccount{
    NSString * account =   [[NSUserDefaults standardUserDefaults] objectForKey:@"userAccount"];
    return [KDSMallTool checkISNull:account];
}

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}

+(NSDate *)dateForStringWithDate:(NSString *)dateString dataFormat:(NSString *)format{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    return  [dateFormatter dateFromString:dateString];
}

//结束时间与当前时间相差的秒数
+(double)durationIndistanceSeconds:(NSString  *)endDateString{
    //时间格式转换  时间字符串转时间
    NSDate * endDate = [self dateForStringWithDate:endDateString dataFormat:@"yyyy-MM-dd HH:mm:ss"];
    //获取本地时间
    NSDate *startDate = [HelperTool shareInstance].clock.networkTime;
    //时间之间相差秒数
    DTTimePeriod   * timePeriod =[[DTTimePeriod alloc] initWithStartDate:startDate endDate:endDate];
    //    _durationInSeconds = 3000000; //; [timePeriod durationInSeconds];  //相差秒
     double  durationInSeconds  = [timePeriod durationInSeconds];
    return   durationInSeconds > 0 ? durationInSeconds : 0 ;//相差秒
}
//在view里找到对应的viewcontroller
+ (UIViewController*)getCurrentViewController:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
    
}

//形象大使海报图缩放比例
+(CGFloat)posterScaleUpRatio{
    
    if (KSCREENHEIGHT == 568) { // 5/5S/5c/SE
        return 0.8;
    }else if (KSCREENHEIGHT == 667){// 6/6S/7/8
        return 1.05f;
    }else if (KSCREENHEIGHT == 736){// 6+/6S+/7+/8+
        return 1.2f;
    } else if (KSCREENHEIGHT == 812){// X XS
        return 1.2f;
    }else if (KSCREENHEIGHT == 896){ // XS MAX XR
        return 1.3f;
    }else{
        return 1.0f;
    }
}


//形象大使海二维码缩放比例
+(CGFloat)posterQRCodeScaleUpRatio{
    if (KSCREENHEIGHT == 568) { //5/5S/5c/SE
        return 0.8;
    }else if (KSCREENHEIGHT == 667){//6/6S/7/8
        return 1.05f;
    }else if (KSCREENHEIGHT == 736){// 6+/6S+/7+/8+
        return 1.2f;
    }else if (KSCREENHEIGHT == 812){// X XS
        return 1.2f;
    }else if (KSCREENHEIGHT == 896){ // XS MAX XR
        return 1.3f;
    }else{
        return 1.0f;
    }
}

@end
