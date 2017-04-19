//
//  PEPlayerModel.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/14.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEPlayerModel.h"

@implementation PEPlayerModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
