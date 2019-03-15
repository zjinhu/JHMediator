//
//  JHMediator.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

// value为需要转换的变量
#define SetValue(value) [NSValue valueWithBytes:&value objCType:@encode(typeof(value))]

// value为NSValue返回值，Type为返回值类型
#define GetValue(value, Type)\
({\
NSUInteger valueSize = 0;\
NSGetSizeAndAlignment(@encode(Type), &valueSize, NULL);\
void * par = NULL;\
par = reallocf(par, valueSize);\
if (@available(iOS 11.0, *)) {\
[value getValue:par size:valueSize];\
} else {\
[value getValue:par];\
}\
(*((Type *)par));\
})\

#import "UIApplication+GetRootVC.h"
#import "AppDelegateMediator.h"
@interface JHMediator : NSObject


//根据URL进行跳转页面    ***://push/WebViewController?ios=123&name=456 (注意传递的参数名)|| ***://present/WebViewController
//必须添加打开方式 push||present
//无法实现回调 某些页面传递对象model类型参数的需要修改为字典类型
//可以实现 推送打开,H5跳转,其他APP调起 任意页面   冒号前前缀外部APP调起需要填写APP的urlscheme  app内调用可随意填写


+ (void)baseOpenURL:(NSURL *)url;
///从URL拼接的参数转换成字典//根据ios=123&name=456格式转换
+ (NSDictionary *)getDicFromString:(NSString *)string;

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
+ (id)initClass:(NSString *)name;

+ (id)initClass:(NSString *)name dic:(NSDictionary *)dic;
/**
 *  根据VC名称创建实例
 *
 *  @return object
 */
+ (id)initVC:(NSString *)vcName;
/**
 *  根据VC名称创建实例 并传递参数
 *
 *  @return object
 */
+ (id)initVC:(NSString *)vcName dic:(NSDictionary *)dic;


#pragma mark - objc_msgSend

/**
 *调用某个类中的实例方法
 * params: OC对象类型 和 block直接扔进数组，其他类型用 宏SetValue 转为NSValue
 * 返回值：OC对象类型 和 block直接获取，其他类型赋值给NSValue对象，再用GetValue(value, Type)转为相应类型
 */
+ (id)actionMethodFromObj:(id)objc
                 Selector:(NSString *)selector
                   Prarms:(NSArray*)params;
/**
 *调用某个类中的类方法idz
 * params: OC对象类型 和 block直接扔进数组，其他类型用 宏SetValue 转为NSValue
 * 返回值：OC对象类型 和 block直接获取，其他类型赋值给NSValue对象，再用GetValue(value, Type)转为相应类型
 */
+ (id)actionMethodFromClass:(NSString *)className
                   Selector:(NSString *)selector
                     Prarms:(NSArray*)params;

@end
