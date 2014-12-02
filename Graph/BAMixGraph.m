//
//  BALineGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BAMixGraph.h"
#import "BAAnimationHelper.h"
#import "BAReport.h"
#import "BAMetric.h"
#import "BAColorHelper.h"
#import "BACPTGraph.h"

@implementation BAMixGraph
{
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
    bool isLongPress;
    CPTPlot *selectedPlot;
    CPTColor *barLineColor;
    //NSUInteger labelIndex;
}

- (id)init
{
    self = [super init];
    if (self) {
        selectedIndex=-1;
        //labelIndex=-1;
    }
    return self;
}

-(void)configurePlots:(BAReport*)report
{

    //获取报表数据
    NSMutableDictionary *sourceDataD=[[NSMutableDictionary alloc]init];
    for(BAMetric *metric in report.reportData.metrics){
        [sourceDataD setObject:metric.dataValues forKey:metric.metricName];
    }
    
    //临时数据用于显示
    NSMutableDictionary *tempDataD=[NSMutableDictionary dictionaryWithDictionary:sourceDataD];
    
    //获取报表label
    NSMutableArray *sourceLabelD=report.reportData.entity.entityValues;
    NSMutableArray *tempLabelD=[NSMutableArray arrayWithArray:sourceLabelD];
    
    //baseGraph=(BAMixGraph*)[[BAMixGraph alloc]init];
    self.sourceData=sourceDataD;
    self.tempData=tempDataD;
    self.sourceLabel=sourceLabelD;
    self.tempLabel=tempLabelD;
    self.plots=[[NSMutableArray alloc]init];
    
    int barCount=0;
    for (int i=0; i<report.reportData.metrics.count; i++) 
    {
        BAMetric *metric=[report.reportData.metrics objectAtIndex:i];
        if (metric.plotType==0) {
            barCount++;
        }
    }
    int barIndex=0;
    
    self.y2axisArray=[[NSMutableArray alloc]init];
    for (int i=0; i<report.reportData.metrics.count; i++) {
        
        BAMetric *metric=[report.reportData.metrics objectAtIndex:i];
        CPTBarPlot *barPlot=[[CPTBarPlot alloc]init];
        CPTScatterPlot *linePlot=[[CPTScatterPlot alloc]init];
        
        //标记Y2轴数据
        
        if(metric.hasY2Axis)
        {
            [self.y2axisArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        switch (metric.plotType) {
            case 0:
            {
                
                barPlot.identifier=metric.metricName;
                CPTGradient *gradient=[CPTGradient gradientWithBeginningColor:[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:metric.fillColor.alpha] endingColor:[BAColorHelper stringToCPTColor:metric.fillColor.color2 alpha:metric.fillColor.alpha]];
                gradient.angle=metric.fillColor.angle;
                barPlot.fill=[CPTFill fillWithGradient:gradient];
                CPTMutableLineStyle *barLineStyle=[CPTMutableLineStyle lineStyle];
                barLineStyle.lineColor=[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:metric.fillColor.alpha] ;
                barLineStyle.lineWidth=0;
                barPlot.lineStyle=barLineStyle;
                //NSInteger width=barCount+2;
                //barPlot.barWidth=CPTDecimalFromFloat(1.0/width) ;
                //barPlot.barOffset=CPTDecimalFromFloat(1.0/width*(barIndex-1));
                barPlot.barWidth=CPTDecimalFromFloat(1.0/(2*barCount));
                barPlot.barOffset=CPTDecimalFromFloat(1.0/(2*barCount)*barIndex);
                [self.plots addObject:barPlot];
                barIndex++;
            }
                break;
            case 1:
            {
                linePlot.identifier=metric.metricName;
                CPTMutableLineStyle *lineStyle=[CPTMutableLineStyle lineStyle];
                lineStyle.lineColor=[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:metric.fillColor.alpha];
                lineStyle.lineWidth=2;
                linePlot.dataLineStyle=lineStyle; 
                linePlot.plotSymbolMarginForHitDetection=20;
                CPTPlotSymbol *symbol=[CPTPlotSymbol ellipsePlotSymbol ];
                
                CPTMutableLineStyle *symbolLineStyle=[CPTLineStyle lineStyle];
                symbolLineStyle.lineColor=[CPTColor clearColor];
                symbol.lineStyle=symbolLineStyle;
                symbol.fill=[CPTFill fillWithColor:lineStyle.lineColor];
                symbol.size=CGSizeMake(8, 8);
                
                linePlot.plotSymbol=symbol;
                
                [self.plots addObject:linePlot];
            }
                break;
            case 2:
            {
                linePlot.identifier=metric.metricName;
                CPTMutableLineStyle *lineStyle=[CPTMutableLineStyle lineStyle];
                lineStyle.lineColor=[BAColorHelper stringToCPTColor:metric.fillColor.color2 alpha:metric.fillColor.alpha];
                lineStyle.lineWidth=3;
                linePlot.dataLineStyle=lineStyle;  
                CPTGradient *gradient=[CPTGradient gradientWithBeginningColor:[BAColorHelper stringToCPTColor:metric.fillColor.color1 alpha:metric.fillColor.alpha] endingColor:[BAColorHelper stringToCPTColor:metric.fillColor.color2 alpha:metric.fillColor.alpha] ];
                gradient.angle=90;
                linePlot.areaFill=[CPTFill fillWithGradient:gradient];
                linePlot.areaBaseValue=[[NSDecimalNumber zero]decimalValue];
                linePlot.plotSymbolMarginForHitDetection=20;
                
                CPTPlotSymbol *symbol=[CPTPlotSymbol ellipsePlotSymbol ];
                
                CPTMutableLineStyle *symbolLineStyle=[CPTLineStyle lineStyle];
                symbolLineStyle.lineColor=[CPTColor clearColor];
                symbol.lineStyle=symbolLineStyle;
                symbol.fill=[CPTFill fillWithColor:[CPTColor clearColor]];
                symbol.size=CGSizeMake(8, 8);
                
                linePlot.plotSymbol=symbol;
                [self.plots addObject:linePlot];
            }
                break;
        }
        
    }
    
    //[baseGraph renderInHostView:hostView1];
}
-(void)renderAxisInHostView:(CPTGraphHostingView *)hostView
{
    
    graph=[[BACPTGraph alloc]initWithFrame:hostView.bounds];
    
    hostView.hostedGraph=graph;
    
    graph.fill=[CPTFill fillWithColor: [CPTColor clearColor]];
    graph.paddingBottom=20;
    graph.paddingTop=20;
    graph.paddingLeft=20;
    graph.paddingRight=20;
    [graph removePlotSpace:graph.defaultPlotSpace];
    CPTXYPlotSpace *plotSpace=[[CPTXYPlotSpace alloc] init];
    //plotSpace.allowsUserInteraction=YES;
    plotSpace.delegate=self;
    plotSpace.identifier=@"plotSpace1";
    
    [graph addPlotSpace:plotSpace];
    
    CPTXYPlotSpace *plotSpace2 = [[CPTXYPlotSpace alloc] init];
    plotSpace2.identifier=@"plotSpace2";
    plotSpace2.delegate=self;
    //plotSpace2.allowsUserInteraction=YES;
     
     NSMutableArray *plotsInSpace1=[[NSMutableArray alloc]init];
     NSMutableArray *plotsInSpace2=[[NSMutableArray alloc]init];
     for (int i = 0; i<plots.count; i++) {
         CPTPlot *plot=[plots objectAtIndex:i];
         plot.delegate=self;
         plot.dataSource=self;
         if ([y2axisArray containsObject:[NSString stringWithFormat:@"%d",i]]) {
         [plotsInSpace2 addObject:plot];
         plot.plotSpace=plotSpace2;
         [graph addPlot:plot toPlotSpace:plotSpace2];
         }else {
         [plotsInSpace1 addObject:plot];
         plot.plotSpace=plotSpace;
         [graph addPlot:plot toPlotSpace:plotSpace];
         }
         BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
         [animation plotScaleAnimation:plot];
     }
     [plotSpace2 scaleToFitPlots:[NSArray arrayWithArray:plotsInSpace2]];
     [plotSpace scaleToFitPlots:[NSArray arrayWithArray:plotsInSpace1]];
    
    //手动调整y轴显示范围，增加顶部显示范围
    CPTPlotRange *yRange=plotSpace.yRange;
    NSDecimal length=yRange.length;
    NSDecimal locatoin=yRange.location;
    
    NSDecimalNumber *a=[[NSDecimalNumber alloc]initWithDecimal:length];
    NSDecimalNumber *b=[[[NSDecimalNumber alloc]initWithDecimal:length] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.1"]];
    ;
    NSDecimal newLength=[[a decimalNumberByAdding:b] decimalValue];
    plotSpace.yRange=[[CPTPlotRange alloc]initWithLocation:locatoin length:newLength];
    CPTPlotRange *yRange2=plotSpace2.yRange;
    NSDecimal length2=yRange2.length;
    NSDecimal locatoin2=yRange2.location;
    NSDecimalNumber *a2=[[NSDecimalNumber alloc]initWithDecimal:length2];
    NSDecimalNumber *b2=[[[NSDecimalNumber alloc]initWithDecimal:length2] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.1"]];
    ;
    NSDecimal newLength2=[[a2 decimalNumberByAdding:b2] decimalValue];
    plotSpace2.yRange=[[CPTPlotRange alloc]initWithLocation:locatoin2 length:newLength2];
        
     plotSpace2.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
     plotSpace.xRange=[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([self getMaxRange])];
     
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
    
    //手动定义x轴对应y轴坐标
    /*if (locatoin._isNegative) {
        x.orthogonalCoordinateDecimal=CPTDecimalFromFloat(0.0f);
    }else {
        x.orthogonalCoordinateDecimal=locatoin;
    }*/
    
    if (self.xOrthogonalCoordinate==-1) {
        //x.orthogonalCoordinateDecimal=CPTDecimalFromCGFloat(self.xOrthogonalCoordinate);
        x.orthogonalCoordinateDecimal=CPTDecimalFromFloat(0);
    }else {
        x.orthogonalCoordinateDecimal=locatoin;
    }
    
    //label
    CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
    textStyle.color=[CPTColor grayColor];
    textStyle.fontSize=12;
    NSMutableArray *xlabels=[[NSMutableArray alloc]init ];
    for (int i=0; i<tempLabel.count; i++) {
        CPTAxisLabel *xlabel=[[CPTAxisLabel alloc]initWithText:[tempLabel objectAtIndex:i] textStyle:textStyle];
        xlabel.tickLocation=[[NSDecimalNumber numberWithFloat:i+0.5+labelOffset] decimalValue];
        xlabel.offset=5;
        
        [xlabels addObject:xlabel];
    }
    x.axisLabels=[NSSet setWithArray:xlabels];

    //判断xLabel是否需要倾斜
    CPTAxisLabel *labelSample=(CPTAxisLabel*)[xlabels objectAtIndex:0];
    float width=labelSample.contentLayer.bounds.size.width;
    /*if (labelRotation!=0) {
        x.labelRotation= labelRotation;
    }*/
    if (width>=45) {
        x.labelRotation=-0.5;
    }

    CPTMutableLineStyle *yMajorGridLineStyle=[CPTMutableLineStyle lineStyle];
    yMajorGridLineStyle.lineWidth=1;
    yMajorGridLineStyle.lineColor=[CPTColor grayColor];
    CPTXYAxis *y=axisSet.yAxis;

    y.minorTicksPerInterval=0;
    y.plotSpace=plotSpace;
    y.labelingPolicy= CPTAxisLabelingPolicyAutomatic;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    [formatter setMinimumIntegerDigits:1];
    NSString *yString = [formatter stringFromNumber:a];
    float ywidth = [yString sizeWithFont:[UIFont boldSystemFontOfSize:13]].width;
    //判断y轴label是否需要倾斜
    /*if ([a doubleValue]>9999) {
        y.labelRotation=0.5;
    }*/
    
    y.preferredNumberOfMajorTicks=5;
    
    //y.majorGridLineStyle=yMajorGridLineStyle;
    CPTXYAxis *y2 = [[CPTXYAxis alloc] init];
	y2.coordinate				   = CPTCoordinateY;
	y2.plotSpace				   = plotSpace2;
	y2.orthogonalCoordinateDecimal = CPTDecimalFromFloat([self getMaxRange]);
    //y2.majorIntervalLength=[interval decimalValue];
	y2.labelingPolicy			   = CPTAxisLabelingPolicyAutomatic;
	y2.separateLayers			   = NO;
	y2.tickDirection			   = CPTSignPositive;
	y2.axisLineStyle			   = axisStyle;
    y2.minorTicksPerInterval=0;
    y2.preferredNumberOfMajorTicks=5;
    
    
    CPTXYAxis *x2=[[CPTXYAxis alloc]init];
    if (hasZeroAxis) {
        CPTMutableLineStyle *zeroAxisStyle=[CPTMutableLineStyle lineStyle];
        zeroAxisStyle.lineWidth=1;
        zeroAxisStyle.lineColor=[CPTColor grayColor];
        zeroAxisStyle.dashPattern		  = [NSArray arrayWithObjects:[NSNumber numberWithInteger:5], [NSNumber numberWithInteger:8], nil];
        x2.coordinate=CPTCoordinateX;
        x2.plotSpace=plotSpace2;
        x2.orthogonalCoordinateDecimal=CPTDecimalFromFloat(0);
        x2.axisLineStyle=zeroAxisStyle;
        x2.majorIntervalLength=CPTDecimalFromFloat(0);
        x2.minorTicksPerInterval=0;
        x2.labelingPolicy=CPTAxisLabelingPolicyNone;
    }else {
        x2=nil;
    }
    
    
    
    NSNumberFormatter *formatter2 = [[NSNumberFormatter alloc] init];
    [formatter2 setMaximumFractionDigits:2];
    [formatter2 setMinimumFractionDigits:2];
    [formatter2 setMinimumIntegerDigits:1];
    NSString *yString2 = [formatter2 stringFromNumber:a2];
    float y2width = [yString2 sizeWithFont:[UIFont boldSystemFontOfSize:15]].width;
    //判断y2轴label是否需要倾斜
    /*if (y2width>30) {
        y2.labelRotation=-0.5;
    }*/
    if (y2axisArray.count>0) {        
        [graph addPlotSpace:plotSpace2];
        graph.axisSet.axes=[NSArray arrayWithObjects:x, y, y2,x2, nil];
    }else {
        graph.axisSet.axes = [NSArray arrayWithObjects:x, y,x2, nil];
    }
	
    graph.plotAreaFrame.paddingBottom=50;
    graph.plotAreaFrame.paddingLeft=ywidth+10;
    graph.plotAreaFrame.paddingTop=10;
    graph.plotAreaFrame.paddingRight=y2width+15;
    
    //y2轴标题
    CPTMutableTextStyle *titleTextStyle=[CPTMutableTextStyle textStyle];
    titleTextStyle.color=[CPTColor blackColor];
    titleTextStyle.fontSize=13;
    NSString *unit2=[self.units objectAtIndex:0];
    if (unit2) {
        y2.title=[NSString stringWithFormat:@"单位:(%@)",unit2];
    }else {
        y2.title=@"单位:(%)";
    }
    
	y2.titleTextStyle			   = titleTextStyle;
	y2.titleOffset				   = y2width;
    //y2.titleLocation=newLength2;
    //[self renderLegendInHostView:hostView];
}


-(void)renderPlots
{
    for (CPTPlot *plot in plots) {
        plot.delegate=self;
        plot.dataSource=self;
        [graph addPlot:plot];
        BAAnimationHelper *animation=[[BAAnimationHelper alloc]init];
        [animation plotScaleAnimation:plot];
    }
}

-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    [super renderInHostView:hostView];
    [self renderAxisInHostView:hostView];
    
    //[self renderPlots];
    [self renderLegendInHostView:hostView];
}
-(void)longPress:(id)params
{
    if (isLongPress) {
        
        CPTBarPlot *plot=[params objectForKey:@"plot"];
        
        NSString *indexString=[params valueForKey:@"index"];
        NSUInteger index= indexString.intValue;
        
        NSString *labelIndexString=[params valueForKey:@"labelIndex"];
        NSUInteger labelIndex=labelIndexString.intValue;
        
        CPTColor *labelBorderColor=[params valueForKey:@"labelBorderColor"];
        NSNumber *value = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
        NSNumber *location=[self numberForPlot:plot field:CPTBarPlotFieldBarLocation recordIndex:index];
        
        CPTXYPlotSpace *plotSpace=(CPTXYPlotSpace*) plot.plotSpace;
        //NSDecimalNumber *a=[NSDecimalNumber decimalNumberWithDecimal:plotSpace.yRange.length];
        
        //NSDecimalNumber *a2=[NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
        //NSDecimalNumber *b=[a decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.1"]];
        ;
        //NSDecimalNumber *b2=[a decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.6"]];
        
        //NSNumber *newValue=[a2 decimalNumberByAdding:b];
        //NSNumber *annotationY=[a2 decimalNumberByAdding:b2];
        
        NSDecimalNumber *c=[NSDecimalNumber decimalNumberWithDecimal:[location decimalValue]];
        NSNumber *newLocation;
        if ([plot isKindOfClass:[CPTBarPlot class]]) {
            NSDecimalNumber *offset=[NSDecimalNumber decimalNumberWithDecimal:plot.barOffset];
            newLocation=[c decimalNumberByAdding:offset];
        }else {
            newLocation=c;
        }
        
        
        
        /*if ( symbolTextAnnotation&&labelIndex!=index ) {
            [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
            symbolTextAnnotation = nil;
        }
        labelIndex=index;*/
        CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
        
        hitAnnotationTextStyle.color	= [BAColorHelper stringToCPTColor:@"324f85" alpha:@"1.0"];
        //hitAnnotationTextStyle.color	= [CPTColor blackColor];
        hitAnnotationTextStyle.fontSize = 12.0f;
        hitAnnotationTextStyle.fontName = @"Helvetica";
        
        //NSArray *anchorPoint = [NSArray arrayWithObjects:newLocation, newValue, nil];
        NSArray *anchorPoint;
        
        //NSLog(@"%@",NSStringFromCGPoint(z) );
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMinimumFractionDigits:2];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumIntegerDigits:1];
        NSString *yString = [formatter stringFromNumber:value];
        NSString *renderValue=[NSString stringWithFormat:@"值:%@",yString];
        NSString *renderMetric=[NSString stringWithFormat:@"系列:%@",plot.identifier];
        NSString *renderString=[NSString stringWithFormat:@"%@\n%@",renderMetric,renderValue];
        
        float textWidth = [renderMetric sizeWithFont:[UIFont boldSystemFontOfSize:12]].width+10;
        
        NSDecimal p[]={[newLocation decimalValue],[value decimalValue]};
        CGPoint originalPoint= [plotSpace plotAreaViewPointForPlotPoint:p];
        CGPoint newPoint;
        switch (labelIndex) {
            case 0:
                newPoint=CGPointMake(originalPoint.x+textWidth/2+1, originalPoint.y+20);
                break;
            case 1:
                newPoint=CGPointMake(originalPoint.x-textWidth/2-1, originalPoint.y+20);
                break;
            case 2:
                newPoint=CGPointMake(originalPoint.x+textWidth/2+1, originalPoint.y-20);
                break;
            case 3:
                newPoint=CGPointMake(originalPoint.x-textWidth/2-1, originalPoint.y-20);
                break;
            default:
                newPoint=CGPointMake(originalPoint.x-textWidth/2-1, originalPoint.y-20);
                break;
        }

        NSDecimal newP[2];
        [plotSpace plotPoint:newP forPlotAreaViewPoint:newPoint];
        anchorPoint=[NSArray arrayWithObjects:[NSDecimalNumber decimalNumberWithDecimal:newP[0]],[NSDecimalNumber decimalNumberWithDecimal:newP[1]], nil];
        CPTLayer *layer=[[CPTLayer alloc]initWithFrame:CGRectMake(0, 0, textWidth, 40)];
        //CGColorRef color=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]CGColor];
        layer.backgroundColor=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]CGColor];
        layer.borderWidth=1;
        layer.borderColor=[labelBorderColor cgColor];

        CALayer *hostLayer1=[CALayer layer];
        [hostLayer1 setBounds:layer.bounds];
        [hostLayer1 setPosition:layer.position];
        
        
        //[hostLayer1 setBackgroundColor:[[UIColor yellowColor]CGColor]];
        
        CPTTextLayer *textLayer=[[CPTTextLayer alloc] initWithText:renderString style:hitAnnotationTextStyle];
        [textLayer setPosition:hostLayer1.position];
        //[textLayer setBackgroundColor:[[UIColor redColor] CGColor] ];
        //[text setTransform:CATransform3DRotate(CATransform3DIdentity,M_PI, 0, 1, 0)];
        
        //[hostLayer1 setPosition:CGPointMake(80, 50)];
        [hostLayer1 addSublayer:textLayer];
        [layer addSublayer:hostLayer1];

        //NSArray *anchorPoint2 = [NSArray arrayWithObjects:newLocation,annotationY, nil];
        if (labelIndex<=3) {
            symbolTextAnnotation			  = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];
            symbolTextAnnotation.contentLayer = layer;
            symbolTextAnnotation.displacement = CGPointMake(0.f, 0.f);
        }
        

        [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    }
    
    
}

