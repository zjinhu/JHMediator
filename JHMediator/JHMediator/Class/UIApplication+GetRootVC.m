//
//  UIApplication+GetRootVC.m
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIApplication+GetRootVC.h"

@implementation UIApplication (GetRootVC)
- (UIWindow *)mainWindow {
    return self.delegate.window;
}

- (UIViewController *)currentViewController {
    UIViewController *rootViewController = [self.mainWindow rootViewController];
    return [self getCurrentViewControllerFrom:rootViewController];
}

#pragma mark - 获取当前显示的VC
- (UIViewController *) getCurrentViewControllerFrom:(UIViewController *) vc {
    if([vc isKindOfClass:[UISplitViewController class]]) {
        return [self getCurrentViewControllerFrom:((UISplitViewController*) vc).viewControllers.lastObject];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getCurrentViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getCurrentViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getCurrentViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}
- (UINavigationController *)currentNavigationController {
    return [[self currentViewController] navigationController];
}
@end
