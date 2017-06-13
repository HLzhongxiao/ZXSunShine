//
//  ZXShineLayer.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ZXShineParams.h"

@interface ZXShineLayer : CALayer

@property (nonatomic,copy)UIColor *color;
@property (nonatomic,copy)UIColor *fillColor;
@property (nonatomic,strong)ZXShineParams *params;
@property (nonatomic,copy)void(^endAnim)();

- (void (^)())startAnim;

@end
