//
//  PEProfileCellModel.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEProfileCellModel.h"

@implementation PEProfileCellModel

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon
{
    if (self = [super init]) {
        self.title = title;
        self.icon = icon;
    }
    return self;
}

@end
