//
//  BASE64.h
//  IRnovationBI
//
//  Created by mac on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BASE64 : NSData
+ (NSData*) base64Decode:(NSString *)string;
+ (NSString*) base64Encode:(NSData *)data;
@end
