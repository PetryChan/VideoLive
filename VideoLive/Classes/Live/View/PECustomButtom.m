//
//  PECustomButtom.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/14.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PECustomButtom.h"

@implementation PECustomButtom

- (instancetype)init
{
    if (self = [super init]) {
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//去除高亮
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
