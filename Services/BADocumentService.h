//
//  BADocumentService.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BADocument.h"

@interface BADocumentService : NSObject
-(BADocument*)getDocumentWithDictionary:(NSMutableDictionary *)dict;
@end
