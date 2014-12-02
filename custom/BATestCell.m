//
//  BATestCell.m
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BATestCell.h"

@implementation BATestCell
@synthesize bgView;
@synthesize name;
@synthesize entity;
@synthesize value;
@synthesize bar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
