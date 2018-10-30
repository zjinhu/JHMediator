//
//  JHMediator.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMediator : NSObject
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
+(id)initClassWithName:(NSString *)name;
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
