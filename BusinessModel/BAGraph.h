//
//  BAGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BALineStyle.h"
#import "BATextStyle.h"
#import "BAColor.h"


@interface BAGraph : NSObject
@property (nonatomic,strong) BALineStyle * axisLineStyle;
@property (nonatomic,strong) BALineStyle * majorGridLineStyle;
@property (nonatomic,strong) BATextStyle * xLabelStyle;
@property (nonatomic,strong) BATextStyle * ylabelStyle;
@property (nonatomic,strong) BAColor *fillColor;
@end
