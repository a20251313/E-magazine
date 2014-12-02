//
//  BAAxisGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseGraph.h"

@interface BAAxisGraph : BABaseGraph<CPTPlotSpaceDelegate>
{
    //CPTGraph *graph;
}

-(void)renderInHostView:(CPTGraphHostingView*)hostView;
-(void)renderAxisInHostView:(CPTGraphHostingView*)hostView;
-(void)renderLegendInHostView:(CPTGraphHostingView *)hostView;
@end
