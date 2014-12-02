//
//  BFGraph1Model.h
//  E-magazine
//
//  Created by Yann on 13-1-30.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFGraph1Model : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray *reports;
-(id)initWithReports:(NSMutableArray*)theReports;
@end
