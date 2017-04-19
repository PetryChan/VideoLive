//
//  PEHeartFlyView.m
//  Heart
//
//  Created by petry(陈荣) on 2017/3/31.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#define PERGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define PERGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define PERandColor PERGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#import "PEHeartFlyView.h"
static CGFloat PI = M_PI;

@interface PEHeartFlyView()

/** 边框颜色  */
@property (nonatomic,strong) UIColor *strokeColor;
/** 填充颜色  */
@property (nonatomic,strong) UIColor *fillColor;

@end

@implementation PEHeartFlyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _strokeColor = [UIColor whiteColor];
        _fillColor = PERandColor;
        self.backgroundColor = [UIColor clearColor];
        self.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return self;
}

- (void)animateInView:(UIView *)view
{
    NSTimeInterval totalAnimationDuration = 6;
    CGFloat heartWidth = CGRectGetWidth(self.bounds);
    CGFloat heartCenterX = self.center.x;
    CGFloat viewHeight = CGRectGetHeight(view.bounds);
    
    //初始化
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.alpha = 0;
    
    //1.跳动显现出来
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.9;
    } completion:NULL];
    
    //2.旋转角度
    NSInteger i = arc4random_uniform(2);        //0 1 两个值 不含上界
    NSInteger rotationDirection = 1 - (2*i);    // -1 OR 1
    NSInteger rotationFraction = arc4random_uniform(10);
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeRotation(rotationDirection * PI/(6 + rotationFraction * 0.2));
    } completion:NULL];
    
    //3.按照贝赛尔曲线移动帧动画
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:self.center];
    //生成结束点 在一定范围内随机 和旋转方向同一侧
    CGPoint endPoint = CGPointMake(heartCenterX + rotationDirection * 2 * heartWidth, viewHeight / 6.0 + arc4random_uniform(viewHeight/4.0));   //以至少高度的六分之一为起点加上 0到四分之一高度之间的随机数
    //生成控制点 也是在一定范围内随机
    NSInteger mulriple = 1;
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1 - (2 * i);
    CGFloat xDelta = (heartWidth/2.0 + arc4random_uniform(2*heartWidth)) * travelDirection * mulriple; //这个mulriple可以控制宽度的倍数
    CGFloat yDelta = MAX(endPoint.y, MAX(arc4random_uniform(8*heartWidth), heartWidth));
    CGPoint controlP1 = CGPointMake(heartCenterX + xDelta, viewHeight - yDelta);
    CGPoint controlP2 = CGPointMake(heartCenterX - 2*xDelta, yDelta);
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlP1 controlPoint2:controlP2];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = totalAnimationDuration + endPoint.y / viewHeight;
    
    [self.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //4.移除动画收尾 Alpha & remove from superview
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//画图 需要在自带的drawRect方法中操作
- (void)drawRect:(CGRect)rect
{
    [self drawHeartInRect:rect];
}

- (void)drawHeartInRect:(CGRect)rect
{
    //设置颜色
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    CGFloat drawingPadding = 4.0;
    //❤️上面的圆的半径 宽度减去两边空隙除以4
    CGFloat curveRadius = floor((CGRectGetWidth(rect) - 2*drawingPadding) / 4.0);
    
    //创建路径
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    
    //以💖的底部顶点为基点 顺时针画：弧度-半圆-半圆-弧度连接基点
    
    //1.移动到💖的底部顶点
    CGPoint bottomLocation = CGPointMake(floor(CGRectGetWidth(rect) / 2.0), CGRectGetHeight(rect) - drawingPadding);
    [heartPath moveToPoint:bottomLocation];
    
    //2.画左边的弧形 贝赛尔曲线
    //endpoint x:4 y:高度一半以上一点
    CGPoint endPintLeftCurve = CGPointMake(drawingPadding, floor(CGRectGetHeight(rect) / 2.4));
    [heartPath addQuadCurveToPoint:endPintLeftCurve controlPoint:CGPointMake(endPintLeftCurve.x, endPintLeftCurve.y + curveRadius)];
    
    //3.画左边的半圆 startAngle：起始的弧度(PI3.14为180度 2PI为360度) endAngle：圆弧结束的弧度 clockwise：YES为顺时针，No为逆时针
    [heartPath addArcWithCenter:CGPointMake(endPintLeftCurve.x + curveRadius, endPintLeftCurve.y) radius:curveRadius startAngle:PI endAngle:0 clockwise:YES];
    
    //4.画右边的半圆
    //计算右边半圆的圆心
    CGPoint topRightCurveCenter = CGPointMake(endPintLeftCurve.x + 3*curveRadius, endPintLeftCurve.y);
    [heartPath addArcWithCenter:topRightCurveCenter radius:curveRadius startAngle:PI endAngle:0 clockwise:YES];
    
    //5.画右边的弧形 贝塞尔曲线
    CGPoint rightControlPoint = CGPointMake(endPintLeftCurve.x + 4*curveRadius, endPintLeftCurve.y + curveRadius);
    [heartPath addQuadCurveToPoint:bottomLocation controlPoint:rightControlPoint];
    
    
    [heartPath fill];
    heartPath.lineWidth = 1;
    heartPath.lineCapStyle = kCGLineCapRound;   //线条拐点
    heartPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    [heartPath stroke];
    
    
}

@end
