//
//  BFMainViewController.m
//  E-magazine
//
//  Created by jingfuran on 14/12/3.
//  Copyright (c) 2014年 IRnovation. All rights reserved.
//

#import "BFMainViewController.h"
#import "BFGraphViewController1.h"
@interface BFMainViewController ()

@end

@implementation BFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)firstAction:(id)sender
{
    BFGraphViewController1 *controller = [[BFGraphViewController1 alloc] initWithType:1];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)secondAction:(id)sender
{
    BFGraphViewController1 *controller = [[BFGraphViewController1 alloc] initWithType:2];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)thirdAction:(id)sender
{
    
      BFGraphViewController1 *controller = [[BFGraphViewController1 alloc] initWithType:3];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
