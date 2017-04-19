//
//  PEProfileCellModel.h
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEProfileCellModel : NSObject

/**  标题 */
@property (nonatomic,copy) NSString *title;
/** 每栏的图片  */
@property (nonatomic,copy) NSString *icon;
/** 用户图片  */
@property (nonatomic,copy) NSString *userIcon;
/** cell右边显示的文字  */
@property (nonatomic,copy) NSString *rightLabel;
/** 右边消息红点  */
@property (nonatomic,assign) NSInteger msgNumber;
/** 需要执行的block  */
@property (nonatomic,copy) void (^complete)();

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon;

@end
