//
//  BAAxisGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAAxisGraph.h"
#import "BAAnimationHelper.h"

@implementation BAAxisGraph


-(float)getYMajorIntervalLength:(NSDecimal*)maxDataValue
{
    return 0;
}

-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    [super renderInHostView:hostView];
    
}
-(void)renderLegendInHostView:(CPTGraphHostingView *)hostView
{
    CPTLegend *theLegend=[CPTLegend legendWithGraph:graph];
    
	//theLegend.borderLineStyle = axisLineStyle;
    int numberOfRows=1;
    float totalWidth=0;
    for (CPTPlot *plot in [graph allPlots]) {
        NSString *stringName= (NSString*)plot.identifier;
        float width = [stringName sizeWithFont:[UIFont boldSystemFontOfSize:15]].width;
        totalWidth+=width;
    }
    if (totalWidth>hostView.frame.size.width) {
        numberOfRows++;
    }
    theLegend.numberOfRows	  = numberOfRows;
	theLegend.cornerRadius	  = 10.0;
	theLegend.swatchSize	  = CGSizeMake(20.0, 20.0);
	theLegend.rowMargin		  = 0;
    
	theLegend.paddingLeft	  = 12.0;
    graph.legendAnchor		 = CPTRectAnchorBottom;
    graph.legend=theLegend;
}
-(void)renderAxisInHostView:(CPTGraphHostingView *)hostView
{/*
    graph=[[CPTXYGraph alloc]initWithFrame:hostView.bounds];

    hostView.hostedGraph=graph;
    
    graph.fill=[CPTFill fillWithColor: [CPTColor clearColor]];
    graph.paddingBottom=20;
    //[graph removePlotSpace:[graph defaultPlotSpace]];
    
    CPTXYPlotSpace *plotSpace2 = [[CPTXYPlotSpace alloc] init];
    plotSpace2.identifier=@"plotSpace2";
    plotSpace2.delegate=self;
    plotSpace2.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
    plotSpace2.yRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(140)];
    [graph addPlotSpace:plotSpace2];
    
    CPTXYPlotSpace *plotSpace=[[CPTXYPlotSpace alloc] init];
    //plotSpace.allowsUserInteraction=YES;
    plotSpace.delegate=self;
    plotSpace.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
    plotSpace.yRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:[self getMaxDataValue]];
    [graph addPlotSpace:plotSpace];
    
    
    
    CPTPlot *plot1=[plots objectAtIndex:0];
    CPTPlot *plot2=[plots objectAtIndex:1];
    CPTPlot *plot3=[plots objectAtIndex:2];
    CPTPlot *plot4=[plots objectAtIndex:3]; 
    [plot1 setPlotSpace:plotSpace2];
    [plot2 setPlotSpace:plotSpace2];
    [plot3 setPlotSpace:plotSpace2];
    [plot4 setPlotSpace:plotSpace2];
    for (CPTPlot *plot in plots) {
        plot.delegate=self;
        plot.dataSource=self;
        [graph addPlot:plot];
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotScaleAnimation:plot];
    }
    
    
    graph.plotAreaFrame.paddingBottom=40;
    graph.plotAreaFrame.paddingLeft=50;
    graph.plotAreaFrame.paddingTop=10;
    graph.plotAreaFrame.paddingRight=50;
    
    CPTMutableLineStyle *axisStyle=[CPTMutableLineStyle lineStyle];
    axisStyle.lineWidth=2;
    axisStyle.lineColor=[CPTColor grayColor];
    
    CPTXYAxisSet *axisSet=(CPTXYAxisSet*)graph.axisSet;
    CPTXYAxis *x=axisSet.xAxis;
    x.axisLineStyle=axisStyle;
    x.majorIntervalLength=CPTDecimalFromFloat(1);
    x.minorTicksPerInterval=0;
    x.labelingPolicy=CPTAxisLabelingPolicyNone;
    x.plotSpace=plotSpace;
    //label
    CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
    textStyle.color=[CPTColor grayColor];
    textStyle.fontSize=12;
    NSMutableArray *xlabels=[[NSMutableArray alloc]init ];
    for (int i=0; i<tempLabel.count; i++) {
        CPTAxisLabel *xlabel=[[CPTAxisLabel alloc]initWithText:[tempLabel objectAtIndex:i] textStyle:textStyle];
        xlabel.tickLocation=[[NSDecimalNumber numberWithFloat:i+0.5] decimalValue];
        xlabel.offset=5;
        [xlabels addObject:xlabel];
    }
    x.axisLabels=[NSSet setWithArray:xlabels];
    
    
    CPTMutableLineStyle *yMajorGridLineStyle=[CPTMutableLineStyle lineStyle];
    yMajorGridLineStyle.lineWidth=1;
    yMajorGridLineStyle.lineColor=[CPTColor grayColor];
    CPTXYAxis *y=axisSet.yAxis;
    
    NSDecimalNumber *maxDataValue=[NSDecimalNumber decimalNumberWithDecimal:[self getMaxDataValue]];
    NSDecimalNumber *interval=[maxDataValue decimalNumberByDividingBy:(NSDecimalNumber*)[NSDecimalNumber numberWithInt:5]];
    y.majorIntervalLength=[interval decimalValue];
    y.minorTicksPerInterval=0;
    y.plotSpace=plotSpace;
    //y.preferredNumberOfMajorTicks=4;
    
    //y.majorGridLineStyle=yMajorGridLineStyle;
    CPTXYAxis *y2 = [[CPTXYAxis alloc] init];
	y2.coordinate				   = CPTCoordinateY;
	y2.plotSpace				   = plotSpace2;
	y2.orthogonalCoordinateDecimal = CPTDecimalFromFloat([self getMaxRange]);
    y2.majorIntervalLength=[interval decimalValue];
	y2.labelingPolicy			   = CPTAxisLabelingPolicyAutomatic;
	y2.separateLayers			   = NO;
	y2.tickDirection			   = CPTSignPositive;
	y2.axisLineStyle			   = axisStyle;
    y2.preferredNumberOfMajorTicks=4;
    
    NSMutableArray *y2labels=[[NSMutableArray alloc]init ];
    for (int i=0; i<5; i++) {
        float value=100.0/(5-i);
        CPTAxisLabel *y2label=[[CPTAxisLabel alloc]initWithText:[NSString stringWithFormat:@"%.1f",value] textStyle:textStyle];
        NSDecimalNumber *maxDataValue=[NSDecimalNumber decimalNumberWithDecimal:[self getMaxDataValue]];
        NSDecimalNumber *location=[maxDataValue decimalNumberByDividingBy:(NSDecimalNumber*)[NSDecimalNumber numberWithInt:5]];
        y2label.tickLocation=[location decimalNumberByMultiplyingBy:[NSDecimalNumber CPTDecimalFromInt(i)] ;
        y2label.offset=5;
        [y2labels addObject:y2label];
    }
    y2.axisLabels=[NSSet setWithArray:y2labels];*/
	//y2.majorTickLength			   = 6.0;
	//y2.majorTickLineStyle		   = axisStyle;
	//y2.minorTickLength			   = 4.0;
    
	// Add the y2 axis to the axis set
	/*graph.axisSet.axes = [NSArray arrayWithObjects:x, y, y2, nil];
    [self renderLegendInHostView:hostView];*/
}
@end
