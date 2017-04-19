//
//  AppDelegate.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/3/29.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "AppDelegate.h"
#import <WMPageController/WMPageController.h>
#import "PECommendController.h"
#import "PEMainBaseController.h"
#import "PEMainNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    WMPageController *page = [self addPageController];
    PEMainNavigationController *mainNav = [[PEMainNavigationController alloc] initWithRootViewController:page];
    self.window.rootViewController = mainNav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (WMPageController *)addPageController
{
    NSMutableArray *salesVCs = [[NSMutableArray alloc] init];
    NSMutableArray *salesVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [PECommendController class];
                title = @"推荐";
                break;
            case 1:
                vcClass = [PECommendController class];
                title = @"关注";
                break;
        }
        [salesVCs addObject:vcClass];
        [salesVCTitles addObject:title];
    }
    PEMainBaseController *salesVC = [[PEMainBaseController alloc] initWithViewControllerClasses:salesVCs andTheirTitles:salesVCTitles];
    //在导航栏上展示
    salesVC.titleSizeSelected = 18;
    salesVC.titleSizeNormal = 15;
    salesVC.showOnNavigationBar = YES;
    salesVC.pageAnimatable = YES;
    salesVC.menuViewStyle = WMMenuViewStyleFloodHollow;
    salesVC.titleColorSelected = [UIColor colorWithRed:28/255.0 green:206/255.0 blue:109/255.0 alpha:1];
    salesVC.titleColorNormal = [UIColor grayColor];
    salesVC.progressColor = [UIColor blackColor];
    salesVC.menuBGColor = [UIColor clearColor];
    salesVC.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
 
    return salesVC;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
