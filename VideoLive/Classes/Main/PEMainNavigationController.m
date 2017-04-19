//
//  PEMainNavigationController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/5.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEMainNavigationController.h"

@interface PEMainNavigationController ()
/** 返回按钮  */
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation PEMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        btn.titleLabel.hidden = YES;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        btn.frame = CGRectMake(0, 0, 44, 40);
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

- (void)backBtnClicked:(UIButton *)btn
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
