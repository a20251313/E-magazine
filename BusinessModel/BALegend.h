//
//  BALegend.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BALineStyle.h"
#import "BAColor.h"
#import "BATextStyle.h"

@interface BALegend : NSObject
@property (nonatomic) int legendAnchor;
@property (nonatomic,strong) BALineStyle *borderStyle;
@property (nonatomic,strong) BAColor *fillColor;
@property (nonatomic,strong) BATextStyle *textStyle;
@end
