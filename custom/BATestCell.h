//
//  BATestCell.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BATestCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *entity;
@property (strong, nonatomic) IBOutlet UILabel *value;
@property (strong, nonatomic) IBOutlet UIView *bar;
@property (strong, nonatomic) IBOutlet UIView *flag;

@end
