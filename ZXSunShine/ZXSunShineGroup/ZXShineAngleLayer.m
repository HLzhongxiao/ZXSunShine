//
//  ZXShineAngleLayer.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineAngleLayer.h"

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@interface ZXShineAngleLayer()<CAAnimationDelegate>

@end


@implementation ZXShineAngleLayer

+ (ZXShineAngleLayer *(^)(ZXShineParams *, CGRect))makeAngle
{
    return ^(ZXShineParams *params, CGRect shineFrame){
        ZXShineAngleLayer *layer = [[ZXShineAngleLayer alloc] initWithFrame:shineFrame andParams:params];
        return layer;
    };
}

- (NSMutableArray<CAShapeLayer *> *)smallShineLayers
{
    if(!_smallShineLayers)
    {
        _smallShineLayers = [[NSMutableArray alloc] init];
    }
    return _smallShineLayers;
}

- (NSMutableArray<CAShapeLayer *> *)shineLayers
{
    if(!_shineLayers)
    {
        _shineLayers = [[NSMutableArray alloc] init];
    }
    return _shineLayers;
}

- (instancetype)initWithFrame:(CGRect)frame andParams:(ZXShineParams *)params
{
    if(self = [super init])
    {
        self.frame = frame;
        self.params = params;
        [self addShines];
    }
    return self;
}

- (void)addShines
{
    CGFloat startAngle = 0.0;
    CGFloat angle = startAngle + M_PI*2 / self.params.shineCount;
    
    if(self.params.shineCount % 2 != 0){
        startAngle = M_PI * 2 - angle / self.params.shineCount;
    }
    
    CGFloat radius = self.frame.size.width / 2 * self.params.shineDistanceMultiple;
    
    for(int i = 0; i < self.params.shineCount; i++)
    {
        CAShapeLayer *bigShine = [CAShapeLayer layer];
        CGFloat bigWidth = self.frame.size.width * 0.15;
        if(self.params.shineSize != 0)
        {
            bigWidth = self.params.shineSize;
        }
    
        CGPoint center = self.getshineCenter(startAngle+angle*i, radius);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:bigWidth startAngle:0 endAngle:M_PI*2 clockwise:false];
        bigShine.path = path.CGPath;
        if(self.params.allowRandomColor)
        {
            NSInteger index = arc4random() % self.params.colorRandom.count;
            bigShine.fillColor = self.params.colorRandom[index].CGColor;
        }else{
            bigShine.fillColor = self.params.bigShineColor.CGColor;
        }
        [self addSublayer:bigShine];
        [self.shineLayers addObject:bigShine];
        
        CAShapeLayer *smallShine = [CAShapeLayer layer];
        CGFloat smallWidth = bigWidth*0.66;
        CGPoint smallCenter = self.getshineCenter(startAngle+angle*i-self.params.smallShineOffsetAngle*M_PI/180, radius-bigWidth);
        UIBezierPath *smallPath = [UIBezierPath bezierPathWithArcCenter:smallCenter radius:smallWidth startAngle:0 endAngle:M_PI*2 clockwise:false];
        smallShine.path = smallPath.CGPath;
        if(self.params.allowRandomColor)
        {
            NSInteger index = arc4random() % self.params.colorRandom.count;
            smallShine.fillColor = self.params.colorRandom[index].CGColor;
        }else{
            smallShine.fillColor = self.params.smallShineColor.CGColor;
        }
        [self addSublayer:smallShine];
        [self.smallShineLayers addObject:smallShine];
    }
}

