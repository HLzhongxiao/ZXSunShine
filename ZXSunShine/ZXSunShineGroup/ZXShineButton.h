//
//  ZXShineButton.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXShineParams.h"

@interface ZXShineButton : UIControl

@property (nonatomic,copy)UIColor *color;
@property (nonatomic,copy)UIColor *fillColor;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,strong)ZXShineParams *params;
@property (nonatomic,assign)ZXShineImageType image;

typedef void (^buttonBlock)(ZXShineButton *button);
typedef void (^paramsBlock)(ZXShineParams *params);

+ (instancetype)makeShineButton:(buttonBlock)buttonBlock andParams:(paramsBlock)paramsBlock;

@end
