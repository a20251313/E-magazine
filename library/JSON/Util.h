//
//  Util.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+(UIColor *)stringToUIColor:(NSString *)color alpha:(NSString *)alpha;

+(UIColor*) colorFormBegin:(UIColor*)color1 end:(UIColor*)color2 percent:(float)percent;

//得到一个绘制的圆，需要提供圆的size，fillColor，strokeColor,用于地图的annotation
+(UIImage*)getRoundWithSize:(CGSize)size fillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor;

//返回哑绿，哑红，带50%透明
+(UIColor*)getMuteRed;
+(UIColor*)getMuteGreen;
//表格中，headercell的字体颜色
+(UIColor*)getTableFontColor;


// 只是保留小数点后几位
+(NSString *)notRounding:(float)price afterPoint:(int)position;

// 小数点后保留两位 并且添加千分符
+(NSString *)getStringValueFromFloat:(float) floatValue;

// 根据标志为判断是否需要添加百分号 并且四舍五入保留两位
+(NSString *)getAddPercentString:(float)floatValue withTag:(BOOL) isNeed;
@end
