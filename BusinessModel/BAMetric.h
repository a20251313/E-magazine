//
//  BAMetric.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAColor.h"
@interface BAMetric : NSObject
@property (nonatomic,strong) NSString *metricName;
@property (nonatomic,strong) NSMutableArray *dataValues;
@property (nonatomic,strong) BAColor *fillColor;
@property (nonatomic) int plotType;
@property (nonatomic) BOOL hasY2Axis;
@end
