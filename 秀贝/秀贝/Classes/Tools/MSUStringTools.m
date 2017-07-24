//
//  MSUStringTools.m
//  测试
//
//  Created by Zhuge_Su on 2017/7/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUStringTools.h"
#import <UIKit/UIKit.h>

@implementation MSUStringTools

#pragma mark - 移除字符串中的空格和换行
/* 移除字符串中的空格和换行 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

#pragma mark - 判断字符串中是否有中文
/* 判断字符串中是否有中文 */
+ (BOOL)isContainChinese:(NSString *)str{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

#pragma mark - 将阿拉伯数字转换成汉文数字
/* 将阿拉伯数字转换成汉文数字 */
+ (NSString *)translationToStringWithArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
            
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

#pragma mark - 将日期转换成古月份
/* 将日期转换成古月份 */
+ (NSString *)translationChineseWithArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray *chineseNumeralsArray = @[@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖",@"拾",@"冬",@"腊"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    NSString *chinese = [dictionary objectForKey:arabicNumStr];
    return chinese;
    
}

#pragma mark - 富文本 修改局部字段颜色
/* 富文本 修改局部字段颜色 */
+ (NSMutableAttributedString*)changeLabelWithText:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0,1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:3/255.0 blue:4/255.0 alpha:1] range:NSMakeRange(0,1)];
    
    [attrString addAttribute:NSKernAttributeName value:@1.0f range:NSMakeRange(0, needText.length)];
    
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(1,needText.length-1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1,needText.length-1)];
    
    return attrString;
}

#pragma amrk - 动态获取 String 宽高
/* 动态获取 String 宽 */
+ (CGSize)danamicGetWidthFromText:(NSString *)text WithFont:(UIFont *)font{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size;
}

/* 动态获取 String 高 */
+ (CGRect)danamicGetHeightFromText:(NSString *)text WithWidth:(CGFloat)width font:(UIFont *)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect;
}

@end
