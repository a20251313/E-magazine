//
//  Util.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Util.h"

@implementation Util

+(UIColor *)stringToUIColor:(NSString *)color alpha:(NSString *)alpha{
    if(alpha==nil||[alpha isEqualToString:@""]){
        alpha=@"1";
    }
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    CGFloat talpha=[alpha floatValue];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:talpha];
}


+(UIColor*) colorFormBegin:(UIColor*)color1 end:(UIColor*)color2 percent:(float)percent
{
    float red1 ,green1, blue1, alpha1, red2, green2, blue2, alpha2, redRes, greenRes, blueRes, alphaRes;
    if ( ([color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1] && [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2]) ) {
        
        redRes = (red2 - red1) * percent + red1;
        blueRes = (blue2 - blue1) * percent + blue1;
        greenRes = (green2 - green1) * percent + green1;
        alphaRes = (alpha2 - alpha1) * percent + alpha1;
    }
    else {
        redRes = blueRes = greenRes = alphaRes = 1.0f;
    }
    
    UIColor* resColor = [UIColor colorWithRed:redRes green:greenRes blue:blueRes alpha:alphaRes];
    return resColor;
    
}

+(UIImage*)getRoundWithSize:(CGSize)size fillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor
{
    UIGraphicsBeginImageContext(size);//创建图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef fillColorRef = [fillColor CGColor];
    CGColorRef strokeColorRef = [strokeColor CGColor];
    
    CGContextSetStrokeColorWithColor(context, strokeColorRef);
    CGContextSetFillColorWithColor(context, fillColorRef);
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();//转成UIImage
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(UIColor*)getMuteRed
{
    return [UIColor colorWithRed:240.0f/255.0f green:78.0f/255.0f blue:55.0f/255.0f alpha:0.8f];
}

+(UIColor*)getMuteGreen
{
    return [UIColor colorWithRed:102.0f/255.0f green:183.0f/255.0f blue:33.0f/255.0f alpha:0.5f];
}

//表格中，headercell的字体颜色
+(UIColor*)getTableFontColor
{
    return [UIColor colorWithRed:19.f/255.f green:72.f/255.f blue:106.f/255.f alpha:1.f];
}

/*
 作用: 只是保留几位 不四舍五入
 price:需要处理的数字，
 position：保留小数点第几位
 */
+(NSString *)notRounding:(float)price afterPoint:(int)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    //[ouncesDecimal release];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


/*
 输入  float
 返回  小数点后保留两位 带有千分符的字符串
 */
+(NSString *)getStringValueFromFloat:(float) floatValue
{
    //double number = (double)floatValue;
    float number = round(floatValue*100)/100;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    
    NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    //[numberFormatter release];
    
    return numberString;
}


/*
 根据标志位判断是否需要添加百分号
 */
+(NSString *)getAddPercentString:(float)floatValue withTag:(BOOL) isNeed
{
    NSString *str = @"";
    
    if(isNeed)
    {
        str = [NSString stringWithFormat:@"%.02f%%",floatValue];
    }
    else
    {
        str = [NSString stringWithFormat:@"%.02f",floatValue];
    }
    
    return str;
}

@end
