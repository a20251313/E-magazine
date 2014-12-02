//
//  BAEntity.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAEntity : NSObject
@property (nonatomic,strong) NSString* entityName;
@property (nonatomic,strong) NSMutableArray *entityValues;
@end
