//
//  BADocumentService.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BADocumentService.h"
#import "BAReport.h"
#import "BAReportData.h"
#import "BAMetric.h"
#import "BATitle.h"
#import "BATextStyle.h"
#import "BALegend.h"
#import "BALineStyle.h"
#import "BAColor.h"
#import "BAGraph.h"

@implementation BADocumentService
-(BADocument*)getDocumentWithDictionary:(NSMutableDictionary *)dict
{
    BADocument *document=[[BADocument alloc]init];
    document.documentID=[dict objectForKey:@"documentID"];
    document.documentName=[dict objectForKey:@"documentName"];
    document.documentDesc=[dict objectForKey:@"documentDesc"];
    
    //report
    NSMutableArray *sourceReports=[dict objectForKey:@"reports"];
    NSMutableArray *reports=[[NSMutableArray alloc]init];   
    for (NSMutableDictionary *sourceReport in sourceReports) {
        BAReport *report=[[BAReport alloc] init];
        report.reportID=[sourceReport objectForKey:@"reportID"];
        report.reportName=[sourceReport objectForKey:@"reportName"];
        report.reportDesc=[sourceReport objectForKey:@"reportDesc"];
        report.reportType=[sourceReport objectForKey:@"reportType"];
        
        //reportData
        NSMutableDictionary *sourceData=[sourceReport objectForKey:@"reportData"];
        BAReportData *reportData=[[BAReportData alloc]init];
        
        NSMutableArray *sourceMetrics=[sourceData objectForKey:@"metric"];
        NSMutableArray *metrics=[[NSMutableArray alloc]init];
        for (NSMutableDictionary *sourceMetric in sourceMetrics) {
            BAMetric *metric=[[BAMetric alloc]init];
            metric.metricName=[sourceMetric objectForKey:@"metricName"];
            metric.dataValues=[sourceMetric objectForKey:@"dataValue"];
            NSNumber *plotType=[sourceMetric objectForKey:@"plotType"];
            metric.plotType=plotType.intValue;
            NSNumber *hasY2Axis=[sourceMetric objectForKey:@"y2Axis"];
            metric.hasY2Axis=hasY2Axis.boolValue;
            NSMutableDictionary *sourceFillColor=[sourceMetric objectForKey:@"fillColor"];
            BAColor *fillColor=[[BAColor alloc]init];
            NSString *legendFillColorAlpha=[sourceFillColor objectForKey:@"alpha"];
            fillColor.alpha=legendFillColorAlpha;
            NSNumber *legendFillColorAngle=[sourceFillColor objectForKey:@"angle"];
            fillColor.angle=legendFillColorAngle.floatValue;
            NSNumber *legendFillColorIsGradient=[sourceFillColor objectForKey:@"isGradient"];
            fillColor.isGradient=legendFillColorIsGradient.boolValue;
            fillColor.color1=[sourceFillColor objectForKey:@"color1"];
            fillColor.color2=[sourceFillColor objectForKey:@"color2"];
            metric.fillColor=fillColor;

            [metrics addObject:metric];
        }
        
        NSMutableDictionary *sourceEntity=[sourceData objectForKey:@"entity"];
        BAEntity *entity=[[BAEntity alloc]init];
        entity.entityName=[sourceEntity objectForKey:@"entityName"];
        entity.entityValues=[sourceEntity objectForKey:@"entityData"];
        
        reportData.metrics=metrics;
        reportData.entity=entity; 
        
        report.reportData=reportData;
        
        //title
        BATitle *title=[[BATitle alloc]init];
        NSMutableDictionary *sourceTitle=[sourceReport objectForKey:@"title"];
        title.titleText=[sourceTitle objectForKey:@"titleText"];
        
        NSMutableDictionary *sourceTitleTextStyle=[sourceTitle objectForKey:@"textStyle"];
        BATextStyle *titleTextStyle=[[BATextStyle alloc]init];
        titleTextStyle.color=[sourceTitleTextStyle objectForKey:@"color"];
        titleTextStyle.fontName=[sourceTitleTextStyle objectForKey:@"fontName"];
        NSNumber *fontSize=(NSNumber*)[sourceTitleTextStyle objectForKey:@"fontSize"];
        titleTextStyle.fontSize=fontSize.floatValue;
        NSNumber *rotation=(NSNumber*)[sourceTitleTextStyle objectForKey:@"rotation"];
        titleTextStyle.rotation=rotation.floatValue;
        
        title.textStyle=titleTextStyle;
        
        report.title=title;
        
        //legend
        BALegend *legend=[[BALegend alloc]init];
        NSMutableDictionary *sourceLegend=[sourceReport objectForKey:@"legend"];
        NSNumber *legendAnchor=(NSNumber*)[sourceLegend objectForKey:@"legendAnchor"];
        legend.legendAnchor=legendAnchor.intValue;
        
        NSMutableDictionary *sourceLegendBorderStyle=[sourceLegend objectForKey:@"borderStyle"];
        BALineStyle *legendBorderStyle=[[BALineStyle alloc]init];
        legendBorderStyle.lineColor=[sourceLegendBorderStyle objectForKey:@"lineColor"];
        NSNumber *legendLineWidth=(NSNumber*)[sourceLegendBorderStyle objectForKey:@"lineWidth"];
        legendBorderStyle.lineWidth=legendLineWidth.floatValue;
        legend.borderStyle=legendBorderStyle;
        
        NSMutableDictionary *sourceTextStyle=[sourceLegend objectForKey:@"textStyle"];
        BATextStyle *textStyle=[[BATextStyle alloc]init];
        textStyle.color=[sourceTextStyle objectForKey:@"color"];
        textStyle.fontName=[sourceTextStyle objectForKey:@"fontName"];
        fontSize=(NSNumber*)[sourceTextStyle objectForKey:@"fontSize"];
        textStyle.fontSize=fontSize.floatValue;
        rotation=(NSNumber*)[sourceTextStyle objectForKey:@"rotation"];
        textStyle.rotation=rotation.floatValue;
        legend.textStyle=textStyle;
        
        NSMutableDictionary *sourceLegendFillColor=[sourceLegend objectForKey:@"fillColor"];
        BAColor *legendFillColor=[[BAColor alloc]init];
        legendFillColor.alpha=[sourceLegendFillColor objectForKey:@"alpha"];
        NSNumber *legendFillColorAngle=[sourceLegendFillColor objectForKey:@"angle"];
        legendFillColor.angle=legendFillColorAngle.floatValue;
        NSNumber *legendFillColorIsGradient=[sourceLegendFillColor objectForKey:@"isGradient"];
        legendFillColor.isGradient=legendFillColorIsGradient.boolValue;
        legendFillColor.color1=[sourceLegendFillColor objectForKey:@"color1"];
        legendFillColor.color2=[sourceLegendFillColor objectForKey:@"color2"];
        legend.fillColor=legendFillColor;
        
        report.legend=legend;
        
        //graph
        BAGraph *graph=[[BAGraph alloc]init];
        NSMutableDictionary *sourceGraph=[sourceReport objectForKey:@"graph"];
        
        NSMutableDictionary *sourceAxisLineStyle=[sourceGraph objectForKey:@"axisLineStyle"];
        BALineStyle *axisLineStyle=[[BALineStyle alloc]init];
        axisLineStyle.lineColor=[sourceAxisLineStyle objectForKey:@"lineColor"];
        NSNumber *axisLineWidth=(NSNumber*)[sourceAxisLineStyle objectForKey:@"lineWidth"];
        axisLineStyle.lineWidth=axisLineWidth.floatValue;
        graph.axisLineStyle=axisLineStyle;
        
        NSMutableDictionary *sourceMajorGridLineStyle=[sourceGraph objectForKey:@"majorGridLineStyle"];
        BALineStyle *majorGridLineStyle=[[BALineStyle alloc]init];
        majorGridLineStyle.lineColor=[sourceMajorGridLineStyle objectForKey:@"lineColor"];
        NSNumber *majorGridWidth=(NSNumber*)[sourceMajorGridLineStyle objectForKey:@"lineWidth"];
        majorGridLineStyle.lineWidth=majorGridWidth.floatValue;
        graph.majorGridLineStyle=majorGridLineStyle;
        
        NSMutableDictionary *sourceXLabelStyle=[sourceGraph objectForKey:@"xLabelStyle"];
        BATextStyle *xlabelStyle=[[BATextStyle alloc]init];
        xlabelStyle.color=[sourceXLabelStyle objectForKey:@"color"];
        xlabelStyle.fontName=[sourceXLabelStyle objectForKey:@"fontName"];
        NSNumber *xLabelStyleFontSize=(NSNumber*)[sourceXLabelStyle objectForKey:@"fontSize"];
        xlabelStyle.fontSize=xLabelStyleFontSize.floatValue;
        NSNumber *xLabelStyleRotation=(NSNumber*)[sourceXLabelStyle objectForKey:@"rotation"];
        xlabelStyle.rotation=xLabelStyleRotation.floatValue;
        graph.xLabelStyle=xlabelStyle;
        
        NSMutableDictionary *sourceYLabelStyle=[sourceGraph objectForKey:@"yLabelStyle"];
        BATextStyle *ylabelStyle=[[BATextStyle alloc]init];
        ylabelStyle.color=[sourceYLabelStyle objectForKey:@"color"];
        ylabelStyle.fontName=[sourceYLabelStyle objectForKey:@"fontName"];
        NSNumber *yLabelStyleFontSize=(NSNumber*)[sourceYLabelStyle objectForKey:@"fontSize"];
        ylabelStyle.fontSize=yLabelStyleFontSize.floatValue;
        NSNumber *yLabelStyleRotation=(NSNumber*)[sourceYLabelStyle objectForKey:@"rotation"];
        ylabelStyle.rotation=yLabelStyleRotation.floatValue;
        graph.ylabelStyle=ylabelStyle;
        
        NSMutableDictionary *sourceGraphFillColor=[sourceGraph objectForKey:@"fillColor"];
        BAColor *graphFillColor=[[BAColor alloc]init];
        graphFillColor.alpha=[sourceGraphFillColor objectForKey:@"alpha"];
        NSNumber *graphFillColorAngle=[sourceGraphFillColor objectForKey:@"angle"];
        graphFillColor.angle=graphFillColorAngle.floatValue;
        NSNumber *graphFillColorIsGradient=[sourceGraphFillColor objectForKey:@"isGradient"];
        graphFillColor.isGradient=graphFillColorIsGradient.boolValue;
        graphFillColor.color1=[sourceGraphFillColor objectForKey:@"color1"];
        graphFillColor.color2=[sourceGraphFillColor objectForKey:@"color2"];
        graph.fillColor=graphFillColor;
        
        report.graph=graph;
        [reports addObject:report];

    }
    document.reports=reports;

    return document;
}
@end
