//
//  JHMediator.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMediator : NSObject

//根据URL进行跳转页面    app://push/WebViewController?ios=123&name=456 (注意传递的参数名)|| IKLeaf://present/WebViewController
//必须添加打开方式 push||present
//无法实现回调 某些页面传递对象model类型参数的需要修改为字典类型
//可以实现 推送打开,H5跳转,其他APP调起 任意页面   冒号前前缀外部APP调起需要填写APP的urlscheme  app内调用可随意填写
+ (void)baseOpenURL:(NSURL *)url;


/////////block参数例子
//id call = ^(NSString *aa){
//    NSLog(@"%@",aa);
//};
//dic = @{@"callBack":call,@"name":@"test"}

/**
 * 有Nav情况下push vc
 *
 */
+ (void)basePush:(NSString *)vcName dic:(NSDictionary *)dic;
/**
 * 当前VC Present一个有NAV的VC
 *
 */
+ (void)basePresent:(NSString *)vcName dic:(NSDictionary *)dic;
/**
 *  初始化指定名字的类
 *
 *  @return 返回类对象
 */
+(id)initClass:(NSString *)name;

+(id)initClass:(NSString *)name dic:(NSDictionary *)dic;
/**
 *  根据VC名称创建实例
 *
 *  @return object
 */
+(id)initVC:(NSString *)vcName;
/**
 *  根据VC名称创建实例 并传递参数
 *
 *  @return object
 */
+(id)initVC:(NSString *)vcName dic:(NSDictionary *)dic;

/**
 *  返回当前类的所有属性列表
 *
 *  @return 属性名称
 */
+ (NSArray *)getPropertyListWithName:(NSString *)name;

/**
 *  返回当前类的所有成员变量数组
 *
 *  @return 当前类的所有成员变量！
 *
 *  Tips：用于调试, 可以尝试查看所有不开源的类的ivar
 */
+ (NSArray *)getIvarListWithName:(NSString *)name;

/**
 *  返回当前类的所有方法
 *
 *  @return 当前类的所有成员变量！
 */
+ (NSArray *)getMethodListWithName:(NSString *)name;

/**
 *  返回当前类的所有协议
 *
 *  @return 当前类的所有协议！
 */
+ (NSArray *)getProtocolListWithName:(NSString *)name;
@end
