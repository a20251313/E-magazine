//
//  BALineGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAAxisGraph.h"
#import "BAReport.h"

@interface BAMixGraph2 : BAAxisGraph<CPTScatterPlotDelegate,CPTScatterPlotDataSource,CPTBarPlotDelegate,CPTBarPlotDataSource,CPTScatterPlotDataSource,CPTScatterPlotDelegate>
{
    @public
    //某些特定图形label横向位置
    CGFloat labelOffset;
    BOOL hasZeroAxis;
    BOOL isPositive;
}
-(void)configurePlots:(BAReport*)report;
@end
