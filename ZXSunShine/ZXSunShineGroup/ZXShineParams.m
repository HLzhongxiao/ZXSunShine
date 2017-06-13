//
//  ZXShineParams.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineParams.h"
#import "ZXShineBundle.h"

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation ZXShineParams

+ (instancetype)makeShineParams
{
    ZXShineParams *params = [[ZXShineParams alloc] init];
    return params;
}

- (instancetype)init
{
    if(self = [super init])
    {
        [self setupParams];
    }
    return self;
}

- (void)setupParams
{
    
    self.allowRandomColor = false;
    self.animDuration = 1.0;
    self.bigShineColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    self.enableFlashing = false;
    self.shineCount = 7;
    self.shineTurnAngle = 20;
    self.shineDistanceMultiple = 1.5;
    self.smallShineOffsetAngle = 20;
    self.smallShineColor = [UIColor lightGrayColor];
    self.shineSize = 0.0;
    self.colorRandom = @[
                         RGBCOLOR(255, 255, 153),
                         RGBCOLOR(255, 204, 204),
                         RGBCOLOR(153, 102, 153),
                         RGBCOLOR(255, 102, 102),
                         RGBCOLOR(255, 255, 102),
                         RGBCOLOR(244, 67, 54),
                         RGBCOLOR(102, 102, 102),
                         RGBCOLOR(204, 204, 0),
                         RGBCOLOR(102, 102, 102),
                         RGBCOLOR(153, 153, 51),
                         ];
    
}

+ (UIImage *(^)(ZXShineImageType))ZXShineImage
{
    return ^(ZXShineImageType type){
        UIImage *image;
        ZXShineBundle *bundle = [ZXShineBundle makeShineBundle];
        switch (type) {
            case heart:
            {
                image = bundle.imageFromBundle(@"heart");
            }
                break;
            case smile:
            {
                image = bundle.imageFromBundle(@"smile");
            }
                break;
            case like:
            {
                image = bundle.imageFromBundle(@"like");
            }
                break;
            case star:
            {
                image = bundle.imageFromBundle(@"star");
            }
                break;
            case custom:
            {
                image = [UIImage imageNamed:@""];
            }
                break;
        }

        return image;
    };
   
}

@end
