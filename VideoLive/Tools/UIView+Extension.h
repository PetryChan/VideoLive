//
//  UIView+Extension.h
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/5.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

/** UIView的最大X值 */
@property (nonatomic,assign) CGFloat maxX;
/** UIView的最大Y值 */
@property (nonatomic,assign) CGFloat maxY;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

+ (instancetype)viewFromXib;
+ (instancetype)viewFirstXib;


@end
