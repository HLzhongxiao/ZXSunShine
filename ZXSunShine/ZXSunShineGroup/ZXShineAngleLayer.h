//
//  ZXShineAngleLayer.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ZXShineParams.h"

@interface ZXShineAngleLayer : CALayer

@property (nonatomic,strong)ZXShineParams *params;
@property (nonatomic,strong)NSMutableArray<CAShapeLayer *> *shineLayers;
@property (nonatomic,strong)NSMutableArray<CAShapeLayer *> *smallShineLayers;
@property (nonatomic,strong)CADisplayLink *displaylink;

+ (ZXShineAngleLayer *(^)(ZXShineParams *, CGRect))makeAngle;
- (void (^)())startAnim;

@end
