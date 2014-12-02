//
//  BADocument.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADocument : NSObject
@property (strong,nonatomic) NSString *documentID;
@property (strong,nonatomic) NSString *documentName;
@property (strong,nonatomic) NSString *documentDesc;
@property (strong,nonatomic) NSString *smallImageLocation;
@property (strong,nonatomic) NSMutableArray *reports;
@property (strong,nonatomic) UIImage *smallImage;
@end
