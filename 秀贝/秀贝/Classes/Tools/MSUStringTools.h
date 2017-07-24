//
//  MSUStringTools.h
//  测试
//
//  Created by Zhuge_Su on 2017/7/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSUStringTools : NSObject

/* 移除字符串中的空格和换行 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

/* 将阿拉伯数字转换成汉文数字 */
+ (NSString *)translationToStringWithArabicNum:(NSInteger)arabicNum;

/* 将日期转换成古月份 */
+ (NSString *)translationChineseWithArabicNum:(NSInteger)arabicNum;

/* 判断字符串中是否有中文 */
+ (BOOL)isContainChinese:(NSString *)str;

/* 富文本 修改局部字段颜色 */
+ (NSMutableAttributedString*)changeLabelWithText:(NSString*)needText;

/* 动态获取 String 宽 */
+ (CGSize)danamicGetWidthFromText:(NSString *)text WithFont:(UIFont *)font;

/* 动态获取 String 高 */
+ (CGRect)danamicGetHeightFromText:(NSString *)text WithWidth:(CGFloat)width font:(UIFont *)font;


@end
