//
//  ZXRootViewController.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "ZXRootViewController.h"
#import "ZXShineButton.h"


@interface ZXRootViewController ()

@end

@implementation ZXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZXShineButton *button = [ZXShineButton makeShineButton:^(ZXShineButton *button) {
        
        button.frame = CGRectMake(0, 0, 100, 100);
        button.center = self.view.center;
        button.backgroundColor = [UIColor clearColor];
        button.image = heart;

    } andParams:^(ZXShineParams *params) {
        
        params.bigShineColor = [UIColor colorWithRed:255/255.0 green:95/255.0 blue:89/255.0 alpha:1.0];
        params.smallShineColor = [UIColor colorWithRed:216/255.0 green:152/255.0 blue:148/255.0 alpha:1.0];
        params.shineCount = 15;
        params.smallShineOffsetAngle = -5;
        params.allowRandomColor = true;
        params.enableFlashing = true;
    }];
    
    [self.view addSubview:button];
}

@end
