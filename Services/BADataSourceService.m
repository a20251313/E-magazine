//
//  BADataSourceService.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BADataSourceService.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"

#import "AES128.h"
#import "BASE64.h"

@implementation BADataSourceService
{
    NSString *responseString;
}
-(NSMutableDictionary*)getDocumentListDictionary{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"documentList" ofType:@"json"]; 
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error = nil;
    NSMutableDictionary *jsonObject = (NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}

-(NSMutableDictionary*)getDocumentDictionaryTest:(NSString *)documentID
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    /*
     //解密key(Base64)
     NSData *keydata=[BASE64 base64Decode:@"a2V5"];
     NSString *key=[[NSString alloc]initWithData:keydata encoding:NSUTF8StringEncoding];
     
     //读取加密文件,并解密(AES128)
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document1" ofType:@"txt"];
     NSData *jsonDataEncoded=[[NSData alloc]initWithContentsOfFile:filePath];
     NSData *jsonData=[jsonDataEncoded AES128DecryptWithKey:key iv:@"iv"];
     */
    
    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
-(NSMutableDictionary*)getDocumentDictionaryMagazine:(NSString *)documentID fileName:(NSString*)strName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:strName ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];

    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        NSLog(@"getDocumentDictionaryMagazine error occurd:%@ documentID:%@",error,documentID);
    }
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
-(NSMutableDictionary*)getDocumentDictionary:(NSString *)documentID
{
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"]; 
    //NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    
    //解密key(Base64)
    NSData *keydata=[BASE64 base64Decode:@"a2V5"];
    NSString *key=[[NSString alloc]initWithData:keydata encoding:NSUTF8StringEncoding];
    
    //读取加密文件,并解密(AES128)
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document1" ofType:@"txt"];
    NSData *jsonDataEncoded=[[NSData alloc]initWithContentsOfFile:filePath];
    NSData *jsonData=[jsonDataEncoded AES128DecryptWithKey:key iv:@"iv"];
    
    
    NSError *error = nil;
    NSMutableArray *jsonObject = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *document=[[NSMutableDictionary alloc]init];
    for (NSMutableDictionary *sourceDocument in jsonObject) {
        if ([documentID isEqualToString:[sourceDocument objectForKey:@"documentID"]]) {
            document=sourceDocument;
            break;
        }
    }
    return document;
}
@end
