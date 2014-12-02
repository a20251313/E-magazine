//
//  BAReport.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAReportData.h"
#import "BATitle.h"
#import "BALegend.h"
#import "BAGraph.h"
@interface BAReport : NSObject
@property (nonatomic,strong) NSString* reportID;
@property (nonatomic,strong) NSString* reportName;
@property (nonatomic,strong) NSString* reportDesc;
@property (nonatomic,strong) NSString* reportType;
@property (nonatomic,strong) BAReportData *reportData;
@property (nonatomic,strong) BATitle *title;
@property (nonatomic,strong) BALegend *legend;
@property (nonatomic,strong) BAGraph *graph;
@end
