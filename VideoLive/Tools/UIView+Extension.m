//
//  UIView+Extension.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/5.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "UIView+Extension.h"


@implementation UIView (Extension)

- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x  = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)top
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = top;
    self.frame = newFrame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = left;
    self.frame = newFrame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = bottom - self.frame.size.height;
    self.frame = newFrame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = right - self.frame.size.width;
    self.frame = newFrame;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}
- (void)setMaxX:(CGFloat)maxX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = maxX - newFrame.size.width;
    self.frame = newFrame;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}
- (void)setMaxY:(CGFloat)maxY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = maxY - newFrame.size.height;
    self.frame = newFrame;
}

// Move via offset
- (void)moveBy:(CGPoint)delta
{
    CGPoint newCenter = self.center;
    newCenter.x += delta.x;
    newCenter.y += delta.y;
    self.center = newCenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor
{
    CGRect newFrame = self.frame;
    newFrame.size.width *= scaleFactor;
    newFrame.size.height *= scaleFactor;
    self.frame = newFrame;
}

// 自适应尺寸
- (void)fitInSize:(CGSize)aSize
{
    CGRect newFrame = self.frame;
    CGFloat scale;
    
    if (newFrame.size.width && (newFrame.size.width >= aSize.width)) {
        scale = aSize.width / newFrame.size.width;
        newFrame.size.width *= scale;
        newFrame.size.height *= scale;
    }
    if (newFrame.size.height && newFrame.size.height > aSize.width) {
        scale = aSize.height / newFrame.size.height;
        newFrame.size.height *= scale;
        newFrame.size.width *= scale;
    }
    self.frame = newFrame;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)viewFirstXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
