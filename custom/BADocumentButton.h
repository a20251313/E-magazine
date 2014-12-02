//
//  BADocumentButton.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADocumentButton : UIButton
@property (strong, nonatomic) IBOutlet UILabel *entity;
@property (strong, nonatomic) IBOutlet UILabel *metric;
@property (strong, nonatomic) IBOutlet UILabel *dataValue;
@property (strong, nonatomic) IBOutlet UIImageView *arrow;
@property (strong, nonatomic) IBOutlet UILabel *ratioLebel;

@property NSUInteger selectedButtonIndex;
@end
