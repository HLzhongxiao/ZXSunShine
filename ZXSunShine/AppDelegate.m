//
//  AppDelegate.m
//  ZXSunShine
//
//  Created by 忠晓 on 2017/6/9.
//  Copyright © 2017年 忠晓. All rights reserved.
//

#import "AppDelegate.h"
#import "ZXRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ZXRootViewController *rootView = [[ZXRootViewController alloc] init];
    self.window.rootViewController = rootView;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
