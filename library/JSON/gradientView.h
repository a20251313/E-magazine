//
//  gradientView.h
//  gradientView
//
//  Created by aplee on 12-11-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface gradientView : UIView
{
    UIColor* StartColor;
    UIColor* EndColor;
}

@property (nonatomic, strong) UIColor* StartColor;
@property (nonatomic, strong) UIColor* EndColor;


-(void)setStartColor:(UIColor *)start withEndColor:(UIColor*)end;
 


@end
