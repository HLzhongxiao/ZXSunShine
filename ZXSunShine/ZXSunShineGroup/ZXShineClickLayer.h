//
//  ZXShineClickLayer.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ZXShineParams.h"

@interface ZXShineClickLayer : CALayer

@property (nonatomic,copy)UIColor *color;
@property (nonatomic,copy)UIColor *fillColor;
@property (nonatomic,assign)BOOL clicked;
@property (nonatomic,assign)float animDuration;

- (void (^)(ZXShineImageType))image;
- (void (^)())startAnim;

@end
