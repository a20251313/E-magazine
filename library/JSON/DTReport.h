//
//  DTReport.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTReport : NSObject

@property (nonatomic, retain) NSString* reportID;
@property (nonatomic, retain) NSString* reportType;
@property (nonatomic, retain) NSString* reportDesc;
@property (nonatomic, retain) NSArray* reportDatas;

@end
