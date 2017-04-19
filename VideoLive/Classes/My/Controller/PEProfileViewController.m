//
//  PEProfileViewController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEProfileViewController.h"
#import "PEProfileCellArrowModel.h"
#import "PEProfileCellGroupModel.h"
#import "PEWebViewController.h"

@interface PEProfileViewController ()

@end

@implementation PEProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PetryChan";
    [self setupDateList];
}

- (void)setupDateList
{
    PEProfileCellArrowModel *liveRecord = [[PEProfileCellArrowModel alloc]initWithTitle:@"精彩回放" icon:@"liveRecord"];
    PEProfileCellArrowModel *profit = [[PEProfileCellArrowModel alloc]initWithTitle:@"我的收益(元)" icon:@"profit"];
    PEProfileCellArrowModel *money = [[PEProfileCellArrowModel alloc]initWithTitle:@"我的金币" icon:@"money"];
    PEProfileCellArrowModel *history = [[PEProfileCellArrowModel alloc]initWithTitle:@"浏览记录" icon:@"history"];
    PEProfileCellArrowModel *setting = [[PEProfileCellArrowModel alloc]initWithTitle:@"设置" icon:@"setting"];
    Class target = [PEWebViewController class];
    liveRecord.target = target;
    profit.target = target;
    money.target = target;
    history.target = target;
    setting.target = target;
    
    PEProfileCellGroupModel *group = [[PEProfileCellGroupModel alloc] initWithCells:@[liveRecord,profit,money,history,setting]];
    [self.groups addObject:group];
    
    
}

@end
