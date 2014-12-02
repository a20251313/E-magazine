//
//  BFGraph1Model.m
//  E-magazine
//
//  Created by Yann on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFGraph1Model.h"

@implementation BFGraph1Model
@synthesize reports;
@synthesize name;
-(id)initWithReports:(NSMutableArray*)theReports
{
    self=[self init];
    if (self) {
        reports=theReports;
    }
    return self;
}
@end
