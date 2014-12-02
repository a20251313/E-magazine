//
//  DTDocument.h
//  yalitu
//
//  Created by aplee on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTDocument : NSObject

@property (nonatomic, assign) NSString* documentID;
@property (nonatomic, assign) NSString* documentName;
@property (nonatomic, assign) NSString* documentDesc;
@property (nonatomic, retain) NSArray* reports;

@end
