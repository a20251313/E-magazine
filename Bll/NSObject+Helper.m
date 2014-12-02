//
//  NSObject+Helper.m
//  TestDemo
//
//  Created by YDJ on 12-11-22.
//  Copyright (c) 2012年 jingyoutimes. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

@implementation NSObject (Helper)
//对象转字典
- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t  property = properties[i];
        const char* propertyName_c = property_getName(property);
        
        const char *attDes= property_getAttributes(property);
        
        NSString * classDes=[NSString stringWithUTF8String:attDes];
        
        NSArray * tempArray=[classDes componentsSeparatedByString:@"\""];
        
        NSString * nameForClass=nil;
        
        @try {
            nameForClass=[tempArray objectAtIndex:1];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception:%@",exception.description);
            continue;
        }
        @finally {
            
        }
        
        Class myClass=NSClassFromString(nameForClass);
        
        if([myClass isSubclassOfClass:[UIImage class]]||[myClass isSubclassOfClass:[UIView class]]||[myClass isSubclassOfClass:[UIViewController class]]||[myClass isSubclassOfClass:[UIControl class]])
        {
            continue;
        }
        
        NSString * propertyName=[NSString stringWithUTF8String:propertyName_c];
        id propertyValue = [self valueForKey:propertyName];
        
        if (propertyValue) {
            
            if ([myClass isSubclassOfClass:[NSString class]]||[myClass isSubclassOfClass:[NSArray class]]||[myClass isSubclassOfClass:[NSDictionary class]]||[myClass isSubclassOfClass:[NSNull class]]||[myClass isSubclassOfClass:[NSNumber class]]) {
                [props setObject:propertyValue forKey:propertyName];
            }
            else{
                
                NSDictionary * proDictionary= [propertyValue properties_aps];
                if (proDictionary) {
                    [props setObject:proDictionary forKey:propertyName];
                }
                else{
                    [props setObject:[NSNull null] forKey:propertyName];
                }
            }
        }
        else{
            [props setObject:[NSNull null] forKey:propertyName];
        }
        
    }
    free(properties);
    return props;
}

@end
