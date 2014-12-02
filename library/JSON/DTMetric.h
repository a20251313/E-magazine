//
//  DTMetric.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTMetric : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSDictionary* fillColor;
@property (nonatomic, retain) NSArray* dataValue;
@property (nonatomic) BOOL isKey;
@property (nonatomic, retain) NSArray* coord;

-(float)getAlpha;
-(float)getAngle;
-(BOOL)getIsGradient;
-(UIColor*)getColor1;
-(UIColor*)getColor2;
-(NSString*)getColor1Str;
-(NSString*)getColor2Str;
-(float)getBeginValue;
-(float)getEndValue;
-(int)getType;

//coord
//how many coords in the array
-(NSUInteger)getCoordsSum;
-(float)getLongitudeAtIndex:(NSUInteger)index;
-(float)getLatitudeAtIndex:(NSUInteger)index;

-(float)getDataValueAtIndex:(NSUInteger)index;


@end
