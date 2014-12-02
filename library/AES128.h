//
//  Encryption.h
//  SecurityTest
//
//  Created by mac on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSData (AES)
//- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv;

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;//加密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;//解密
@end