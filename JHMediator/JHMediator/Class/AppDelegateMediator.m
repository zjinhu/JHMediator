//
//  AppDelegateMediator.m
//  JHMediator
//
//  Created by 狄烨 . on 2019/3/15.
//  Copyright © 2019 HU. All rights reserved.
//

#import "AppDelegateMediator.h"
#import "JHMediator.h"
@interface AppDelegateMediator ()
@property (nonatomic, strong) NSMutableArray *classes;
@end

@implementation AppDelegateMediator

+ (instancetype)sharedInstance {
    static AppDelegateMediator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark  methods
- (void)registerModuleWithClass:(NSString *)className{
    if (!className) return;
    [self addService:[JHMediator initClass:className]];
}

- (void)addService:(id)service {
    if (![self.classes containsObject:service] && service !=nil) {
        [self.classes addObject:service];
    }
}

#pragma mark - getters and setters

- (NSMutableArray*)classes {
    if (!_classes) {
        _classes = @[].mutableCopy;
    }
    return _classes;
}

#pragma mark - State Transitions / Launch time:

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class applicationDidBecomeActive:application];
        }
    }
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class applicationDidEnterBackground:application];
        }
    }
}

#pragma mark - State Transitions / Transitioning to the inactive state:

// Called when leaving the foreground state.
- (void)applicationWillResignActive:(UIApplication *)application {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class applicationWillResignActive:application];
        }
    }
}

// Called when transitioning out of the background state.
- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class applicationWillEnterForeground:application];
        }
    }
}

#pragma mark - State Transitions / Termination:

- (void)applicationWillTerminate:(UIApplication *)application {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class applicationWillTerminate:application];
        }
    }
}

#pragma mark - Handling Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler API_AVAILABLE(ios(9.0)) {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler API_AVAILABLE(ios(9.0)) {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

#pragma clang diagnostic pop

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

#pragma mark - Handling Continuing User Activity and Handling Quick Actions

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    BOOL result = NO;
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            result = result || [class application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return result;
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL succeeded))completionHandler  API_AVAILABLE(ios(9.0)){
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            [class application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}
#pragma mark -
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    BOOL result = NO;
    for (id class in self.classes) {
        if ([class respondsToSelector:_cmd]) {
            result = result || [class application:app openURL:url options:options];
        }
    }
    return result;
}
@end
