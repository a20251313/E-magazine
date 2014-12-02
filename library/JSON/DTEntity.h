//
//  DTEntity.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTEntity : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSArray* data;

-(NSString*)getStringAtIndex:(NSUInteger)index;

@end
