//
//  PEFansController.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/11.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEFansController.h"
#import "UIView+Extension.h"

@interface PEFansController ()
/** <#description#>  */
@property (nonatomic,strong) UIImageView *img;
/** <#description#>  */
@property (nonatomic,strong) UILabel *lbl;
@end

@implementation PEFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
    _img.center = self.view.center;
    _img.y -= 50;
    [self.view addSubview:_img];
    
    _lbl = ({
        UILabel *lbl = [[UILabel alloc] init];
        lbl.textColor = [UIColor grayColor];
        lbl.text = @"还有没有人跟你说话，找个人聊聊";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
        lbl.y = CGRectGetMaxY(_img.frame) + 10;
        lbl;
    });
    [self.view addSubview:_lbl];
    
}

- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    _lbl.text = self.contentText;
}

@end
