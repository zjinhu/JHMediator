//
//  JHMediator.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMediator : NSObject
////有Nav情况下push vc
+ (void)basePush:(NSString *)vcName dic:(NSDictionary *)dic;
////当前VC Present一个有NAV的VC
+ (void)basePresent:(NSString *)vcName dic:(NSDictionary *)dic;
//根据VC名称创建实例
+(id)initVC:(NSString *)vcName;
//根据VC名称创建实例 并传递参数
+(id)initVC:(NSString *)vcName dic:(NSDictionary *)dic;
@end
