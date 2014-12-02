//
//  BADataSourceService.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADataSourceService : NSObject
-(NSMutableDictionary*)getDocumentListDictionary;
-(NSMutableDictionary*)getDocumentDictionary:(NSString *)documentID;
//-(NSMutableDictionary*)getDocumentListDictionaryFromService;
-(NSMutableDictionary*)getDocumentDictionaryTest:(NSString *)documentID;
-(NSMutableDictionary*)getDocumentDictionaryMagazine:(NSString *)documentID;
@end
