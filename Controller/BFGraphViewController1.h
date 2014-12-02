//
//  BATestViewController.h
//  IRnovationBI
//
//  Created by 彦 蔡 on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFGraphViewController1 : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@property (strong, nonatomic) IBOutlet UIView *host;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UILabel *curValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *compareValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *diversityValueLabel;
@property (strong,nonatomic) IBOutlet UILabel *diversityRatioLabel;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UIImageView *bar;
@property (strong, nonatomic) IBOutlet UILabel *curItemLabel;
@property (strong, nonatomic) IBOutlet UILabel *compareItemLabel;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *rectNameLabel;
@property (strong, nonatomic) UIButton *button;
@end
