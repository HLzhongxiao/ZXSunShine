//
//  ZXShineBundle.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXShineBundle.h"

@interface ZXShineBundle()

@end

@implementation ZXShineBundle

+ (instancetype)makeShineBundle
{
    ZXShineBundle *bundle = [[ZXShineBundle alloc] init];
    return bundle;
}

- (UIImage *(^)(NSString *))imageFromBundle
{
    return ^(NSString *imageName){
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ZXShineButton" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:[bundlePath stringByAppendingPathComponent:@"resourse"]];
        NSString *imagePath = [bundle pathForResource:imageName ofType:@"png"];
    
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        return image;
    };
}

@end
