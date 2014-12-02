//
//  BAReportData.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAEntity.h"
@interface BAReportData : NSObject
@property (nonatomic,strong) NSMutableArray *metrics;
@property (nonatomic,strong) BAEntity *entity;
@end
