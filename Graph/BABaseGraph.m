//
//  BAGraph.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BABaseGraph.h"
#import "BAColorHelper.h"
@implementation BABaseGraph
{
    BOOL isLarge;
    CGRect originalFrame;
}
@synthesize sourceData;
@synthesize plots;
@synthesize tempData;
@synthesize tempLabel;
@synthesize sourceLabel;
@synthesize graph;
@synthesize defaultColors;
@synthesize myHostView;
@synthesize y2axisArray;
@synthesize xOrthogonalCoordinate;
@synthesize city;
@synthesize units;
- (id)init
{
    self = [super init];
    if (self) {
        defaultColors=[NSMutableArray arrayWithObjects:@"F8F281",@"F9D051",@"FEA04E",@"F4505C",@"AA326D",@"7F3E88",@"471C64",@"4B9DBC",@"62887C",@"378950",@"8AB85C", nil];
    }
    return self;
}
-(NSDecimal)getMaxDataValue
{
    NSDecimalNumber *maxDataValue=[NSDecimalNumber decimalNumberWithString:@"0"];
    for (NSString *key in sourceData) {
        NSMutableArray *dataValues=[sourceData objectForKey:key];
        for (NSDecimalNumber *dataValue in dataValues) {
            if(dataValue.doubleValue>maxDataValue.doubleValue){
                maxDataValue=dataValue;
            }
        }
    }
    return [maxDataValue decimalValue];
}
-(NSDecimal)getMinDataValue
{
    NSDecimalNumber *minDataValue=[NSDecimalNumber decimalNumberWithString:@"99999999"];
    for (NSString *key in sourceData) {
        NSMutableArray *dataValues=[sourceData objectForKey:key];
        for (NSDecimalNumber *dataValue in dataValues) {
            if(dataValue.doubleValue<minDataValue.doubleValue){
                minDataValue=dataValue;
            }
        }
    }
    return [minDataValue decimalValue];
}
-(NSUInteger)getMaxRange
{
    NSUInteger count=0;
    for (NSString *key in sourceData) {
        NSMutableArray *dataValues=[sourceData objectForKey:key];
        if([dataValues count]>count){
            count=[dataValues count];
        }
    }
    return count;
}
-(void)renderInHostView:(CPTGraphHostingView*)hostView{
    myHostView=hostView;
    mainView=myHostView.superview;
    [self regGuesture];
}
-(void)regGuesture
{
    if (myHostView.frame.size.width<mainView.frame.size.width/2||myHostView.frame.size.height<mainView.frame.size.height/2) {
        UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwiceAction:)];
        tapTwice.numberOfTapsRequired = 2;
        tapTwice.numberOfTouchesRequired = 1;
        [myHostView addGestureRecognizer:tapTwice];
    }
}
-(void)tapTwiceAction:(UITapGestureRecognizer*)sender
{
    if (isLarge) {
        [UIView animateWithDuration:1 animations:^
         {
             sender.view.alpha=0;   
             sender.view.superview.alpha=0;
             
         }completion:^(BOOL finished)
         {
             sender.view.frame=originalFrame;
             sender.view.backgroundColor=[UIColor clearColor];
             sender.view.layer.cornerRadius=0;
             sender.view.layer.shadowOpacity=0;
             [sender.view.superview removeFromSuperview];
             [mainView addSubview:sender.view];
             [UIView animateWithDuration:1 animations:^
              {
                  sender.view.alpha=1;
              }];
         } ];
        isLarge=NO;
    }else {
        originalFrame=sender.view.frame;
        [UIView animateWithDuration:0.5 animations:^
         {
             sender.view.alpha=0;   
         }completion:^(BOOL finished)
         {
             UIView *view=[[UIView alloc]init];
             
             
             view.backgroundColor=[UIColor colorWithWhite:1 alpha:0.7];
             view.alpha=0;
             sender.view.frame=view.bounds;
             sender.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
             [view addSubview:sender.view];
             [mainView addSubview:view];

             view.frame=mainView.frame;
             CGRect rect=view.bounds; 
             rect.size.width=800;
             rect.size.height=500; 
             [sender.view setFrame:rect];
             sender.view.center = mainView.center;
             sender.view.backgroundColor=[BAColorHelper stringToUIColor:@"f5f5f5" alpha:@"1"];
             sender.view.layer.cornerRadius=5;
             //sender.view.layer.masksToBounds=YES;
             sender.view.layer.shadowOpacity=0.2;
             sender.view.layer.shadowOffset=CGSizeMake(4, 4);
             [UIView animateWithDuration:1 animations:^
              {
                  view.alpha=1;
                  sender.view.alpha=1;
              }];
         } ];
        isLarge=YES;
    }
    
}
@end
