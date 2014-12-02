//
//  DTReportData.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DTReportData.h"

@implementation DTReportData
@synthesize metrics, entities;

- (void)dealloc
{
    [metrics release];
    metrics = nil;
    
    [entities release];
    entities = nil;
    
    [super dealloc];
}

@end