-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{
    isLongPress=YES;
    CPTColor *labelBorderColor=plot.dataLineStyle.lineColor;
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:plot,@"plot",[NSString stringWithFormat:@"%d", index],@"index",[NSString stringWithFormat:@"%d",graph.labelIndex],@"labelIndex",labelBorderColor,@"labelBorderColor", nil];
    [self performSelector:@selector(longPress:) withObject:params afterDelay:0.5];
    //[plot reloadData];
    selectedIndex=index;
    selectedPlot=plot;
}
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index
{
    isLongPress=YES;
    CPTColor *labelBorderColor=plot.lineStyle.lineColor;
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:plot,@"plot",[NSString stringWithFormat:@"%d", index],@"index",[NSString stringWithFormat:@"%d",graph.labelIndex],@"labelIndex",labelBorderColor,@"labelBorderColor", nil];
    [self performSelector:@selector(longPress:) withObject:params afterDelay:0.5];
    //[plot reloadData];
    selectedIndex=index;
    selectedPlot=plot;
    
}
-(CPTLineStyle *)barLineStyleForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index{
    if(index==selectedIndex&&barPlot==selectedPlot){
        
        CPTMutableLineStyle *barLineStyle=[CPTMutableLineStyle lineStyle];
        barLineStyle.lineColor=[CPTColor colorWithComponentRed:1 green:0 blue:0 alpha:0.4] ;
        barLineStyle.lineWidth=6;
        return barLineStyle;
    }
    return nil;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index{
    /*if(index==selectedIndex){
        NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
        CPTMutableTextStyle *textStyle=[CPTMutableTextStyle textStyle];
        textStyle.fontSize=14;
        textStyle.color=[CPTColor purpleColor];
        CPTTextLayer *dataLabel=[[CPTTextLayer alloc]initWithText:[NSString stringWithFormat:@"%@",[dataValues objectAtIndex:index]] style:textStyle];
        return dataLabel;
    }*/
    return nil;
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    if ( graph.plotAreaFrame.plotArea.annotations.count>0 ) {
        //[graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        [graph.plotAreaFrame.plotArea removeAllAnnotations];
        symbolTextAnnotation = nil;
    }
    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    return [dataValues count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{

    NSMutableArray *dataValues=[tempData objectForKey:(NSString*)plot.identifier];
    NSNumber *number=nil;
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            number=[NSNumber numberWithFloat:index+0.5];
            break;
            
        case CPTScatterPlotFieldY:
            number=[dataValues objectAtIndex:index];
            break;

    }
    return number;
}
/*
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate
{
    CPTPlotRange *range=[[CPTPlotRange alloc]initWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(10)];
    return range;
}
-(void)plotSpace:(CPTPlotSpace *)space didChangePlotRangeForCoordinate:(CPTCoordinate)coordinate
{
    
}
*/
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(id)event atPoint:(CGPoint)point
{
    /*if ( symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }*/

    isLongPress=NO;
    selectedIndex=-1;
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(id)event atPoint:(CGPoint)point
{
    //NSLog(@"haha");
    return YES;
}
@end