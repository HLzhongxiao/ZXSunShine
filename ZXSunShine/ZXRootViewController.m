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

    for(int i = 0; i < 4; i++)
    {
        ZXShineButton *button = [ZXShineButton makeShineButton:^(ZXShineButton *button) {
            
            CGFloat deviderH = (self.view.frame.size.height - 4*80) / 5;
            
            button.frame = CGRectMake((self.view.frame.size.width - 80) / 2, (80+deviderH)*i+deviderH, 80, 80);
            button.backgroundColor = [UIColor clearColor];
            button.image = i;
            
        } andParams:^(ZXShineParams *params) {
            
            if(i == 3)
            {
                params.bigShineColor = [UIColor colorWithRed:255/255.0 green:95/255.0 blue:89/255.0 alpha:1.0];
                params.smallShineColor = [UIColor greenColor];
            }else if(i == 4)
            {
                params.bigShineColor = [UIColor colorWithRed:255/255.0 green:95/255.0 blue:89/255.0 alpha:1.0];
                params.smallShineColor = [UIColor colorWithRed:216/255.0 green:152/255.0 blue:148/255.0 alpha:1.0];
            }else{
                params.bigShineColor = [UIColor colorWithRed:255/255.0 green:95/255.0 blue:89/255.0 alpha:1.0];
                params.smallShineColor = [UIColor colorWithRed:216/255.0 green:152/255.0 blue:148/255.0 alpha:1.0];
            }
            
            params.shineCount = 15;
            params.smallShineOffsetAngle = -5;
            params.allowRandomColor = i==1?true:false;
            params.enableFlashing = i==2?true:false;
        }];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }

}

- (void)btnClick
{
    NSLog(@"12");
}


@end
