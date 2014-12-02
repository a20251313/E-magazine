//
//  BABaseGraph.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAPanel.h"
#import "BACPTGraph.h"
@interface BABaseGraph :BAPanel {
    NSMutableArray *plots;
    NSMutableDictionary *tempData;
    NSMutableDictionary *sourceData;
    NSMutableArray *tempLabel;
    NSArray *sourceLabel;
    BACPTGraph *graph;
    NSMutableArray *defaultColors;
    CPTGraphHostingView *myHostView;
    UIView *mainView;
    NSMutableArray *y2axisArray;
    NSMutableArray *units;
@public
    NSUInteger selectedIndex;
    NSUInteger selectedIndex2;
}
@property (nonatomic,strong) NSMutableArray *plots;
@property (nonatomic,strong) NSMutableDictionary *tempData;
@property (nonatomic,strong) NSMutableDictionary *sourceData;
@property (nonatomic,strong) NSMutableArray *tempLabel;
@property (nonatomic,strong) NSArray *sourceLabel;
@property (nonatomic,strong) BACPTGraph *graph;
@property (nonatomic,strong) NSMutableArray *defaultColors;
@property (nonatomic,strong) CPTGraphHostingView *myHostView;
@property (nonatomic,strong) NSMutableArray *y2axisArray;
@property float xOrthogonalCoordinate;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSMutableArray *units;
-(void)renderInHostView:(CPTGraphHostingView*)hostView;
-(NSDecimal)getMaxDataValue;
-(NSUInteger)getMaxRange;
-(NSDecimal)getMinDataValue;
@end
