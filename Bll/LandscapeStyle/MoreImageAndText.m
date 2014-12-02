//
//  MoreImageAndText.m
//  E-magazine
//
//  Created by zbq on 13-12-20.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "MoreImageAndText.h"

@implementation MoreImageAndText

+ (NSMutableArray *)setTextRect{
    NSString *strRect_2 = NSStringFromCGRect(CGRectMake(51, 505, 571, 30));
    NSString *strRect1_2 = NSStringFromCGRect(CGRectMake(51, 547, 278, 140));
    NSString *strRect2_2 = NSStringFromCGRect(CGRectMake(344, 547, 278,140));
    NSString *strRect3_2 = NSStringFromCGRect(CGRectMake(643, 547, 318,140));
    NSMutableArray *arrTextRect = [[NSMutableArray alloc] initWithObjects:strRect_2,strRect1_2,strRect2_2,strRect3_2,nil];
    return arrTextRect;
}

+ (NSMutableArray *)setImageRect{
    NSString *strPicRect_1 = NSStringFromCGRect(CGRectMake(56, 85, 926, 175));
    NSString *strPicRect_2 = NSStringFromCGRect(CGRectMake(56, 285, 926, 375));
    NSMutableArray *arrImageRect = [[NSMutableArray alloc] initWithObjects:strPicRect_1, strPicRect_2, nil];
    return arrImageRect;
}

@end
