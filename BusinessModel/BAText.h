//
//  BAText.h
//  E-magazine
//
//  Created by summer.zhu on 4/13/13.
//  Copyright (c) 2013 IRnovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAPageData.h"

@interface BAText : BAPageData

@property(nonatomic, retain) NSString *text;//
@property(nonatomic) NSInteger iTitleFontSize;
@property(nonatomic, retain) NSString *strTitlFontName;
@property(nonatomic) NSInteger iTitleLength;
@property(nonatomic) NSInteger iContentFontSize;
@property(nonatomic, retain) NSString *strContentFontName;
@property(nonatomic, retain) NSArray *arrAttributeColors;
@property(nonatomic, retain) NSArray *arrAttributeColorsPor;
@property(nonatomic, retain) NSArray *arrAttributeRanges;
@property(nonatomic, retain) NSArray *arrAttributeRangesPor;
@property(nonatomic, retain) NSArray *arrKeywords;
@property(nonatomic, retain) NSArray *arrRects;
@property(nonatomic, retain) NSArray *arrRectsPor;
@property(nonatomic, retain) NSArray *arrBGRect;
@property(nonatomic, retain) NSArray *arrBGRectPor;
@property(nonatomic, retain) NSArray *arrBGNames;
@property(nonatomic, retain) NSArray *arrBGNamesPor;
@property(nonatomic, retain) NSArray *arrPicRect;
@property(nonatomic, retain) NSArray *arrPicRectPor;
@property(nonatomic, retain) NSArray *arrPicNames;
@property(nonatomic, retain) NSArray *arrPicNamesPor;

@end
