//
//  gradientView.m
//  gradientView
//
//  Created by aplee on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "gradientView.h"


@implementation gradientView
@synthesize StartColor, EndColor;

-(void)defaultDraw
{
    [self setStartColor:[UIColor whiteColor] withEndColor:[UIColor blackColor]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defaultDraw];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultDraw];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultDraw];
    }
    return self;
}

-(void)setStartColor:(UIColor *)start withEndColor:(UIColor*)end
{
    self.startColor = start;
    self.endColor = end;
    
    //[self setNeedsDisplay];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = [self bounds];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:(id)self.StartColor.CGColor, 
                       (id)self.EndColor.CGColor, 
                       nil];
    [self.layer addSublayer:gradient];

}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //UIGraphicsBeginImageContext([self bounds].size);
    /*CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CAGradientLayer* calayer = [[CAGradientLayer alloc] initWithLayer:self.layer];
    calayer.locations = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil];
    calayer.colors = [[NSArray alloc]initWithObjects:[UIColor whiteColor], [UIColor blackColor], nil];
    [calayer drawInContext:ref];*/
     
    
    //UIGraphicsEndImageContext();
}


@end
