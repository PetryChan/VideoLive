//
//  PEPlayerViewController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/18.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "PEHeartFlyView.h"

@interface PEPlayerViewController ()

@property (atomic, retain) id <IJKMediaPlayback> player;

/** 播放界面  */
@property (nonatomic,weak) UIView *playingView;
/** 地址  */
@property (atomic,strong) NSURL *url;

@property (nonatomic,assign) int number;

@property (nonatomic,assign) CGFloat heartSize;

@property (nonatomic,strong) UIImageView *dimImage;

@property (nonatomic,strong) NSArray *fireworksArray;

@property (nonatomic,weak) CALayer *fireworksLayer;

@end

@implementation PEPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //播放视频
    [self playerPlaying];
    //开启通知
    [self openMovieNotificationObservers];
    //设置加载试图
    [self setupLoadingView];
    //创建相应按钮
    [self setupBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![self.player isPlaying]) {
        //准备播放
        [self.player prepareToPlay];    //必须方法
    }
}

- (void)playerPlaying
{
    self.url = [NSURL URLWithString:_liveUrl];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    
    UIView *playerView = [self.player view];
    UIView *displayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.playingView = displayView;
    [self.view addSubview:self.playingView];
    
    //自动调整自己的高度和宽度
    playerView.frame = self.playingView.bounds;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.playingView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    
}

#pragma open Notifiacation
- (void)openMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    //    NSTimer *    splashTimer = nil;
    //
    //    splashTimer = [NSTimer scheduledTimerWithTimeInterval:0.1  target:self selector:@selector(rote) userInfo:nil repeats:YES];
}

#pragma mark - <设置加载视图>
- (void)setupLoadingView
{
    self.dimImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.dimImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imageUrl]] placeholderImage:[UIImage imageNamed:@"default_room"]];
    //加入毛玻璃效果
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.dimImage.bounds;
    [self.dimImage addSubview:visualEffectView];
    [self.view addSubview:self.dimImage];
    
    
}

#pragma mark - <创建按钮>
- (void)setupBtn
{
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 64 / 2 - 8, 33, 33);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    backBtn.layer.shadowOffset = CGSizeMake(0, 0);
    backBtn.layer.shadowOpacity = 0.5;
    backBtn.layer.shadowRadius = 1;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //暂停
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(SCREENWIDTH - 33 -10, 64 / 2 - 8, 33, 33);
    if (self.number == 0) {
        [stopBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [stopBtn setImage:[UIImage imageNamed:@"开始"] forState:UIControlStateSelected];
    }
    else
    {
        [stopBtn setImage:[UIImage imageNamed:@"开始"] forState:UIControlStateNormal];
        [stopBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    }
    stopBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    stopBtn.layer.shadowOffset = CGSizeMake(0, 0);
    stopBtn.layer.shadowOpacity = 0.5;
    stopBtn.layer.shadowRadius = 1;
    [stopBtn addTarget:self action:@selector(stopOrPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    //底部按钮
    CGFloat btnHW = 36;
    CGFloat margin = 20;
    CGFloat btnY = SCREENHEIGH - 36 -10;
    NSArray *images = @[@"normalMsg",@"privateMsg",@"share",@"gift"];
    NSInteger count = images.count;
    CGFloat linesW = (SCREENWIDTH - margin*2 - btnHW)/(count-1); //减去两边的空隙 减去最后一个按钮的宽度 平均分成3份距离
    for (int i = 0; i<count; i++) {
        UIButton * heartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        heartBtn.frame = CGRectMake(margin + (linesW * i),btnY , btnHW, btnHW);
        [heartBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        heartBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        heartBtn.layer.shadowOffset = CGSizeMake(0, 0);
        heartBtn.layer.shadowOpacity = 0.5;
        heartBtn.layer.shadowRadius = 1;
        heartBtn.adjustsImageWhenHighlighted = NO;
        heartBtn.tag = i;
        [heartBtn addTarget:self action:@selector(showTheLove:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:heartBtn];

    }
}
//返回
- (void)backClick
{
    [self.player shutdown];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//暂停开始
- (void)stopOrPlay:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (![self.player isPlaying]) {
        //播放
        [self.player play];
    }
    else
    {
        //暂停
        [self.player pause];
    }
}

//底部按钮事件
-(void)showTheLove:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            NSLog(@"送小汽车");
            [self sendCar];
            break;
        case 1:
            NSLog(@"petry2");
            break;
        case 2:
            NSLog(@"petry3");
            break;
        case 3:
            NSLog(@"送爱心");
            [self rote];
            break;
            
        default:
            break;
    }
    
    
    
    // button点击动画
    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
    btnAnimation.calculationMode = kCAAnimationLinear;
    btnAnimation.duration = 0.3;
    
    [sender.layer addAnimation:btnAnimation forKey:@"SHOW"];
    
}

- (void)sendCar
{
    CGFloat durTime = 3.0;
    UIImageView *car = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"porsche"]];
    //设置汽车初始位置
    car.frame = CGRectMake(0, 0, 0, 0);
    [self.view addSubview:car];
    //给汽车添加位移大小动画
    [UIView animateWithDuration:durTime animations:^{
        car.frame = CGRectMake(SCREENWIDTH * 0.5 -100, SCREENWIDTH * 0.5 - 100 * 0.5, 240, 120);
    }];
    //一定时间后执行消失动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            car.alpha = 0;
        } completion:^(BOOL finished) {
            [car removeFromSuperview];
        }];
    });
    
    //烟花效果 CALayer切换图片的一个动画
    CALayer *fireLayer = [CALayer layer];
    fireLayer.frame = CGRectMake((SCREENWIDTH-250)*0.5, 100, 250, 50);
    fireLayer.contents = (id)[UIImage imageNamed:@"gift_fireworks_0"].CGImage;
    [self.view.layer addSublayer:fireLayer];
    self.fireworksLayer = fireLayer;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 1; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gift_fireworks_%d",i]];
        [tempArray addObject:image];
    }
    self.fireworksArray = tempArray;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            fireLayer.opacity = 0;
        } completion:^(BOOL finished) {
            [fireLayer removeFromSuperlayer];
            //动画结束 去除定时器
            [timer invalidate];
        }];
    });
}

- (void)rote
{
    _heartSize = 35;
    PEHeartFlyView *heart = [[PEHeartFlyView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(SCREENWIDTH-_heartSize, self.view.bounds.size.height - _heartSize/2.0 - 10);
    heart.center = fountainSource;
    [heart animateInView:self.view];
}
static int _fishIndex = 0;
- (void)update
{
    _fishIndex++;
    if (_fishIndex > 1) {
        _fishIndex = 0;
    }
    UIImage *image = self.fireworksArray[_fishIndex];
    self.fireworksLayer.contents = (id)image.CGImage;
}

#pragma mark - Notifiacation事件
- (void)loadStateDidChange:(NSNotification *)notification
{
    IJKMPMovieLoadState loadState = self.player.loadState;
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }
    else if ((loadState & IJKMPMovieLoadStateStalled) != 0)
    {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    }
    else
    {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification *)notification
{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
    
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification *)notification
{
    NSLog(@"mediaIsPrepareToPlayDidChange ：%s \n",__func__);
}

- (void)moviePlayBackStateDidChange:(NSNotification *)notification
{
    _dimImage.hidden = YES;
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }

    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"dealloc %s",__func__);
}

@end
