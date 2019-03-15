//
//  AppDelegateMediator.h
//  JHMediator
//
//  Created by 狄烨 . on 2019/3/15.
//  Copyright © 2019 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/////需要在AppDelegate中对应的方法中添加钩子 并且注册相应的类
/**
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 [[AppDelegateMediator sharedInstance] registerModuleWithClass:@"xxxxxxxx"];
 [[AppDelegateMediator sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
 return YES;
 }
 - (void)applicationDidBecomeActive:(UIApplication *)application {
 [[AppDelegateMediator sharedInstance] applicationDidBecomeActive:application];
 }
 */
@interface AppDelegateMediator : NSObject<UIApplicationDelegate>
+ (instancetype)sharedInstance;
- (void)registerModuleWithClass:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
