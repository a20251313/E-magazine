#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define CPTColorRGB(r,g,b) [CPTColor colorWithComponentRed:r/255. green:g/255. blue:b/255. alpha:1.]
#define CPTColorRGBHex(rgbValue) [CPTColor colorWithComponentRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CPTColor : NSObject<NSCopying, NSCoding> {
	@private
	CGColorRef cgColor;
}

@property (nonatomic, readonly, assign) CGColorRef cgColor;

/// @name Factory Methods
/// @{
+(CPTColor *)clearColor;
+(CPTColor *)whiteColor;
+(CPTColor *)lightGrayColor;
+(CPTColor *)grayColor;
+(CPTColor *)darkGrayColor;
+(CPTColor *)blackColor;
+(CPTColor *)redColor;
+(CPTColor *)greenColor;
+(CPTColor *)blueColor;
+(CPTColor *)cyanColor;
+(CPTColor *)yellowColor;
+(CPTColor *)magentaColor;
+(CPTColor *)orangeColor;
+(CPTColor *)purpleColor;
+(CPTColor *)brownColor;

+(CPTColor *)colorWithCGColor:(CGColorRef)newCGColor;
+(CPTColor *)colorWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(CPTColor *)colorWithGenericGray:(CGFloat)gray;
///	@}

/// @name Initialization
/// @{
-(id)initWithCGColor:(CGColorRef)cgColor;
-(id)initWithComponentRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

-(CPTColor *)colorWithAlphaComponent:(CGFloat)alpha;
///	@}

@end
