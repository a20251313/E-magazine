//
//  DTMetric.m
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DTMetric.h"
#import "Util.h"

@implementation DTMetric
@synthesize name, type, fillColor, dataValue, coord, isKey;

-(float)getAlpha
{
    NSString* num = [[self fillColor] objectForKey:ALPHA];
    return [num floatValue];
}

-(float)getAngle
{
    NSString* angle = [[self fillColor] objectForKey:ANGLE];
    return [angle floatValue];
}

-(BOOL)getIsGradient
{
    NSNumber* str = [[self fillColor] objectForKey:GRADIENT];
    return [str boolValue];
}

-(UIColor*)getColor1
{
    NSString* str = [[self fillColor] objectForKey:COLOR1];
    return [Util stringToUIColor:str alpha:@"1"];
}

-(UIColor*)getColor2
{
    NSString* str = [[self fillColor] objectForKey:COLOR2];
    return [Util stringToUIColor:str alpha:@"1"];
}

-(NSString*)getColor1Str
{
    return [[self fillColor] objectForKey:COLOR1];
}

-(NSString*)getColor2Str
{
    return [[self fillColor] objectForKey:COLOR2];
}

-(float)getBeginValue
{
    NSNumber* num = [[self fillColor] objectForKey:BEGINVALUE];
    return [num floatValue];
}

-(float)getEndValue
{
    NSNumber* num = [[self fillColor] objectForKey:ENDVALUE];
    return [num floatValue];
}

//coord
-(NSUInteger)getCoordsSum
{
    return [coord count];
}

-(float)getLongitudeAtIndex:(NSUInteger)index
{
    if (index >= [self getCoordsSum]) {
        return 0;
        //error
    }
    
    NSArray* curCoord = [coord objectAtIndex:index];
    NSNumber* num = [curCoord objectAtIndex:0];
    return [num floatValue];
}

-(float)getLatitudeAtIndex:(NSUInteger)index
{
    if (index >= [self getCoordsSum]) {
        return 0;
        //error
    }
    
    NSArray* curCoord = [coord objectAtIndex:index];
    NSNumber* num = [curCoord objectAtIndex:1];
    return [num floatValue];
}

-(float)getDataValueAtIndex:(NSUInteger)index
{
    if (index >= [[self dataValue] count]) {
        return 0;
    }
    
    NSNumber* num = [[self dataValue] objectAtIndex:index];
    return [num floatValue];
}

-(int)getType
{
    return [type intValue];
}

- (void)dealloc
{
    [name release];
    name = nil;
    
    [type release];
    type = nil;
    
    [fillColor release];
    fillColor = nil;
    
    [dataValue release];
    dataValue = nil;
    
    [coord release];
    coord = nil;
    
    [super dealloc];
}

@end
