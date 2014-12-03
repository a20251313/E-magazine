//
//  BFAppDelegate.m
//  E-magazine
//
//  Created by Yann on 13-1-25.
//  Copyright (c) 2013年 IRnovation. All rights reserved.
//

#import "BFAppDelegate.h"
#import "BFGraphViewController1.h"
#import "BFMainViewController.h"
@implementation BFAppDelegate
{
}

+ (BFAppDelegate *) instance {
	return (BFAppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
  
   
    BFMainViewController *vc=[[BFMainViewController alloc]init];
 
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
//    [self.window addSubview:vc.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    return YES;
}


/*
- (ViewControllerAndPage *)getChapterAndPage:(NSInteger)page chapters:(NSArray *)chapters{
    ViewControllerAndPage *vcAndPage = [[ViewControllerAndPage alloc] init];
    int pageInChapter;
    if (chapters.count == 1) {
        vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"0"];
        vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", page];
    }else if(chapters.count > 1){
        for (int i=0; i<chapters.count-1; i++) {
            int chapter = [[chapters objectAtIndex:i] intValue];
            int chapterNext = [[chapters objectAtIndex:i+1] intValue];
            if (page>=chapter && page<chapterNext) {
                vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", i];
                pageInChapter = page - chapter;
                vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", pageInChapter];
            }
        }
        if (page >= [[chapters lastObject] intValue]) {
            vcAndPage.viewControllerIndex = [NSString stringWithFormat:@"%d", chapters.count-1];
            pageInChapter = page - [[chapters lastObject] intValue];
            vcAndPage.pageIndex = [NSString stringWithFormat:@"%d", pageInChapter];
        }
    }else{
        return nil;
    }
    return vcAndPage;
}

- (NSInteger)getPage:(ViewControllerAndPage *)vcAndPage chapters:(NSArray *)chapters{
    NSInteger iTotalPage = 0;
    NSString *strChapter = vcAndPage.viewControllerIndex;
    int iChapter = [strChapter intValue];
    iTotalPage += [[chapters objectAtIndex:iChapter] intValue];
    
    iTotalPage += [vcAndPage.pageIndex intValue];
    return iTotalPage;
}

- (void)startTimer{
    NSTimer *timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
}
- (void)startTimer_1{
    NSTimer *timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer_1:) userInfo:nil repeats:NO];
}

- (void)handleTimer:(NSTimer *)timer{
    NSArray *arrMsg = [[NSArray alloc] initWithObjects:@"NewTest1", @"NewTest2", @"NewTest3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HaveMsg" object:arrMsg];
}
- (void)handleTimer_1:(NSTimer *)timer{
    NSArray *arrMsg = [[NSArray alloc] initWithObjects:@"NewTest1", @"NewTest2", @"NewTest3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HaveMsg_1" object:arrMsg];
}*/

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //rm=[[IRRecordManager alloc]initWithAppID:@"514d558e56240b975f014a9b"];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//- (NSUInteger) supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAll;
//}
//
//- (BOOL) shouldAutorotate {
//    return YES;
//}

@end
