//
//  ZXShineBundle.h
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXShineBundle : NSObject

+ (instancetype)makeShineBundle;


- (UIImage *(^)(NSString *imageName))imageFromBundle;

@end