- (void (^)())startAnim
{
    return ^(){
        CGFloat radius = self.frame.size.width / 2 * self.params.shineDistanceMultiple * 1.4;
        CGFloat startAngle = 0;
        CGFloat angle = M_PI * 2 / self.params.shineCount + startAngle;
        if(self.params.shineCount % 2 != 0)
        {
            startAngle = M_PI * 2 - angle / self.params.shineCount;
        }
        for(int i = 0; i < self.params.shineCount; i++)
        {
            CAShapeLayer *bigShine = self.shineLayers[i];
            CABasicAnimation *bigAnim = self.getAngleAnim(bigShine, startAngle+angle*i, radius);
            CAShapeLayer *smallShine = self.smallShineLayers[i];
            CGFloat radiusSub = self.frame.size.width * 0.15 * 0.66;
            if(self.params.shineSize != 0)
            {
                radiusSub = self.params.shineSize * 0.66;
            }
            CABasicAnimation *smallAnim = self.getAngleAnim(smallShine, startAngle+angle*i-self.params.smallShineOffsetAngle*M_PI/180, radius-radiusSub);
            [bigShine addAnimation:bigAnim forKey:@"bigPath"];
            [smallShine addAnimation:smallAnim forKey:@"smallPath"];
            
            if(self.params.enableFlashing)
            {
                CABasicAnimation *bigFlash = self.getFlashAnim();
                CABasicAnimation *smallFlash = self.getFlashAnim();
                [bigShine addAnimation:bigFlash forKey:@"bigFlash"];
                [smallShine addAnimation:smallFlash forKey:@"smallFlash"];
            }
        }
        
        CABasicAnimation *angleAnim = [CABasicAnimation animation];
        angleAnim.keyPath = @"transform.rotation";
        angleAnim.duration = self.params.animDuration * 0.87;
        angleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        angleAnim.fromValue = @0;
        angleAnim.toValue = [NSNumber numberWithFloat:self.params.shineTurnAngle*M_PI/180];
        angleAnim.delegate = self;
        angleAnim.removedOnCompletion = false;
        angleAnim.fillMode = kCAFillModeForwards;
        [self addAnimation:angleAnim forKey:@"rotate"];
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

- (CABasicAnimation *(^)(CAShapeLayer *, CGFloat, CGFloat))getAngleAnim
{
    return ^(CAShapeLayer *shine, CGFloat angle, CGFloat radius){
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = @"path";
        anim.duration = self.params.animDuration * 0.87;
        anim.fromValue = (__bridge id _Nullable)(shine.path);
        CGPoint center = self.getshineCenter(angle, radius);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI*2 clockwise:false];
        anim.toValue = (__bridge id _Nullable)(path.CGPath);
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        anim.removedOnCompletion = false;
        anim.fillMode = kCAFillModeForwards;
        return anim;
    };
}

- (CABasicAnimation *(^)())getFlashAnim
{
    return ^(){
        CABasicAnimation *flash = [CABasicAnimation animation];
        flash.keyPath = @"opacity";
        flash.fromValue = @1;
        flash.toValue = @0;
        NSTimeInterval duration = (arc4random() % 20 + 60) / 1000.0;
        flash.duration = duration;
        flash.repeatCount = MAXFLOAT;
        flash.removedOnCompletion = false;
        flash.autoreverses = true;
        flash.fillMode = kCAFillModeForwards;
        return flash;
    };
}

- (CGPoint (^)(CGFloat, CGFloat))getshineCenter
{
    return ^(CGFloat angle, CGFloat radius){
        CGFloat cenx = CGRectGetMidX(self.bounds);
        CGFloat ceny = CGRectGetMidY(self.bounds);
        
        NSInteger multiple = 0;
        if(angle >= 0 && angle <= 90 * M_PI / 180)
        {
            multiple = 1;
        }else if(angle < M_PI && angle > 90 * M_PI / 180)
        {
            multiple = 2;
        }else if(angle > M_PI && angle <= 270 * M_PI / 180)
        {
            multiple = 3;
        }else{
            multiple = 4;
        }
        
        CGFloat resultAngle = multiple * 90 * M_PI / 180 - angle;
        CGFloat a = sin(resultAngle) * radius;
        CGFloat b = cos(resultAngle) * radius;
        
#warning 坐标系需要加深理解
        if(multiple == 1)
        {
            return CGPointMake(cenx+b, ceny-a);
        }else if(multiple == 2)
        {
            return CGPointMake(cenx+a, ceny+b);
        }else if(multiple == 3)
        {
            return CGPointMake(cenx-b, ceny+a);
        }else
        {
            return CGPointMake(cenx-a, ceny-b);
        }
    };
}

- (void)flashAction
{
    for(int i = 0; i < self.params.shineCount; i++)
    {
        CAShapeLayer *bigShine = self.shineLayers[i];
        CAShapeLayer *smallShine = self.smallShineLayers[i];
        NSInteger index1 = arc4random() % self.params.colorRandom.count;
        bigShine.fillColor = self.params.colorRandom[index1].CGColor;
        NSInteger index2 = arc4random() % self.params.colorRandom.count;
        smallShine.fillColor = self.params.colorRandom[index2].CGColor;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        [self.displaylink invalidate];
        self.displaylink = nil;
        [self removeAllAnimations];
        [self removeFromSuperlayer];
    }
    
}

@end
