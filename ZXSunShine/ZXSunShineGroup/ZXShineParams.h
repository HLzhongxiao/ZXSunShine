//
//  ZXShineParams.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ZXShineImageType) {
    heart = 0,
    like,
    smile,
    star,
    custom
};

@interface ZXShineParams : NSObject

/**
 是否随机颜色
 */
@property (nonatomic,assign)BOOL allowRandomColor;

/**
 动画时间，秒
 */
@property (nonatomic,assign)float animDuration;

/**
 大Shine的颜色
 */
@property (nonatomic,copy)UIColor *bigShineColor;

/**
 是否需要Flash效果
 */
@property (nonatomic,assign)BOOL enableFlashing;

/**
 shine的个数
 */
@property (nonatomic,assign)NSInteger shineCount;

/**
 shine的扩散的旋转角度
 */
@property (nonatomic,assign)float shineTurnAngle;

/**
 shine的扩散的范围的倍数
 */
@property (nonatomic,assign)float shineDistanceMultiple;

/**
 小shine与大shine之前的角度差异
 */
@property (nonatomic,assign)float smallShineOffsetAngle;

/**
 小shine的颜色
 */
@property (nonatomic,copy)UIColor *smallShineColor;

/**
 shine的大小
 */
@property (nonatomic,assign)CGFloat shineSize;

/**
 随机的颜色列表
 */
@property (nonatomic,strong)NSArray<UIColor *> *colorRandom;

+ (instancetype)makeShineParams;

+ (UIImage *(^)(ZXShineImageType))ZXShineImage;

@end
