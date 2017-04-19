//
//  PECommendController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/11.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PECommendController.h"
#import "PECustomButtom.h"
#import "PEPlayerModel.h"
#import "PEPlayerTableCell.h"
#import "PEPlayerViewController.h"

#define mainURL @"http://service.inke.com/api/live/aggregation?imsi=&uid=147970465&proto=6&idfa=3EDE83E7-9CD1-4186-9F37-EE77B7423265&lc=0000000000000027&cc=TG0001&imei=&sid=20tJHn0JsxdmOGkbNjpEjo3DIKFyoyboTrCjMvP7zNxofi1QNXT&cv=IK3.2.00_Iphone&devi=134a83cdf2e6701fa8f85c099c5e68ac3ea7bd4b&conn=Wifi&ua=iPhone%205s&idfv=5CCB6FE7-1F0F-4288-90DC-946D6F6C45C2&osversion=ios_9.300000&interest=1&location=0"

#define Ratio 708/550

@interface PECommendController ()<UITableViewDelegate,UITableViewDataSource>
/** <#description#>  */
@property (nonatomic,strong) UITableView *tableView;
/** <#description#>  */
@property (nonatomic,strong) NSMutableArray *dataList;
@end

@implementation PECommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor orangeColor];
    [self addTimeNotifacition];
    [self addTableView];
    [self addCenterButton];
    
    //添加下拉刷新
    [self addRefresh];
}

#pragma mark - 暂时使用time自动刷新，有所欠缺，欢迎指正
- (void)addTimeNotifacition
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:20.0 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
                      
}
- (void)loadData
{
    [self.dataList removeAllObjects];
    //格式
    NSDictionary *dic = @{@"format":@"json"};
    MJWeakSelf
    [AFNetwork GET:mainURL parameters:dic success:^(id  _Nonnull json) {
        NSArray *listArray = [json objectForKey:@"lives"];
        for (NSDictionary *dic in listArray) {
            PEPlayerModel *playerModel = [[PEPlayerModel alloc] initWithDictionary:dic];
            playerModel.portrait = dic[@"creator"][@"portrait"];
            playerModel.name = dic[@"creator"][@"nick"];
            playerModel.url = dic[@"stream_addr"];
            [weakSelf.dataList addObject:playerModel];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

                      
- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREENWIDTH * Ratio + 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)addCenterButton
{
    PECustomButtom *btn = [[PECustomButtom alloc] init];
    [btn setImage:[UIImage imageNamed:@"logo_3745aaf"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(customBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@50);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
}
- (void)customBtnClick
{
    NSLog(@"点击直播按钮--------%s",__func__);
}

- (void)addRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}


#pragma mark - UITableViewDataSource
#define cellIdentifier @"cell"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PEPlayerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PEPlayerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.playerModel = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PEPlayerViewController *playerVC = [[PEPlayerViewController alloc] init];
    PEPlayerModel *playerModel = self.dataList[indexPath.row];
    playerVC.liveUrl = playerModel.url;
    playerVC.imageUrl = playerModel.portrait;
    [self.navigationController pushViewController:playerVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        
    }
    return _dataList;
}
 

@end
