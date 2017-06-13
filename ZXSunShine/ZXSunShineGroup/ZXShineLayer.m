//
//  ZXShineLayer.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineLayer.h"
#import "ZXShineAngleLayer.h"

@interface ZXShineLayer()<CAAnimationDelegate>

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@property (nonatomic,strong)CAShapeLayer *shapeLayer;
@property (nonatomic,strong)CADisplayLink *displaylink;

@end

@implementation ZXShineLayer


- (instancetype)init
{
    if(self = [super init])
    {
        self.fillColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        self.params = [ZXShineParams makeShineParams];
        
        [self initLayers];
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.shapeLayer.strokeColor = fillColor.CGColor;
}

- (CAShapeLayer *)shapeLayer
{
    if(!_shapeLayer)
    {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}

- (void)initLayers
{
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.strokeColor = self.fillColor.CGColor;
    self.shapeLayer.lineWidth = 0.5f;
    [self addSublayer:self.shapeLayer];
}

- (void (^)())startAnim
{
    return ^(){
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.duration = self.params.animDuration * 0.1;
        animation.keyPath = @"path";
        CGSize size = self.frame.size;
        UIBezierPath *fromPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:1 startAngle:0 endAngle:M_PI*2 clockwise:false];
        UIBezierPath *toPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:size.width / 2 * self.params.shineDistanceMultiple startAngle:0 endAngle:M_PI*2 clockwise:false];
        animation.delegate = self;
        animation.values = @[(__bridge id)fromPath.CGPath, (__bridge id)toPath.CGPath];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        [self.shapeLayer addAnimation:animation forKey:@"path"];
        
//        CABasicAnimation *anim = [CABasicAnimation animation];
//        anim.keyPath = @"path";
//        anim.duration = self.params.animDuration * 0.1;
//        anim.fromValue = (__bridge id _Nullable)(fromPath.CGPath);
//        anim.toValue = (__bridge id _Nullable)(toPath.CGPath);
//        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        anim.removedOnCompletion = false;
//        anim.fillMode = kCAFillModeForwards;
//        anim.delegate = self;
//        [self.shapeLayer addAnimation:anim forKey:@"path"];
        
        if(self.params.enableFlashing)
        {
            self.startFlash();
        }
    };
}

- (void (^)())startFlash
{
    return ^(){
        self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
        if(SYSTEM_VERSION_GREATER_THAN(@"iOS 10.0"))
        {
            self.displaylink.preferredFramesPerSecond = 10;
        }else {
            self.displaylink.frameInterval = 6;
        }
        [self.displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    };
}

- (void)flashAction
{
    NSInteger index = arc4random() % self.params.colorRandom.count;
    self.shapeLayer.strokeColor = self.params.colorRandom[index].CGColor;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        [self.displaylink invalidate];
        self.displaylink = nil;
        [self.shapeLayer removeAllAnimations];
        ZXShineAngleLayer *angleLayer = ZXShineAngleLayer.makeAngle(self.params,self.bounds);
        [self addSublayer:angleLayer];
        angleLayer.startAnim();
        if(self.endAnim)
        {
            self.endAnim();
        }
    }
}

@end
