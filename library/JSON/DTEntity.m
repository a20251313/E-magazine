//
//  DTEntity.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DTEntity.h"

@implementation DTEntity
@synthesize name, data;

-(NSString*)getStringAtIndex:(NSUInteger)index
{
    if (index >= [[self data] count]) {
        return @"";
    }
    
    return [data objectAtIndex:index];
    
}

- (void)dealloc
{
    [name release];
    name = nil;
    
    [data release];
    data = nil;
    
    [super dealloc];
}

@end
