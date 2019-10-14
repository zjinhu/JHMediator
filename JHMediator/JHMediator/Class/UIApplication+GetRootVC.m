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
    //适配iOS13的 SceneDelegate， AppDelegate添加 @property (strong, nonatomic) UIWindow *window;
    for (UIWindow * obj in self.windows) {
        if ([obj isKeyWindow]) {
            return obj;
        }
    }
    return self.delegate.window;
}

- (UIViewController *)currentViewController {
    UIViewController *rootViewController = [self.mainWindow rootViewController];
    return [self getCurrentViewControllerFrom:rootViewController];
}

#pragma mark - 获取当前显示的VC
- (UIViewController *) getCurrentViewControllerFrom:(UIViewController *) vc {
//    if([vc isKindOfClass:[UISplitViewController class]]) {
//        return [self getCurrentViewControllerFrom:((UISplitViewController*) vc).viewControllers.lastObject];
//    } else if ([vc isKindOfClass:[UINavigationController class]]) {
//        return [self getCurrentViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
//    } else if ([vc isKindOfClass:[UITabBarController class]]) {
//        return [self getCurrentViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
//    } else {
//        if (vc.presentedViewController) {
//            return [self getCurrentViewControllerFrom:vc.presentedViewController];
//        } else {
//            return vc;
//        }
//    }
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self getCurrentViewControllerFrom:vc.presentedViewController];
    } else if( [vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0){
            return [self getCurrentViewControllerFrom:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0){
            return [self getCurrentViewControllerFrom:svc.topViewController];
        }else{
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0){
            return [self getCurrentViewControllerFrom:svc.selectedViewController];
        }else{
            return vc;
        }
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
- (UINavigationController *)currentNavigationController {
    return [[self currentViewController] navigationController];
}
@end
