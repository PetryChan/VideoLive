//
//  PEBaseTableController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/11.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEBaseTableController.h"
#import "PEProfileCellGroupModel.h"
#import "PEProfileCell.h"
#import "PEProfileCellArrowModel.h"

@interface PEBaseTableController ()<UITableViewDelegate,UITableViewDataSource>
/** <#description#>  */
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PEBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PEProfileCellGroupModel *group = self.groups[section];
    return group.cells.count;
}

#pragma mark - UITableViewDataSource
#define cellIdentifier @"cell"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PEProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PEProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PEProfileCellGroupModel *group = self.groups[indexPath.section];
    PEProfileCellModel *model = group.cells[indexPath.row];
    cell.cellModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PEProfileCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PEProfileCellModel *model = cell.cellModel;
    //如果cell有自己的block事件 优先执行
    if (model.complete) {
        model.complete();
        return;
    }
    if ([model isKindOfClass:[PEProfileCellArrowModel class]]) {
        PEProfileCellArrowModel *arrow = (PEProfileCellArrowModel *)model;
        Class vcName = arrow.target;
        UIViewController *vc = [[vcName alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
