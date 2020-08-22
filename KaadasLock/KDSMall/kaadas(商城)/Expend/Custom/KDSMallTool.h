//
//  KDSMallTool.h

//  Created by 中软云 on 2019/3/12.
//  Copyright © 2019 qizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KDSMallTool : NSObject

// 创建label
+(UILabel*)createLabelString:(NSString *)string  textColorString:(NSString *)colorString font:(CGFloat)font;
// 创建粗体label
+(UILabel*)createbBoldLabelString:(NSString *)string  textColorString:(NSString *)colorString font:(CGFloat)font;
//创建UITextField
+(UITextField *)createTextfieldpPlaceholder:(NSString *)placeHolder;
//根据颜色生成图片
+ (UIImage *)createImageWithColor:(UIColor*)color;
//计算文本长度
+(float)getStringWidth:(NSString*)str font:(CGFloat)Font;
//计算文本高度
+(float)getNSStringHeight:(NSString*)str textMaxWith:(CGFloat)maxWidth font:(CGFloat)font;
//计算文本高度
+(float)getNSStringHeight:(NSString*)str textMaxWith:(CGFloat)maxWidth font:(CGFloat)font lineSpacing:(CGFloat)lineSpacing;
//分割线控件
+(UIView *)createDividingLineWithColorstring:(NSString *)colorstr;
//设置字体的间隔
+(NSMutableAttributedString *)attributedString:(NSString*)str lineSpacing:(CGFloat)lineSpacing;
//设置字体的样式
+(NSMutableAttributedString *)attributedString:(NSString*)str dict:(NSDictionary *)dict range:(NSRange)range lineSpacing:(CGFloat)lineSpacing;
//设置字体的样式
+(NSMutableAttributedString *)attributedString:(NSString*)str dict:(NSDictionary *)dict range:(NSRange)range lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment;
//常见渐变
+(CAGradientLayer *)createGradientlayer:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray<NSNumber *>*)locations;


+(NSString *)checkISNull:(id)obj;

+(BOOL)checkObjIsNull:(id)obj;

+(NSString *)numToString:(NSInteger)num;
+(NSString *)numberForString:(double)num maximumFractionDigits:(NSUInteger)mixNum;
// 获得Info.plist数据字典
+ (NSDictionary *)getInfoDictionary;
/// Return YES if Authorized 返回YES如果得到了授权
+ (BOOL)authorizationStatusAuthorized;
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;
//保存登录名
+(void)saveAccount:(NSString *)account;
//取登录名
+(NSString *)loadAccount;
//时间戳转时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
+(NSDate *)dateForStringWithDate:(NSString *)dateString dataFormat:(NSString *)format;
//结束时间与当前时间相差的秒数
+(double)durationIndistanceSeconds:(NSString  *)endDateString;
//在view里找到对应的viewcontroller
+ (UIViewController*)getCurrentViewController:(UIView *)view;

//形象大使海报图缩放比例
+(CGFloat)posterScaleUpRatio;
//形象大使海二维码缩放比例
+(CGFloat)posterQRCodeScaleUpRatio;

@end

NS_ASSUME_NONNULL_END
