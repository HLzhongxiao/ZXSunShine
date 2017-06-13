//
//  ZXShineClickLayer.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineClickLayer.h"

@interface ZXShineClickLayer()

@property (nonatomic,strong)CALayer *maskLayer;
@property (nonatomic,strong)UIImage *shineImage;
@end

@implementation ZXShineClickLayer

- (instancetype)init
{
    if(self = [super init])
    {
        self.color = [UIColor lightGrayColor];
        self.fillColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.animDuration = 0.5;
        self.clicked = false;
        self.mask = self.maskLayer;
    }
    return self;
}

- (CALayer *)maskLayer
{
    if(!_maskLayer)
    {
        _maskLayer = [CALayer layer];
    }
    return _maskLayer;
}

- (void)setClicked:(BOOL)clicked
{
    _clicked = clicked;
    
    if(clicked)
    {
        self.backgroundColor = self.fillColor.CGColor;
    }else{
        self.backgroundColor = self.color.CGColor;
    }
}

- (void)layoutSublayers
{
    [super layoutSublayers];
    
    self.maskLayer.frame = self.bounds;
    if(self.clicked)
    {
        self.backgroundColor = self.fillColor.CGColor;
    }else{
        self.backgroundColor = self.color.CGColor;
    }
    self.maskLayer.contents = (__bridge id _Nullable)(self.shineImage.CGImage);
}

- (void (^)(ZXShineImageType))image
{
    return ^(ZXShineImageType type){
        self.shineImage = ZXShineParams.ZXShineImage(type);
    };
}

- (void (^)())startAnim
{
    return ^(){
       CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
       anim.keyPath = @"transform.scale";
       anim.duration = self.animDuration;
       anim.values = @[@0.4, @1, @0.9, @1];
       anim.calculationMode = kCAAnimationCubic;
       [self.maskLayer addAnimation:anim forKey:@"scale"];
    };
}

@end
