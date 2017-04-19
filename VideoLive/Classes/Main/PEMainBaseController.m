//
//  PEMainBaseController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/11.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEMainBaseController.h"
#import "PEFansController.h"
#import "PEProfileViewController.h"


@interface PEMainBaseController ()

@end

@implementation PEMainBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNavigationBarView];
}

- (void)buildNavigationBarView
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"personal"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    
}

- (void)rightBarClick
{
    WMPageController *page = [self addPageController];
    [self showViewController:page sender:nil];
}
- (void)leftBarClick
{
    PEProfileViewController *personal = [[PEProfileViewController alloc] init];
    [self showViewController:personal sender:nil];
}

- (WMPageController *)addPageController
{
    NSMutableArray *attentionVCs = [[NSMutableArray alloc] init];
    NSMutableArray *attentionVCTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i<2; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [PEFansController class];
                title = @"已关注";
                break;
            case 1:
                vcClass = [PEFansController class];
                title = @"未关注";
                break;
            default:
                break;
        }
        [attentionVCs addObject:vcClass];
        [attentionVCTitles addObject:title];
    }
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:attentionVCs andTheirTitles:attentionVCTitles];
    pageVC.titleSizeSelected = 18;
    pageVC.titleSizeNormal = 15;
    pageVC.pageAnimatable = YES;
    pageVC.showOnNavigationBar = YES;
    pageVC.menuViewStyle = WMMenuViewStyleFloodHollow;
    pageVC.titleColorSelected = [UIColor colorWithRed:28/255.0 green:206/255.0 blue:109/255.0 alpha:1];;
    pageVC.titleColorNormal = [UIColor grayColor];
    pageVC.progressColor = [UIColor blackColor];
    pageVC.menuBGColor = [UIColor clearColor];
    pageVC.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    pageVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    return pageVC;
    
}

@end
