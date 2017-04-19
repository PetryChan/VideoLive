//
//  PEPlayerModel.h
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/14.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEPlayerModel : NSObject

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *city;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *portrait;

@property (nonatomic,assign) int online_users;

@property (nonatomic,strong) NSString *url;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
