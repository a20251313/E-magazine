//
//  BADocumentButton.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BADocumentButton.h"

@implementation BADocumentButton
@synthesize entity;
@synthesize metric;
@synthesize dataValue;
@synthesize arrow;
@synthesize selectedButtonIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
