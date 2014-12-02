//
//  BAGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BACPTGraph.h"

@implementation BACPTGraph
@synthesize labelCount;
@synthesize labelIndex;
@synthesize isSameLacation;
-(BOOL)pointingDeviceDownEvent:(id)event atPoint:(CGPoint)interactionPoint
{
	// Plots
    if (self.plotAreaFrame.plotArea.annotations.count>0) {
        [self.plotAreaFrame.plotArea removeAllAnnotations];
    }
    labelCount=0;
    labelIndex=0;
    isSameLacation=NO;
	for ( CPTPlot *plot in [self.allPlots reverseObjectEnumerator] ) {
        
		if ( [plot pointingDeviceDownEvent:event atPoint:interactionPoint] ) {
			//return YES;
            labelIndex++;
            labelCount++;
            
		}
	}
    if (labelCount>0) {
        return YES;
    }
	// Axes Set
	if ( [self.axisSet pointingDeviceDownEvent:event atPoint:interactionPoint] ) {
		return YES;
	}
    
	// Plot area
	if ( [self.plotAreaFrame pointingDeviceDownEvent:event atPoint:interactionPoint] ) {
		return YES;
	}
    
	// Plot spaces
	// Plot spaces do not block events, because several spaces may need to receive
	// the same event sequence (e.g., dragging coordinate translation)
	BOOL handledEvent = NO;
	for ( CPTPlotSpace *space in self.allPlotSpaces ) {
		BOOL handled = [space pointingDeviceDownEvent:event atPoint:interactionPoint];
		handledEvent |= handled;
	}
    
	return YES;
}
@end
