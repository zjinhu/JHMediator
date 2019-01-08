//
//  UIApplication+GetRootVC.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (GetRootVC)
- (UIWindow *)mainWindow;
//当前控制器
- (UIViewController *)currentViewController;
//当前nav
- (UINavigationController *)currentNavigationController;
@end
