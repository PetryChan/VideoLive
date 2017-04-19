//
//  UIViewController+Extend.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/1.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "UIViewController+Extend.h"

@implementation UIViewController (Extend)


+ (UIViewController *)currntViewController
{
    UIViewController *currVC = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)rootVC;
            UIViewController *v = [nav.viewControllers lastObject];
            currVC = v;
            rootVC = v.presentedViewController;
            continue;
        }
        else if ([rootVC isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            currVC = tabVC;
            rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (rootVC != nil) ;
    return currVC;
}

@end
