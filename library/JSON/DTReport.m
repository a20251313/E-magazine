//
//  DTReport.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DTReport.h"

@implementation DTReport

@synthesize reportID, reportDesc, reportType, reportDatas;

- (void)dealloc
{
    [reportID release];
    reportID = nil;
    
    [reportType release];
    reportType = nil;
    
    [reportDesc release];
    reportDesc = nil;
    
    [reportDatas release];
    reportDatas = nil;
    
    [super dealloc];
}

@end
