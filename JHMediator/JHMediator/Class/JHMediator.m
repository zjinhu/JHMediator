//
//  JHMediator.m
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHMediator.h"
#import <objc/runtime.h>

#import "UIApplication+GetRootVC.h"

@implementation JHMediator
#pragma mark - push控制器
// push控制器
+ (void)basePush:(NSString *)vcName dic:(NSDictionary *)dic{
    id instance = [self initVC:vcName dic:dic];
    [[[UIApplication sharedApplication] currentNavigationController] pushViewController:instance animated:YES];
}
#pragma mark - Present控制器
+ (void)basePresent:(NSString *)vcName dic:(NSDictionary *)dic{
    id instance = [self initVC:vcName dic:dic];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:instance];
    [[[UIApplication sharedApplication] currentViewController] presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 初始化指定名字的VC
+(id)initVC:(NSString *)vcName{
    return [self initClassWithName:vcName];
}
#pragma mark - 初始化指定名字的VC 并且给相应的属性赋值
+(id)initVC:(NSString *)vcName dic:(NSDictionary *)dic{
    id instance = [self initVC:vcName];
    //下面是传值－－－－－－－－－－－－－－
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            //kvc给属性赋值
            NSLog(@"%@,%@",obj,key);
            [instance setValue:obj forKey:key];
        }else {
            NSLog(@"不包含key=%@的属性",key);
        }
    }];
    return instance;
}
#pragma mark - 初始化指定名字的类
/**  返回类对象 */
+(id)initClassWithName:(NSString *)name{
    //类名(对象名)
    NSString *class = name;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        //创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象(写到这里已经可以进行随机页面跳转了)
    return [[newClass alloc] init];
}
#pragma mark - 检测对象是否存在该属性
/**
 *  检测对象是否存在该属性
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    // 再遍历父类中的属性
    Class superClass = class_getSuperclass([instance class]);
    //通过下面的方法获取属性列表
    unsigned int outCount2;
    objc_property_t *properties2 = class_copyPropertyList(superClass, &outCount2);
    
    for (int i = 0 ; i < outCount2; i++) {
        objc_property_t property2 = properties2[i];
        //  属性名转成字符串
        NSString *propertyName2 = [[NSString alloc] initWithCString:property_getName(property2) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName2 isEqualToString:verifyPropertyName]) {
            free(properties2);
            return YES;
        }
    }
    free(properties2); //释放数组
    return NO;
}

#pragma mark - 获取本类所有 ‘属性‘ 的数组
/** 程序运行的时候动态的获取当前类的属性列表
 *  程序运行的时候,类的属性不会变化
 */
const void *jh_getPropertyListKey = @"jh_getPropertyListKey";
+ (NSArray *)getPropertyListWithName:(NSString *)name{
    NSArray *result = objc_getAssociatedObject(self, jh_getPropertyListKey);
    if (result != nil){
        return result;
    }
    NSString *class = name;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        NSLog(@"%@不存在",name);
        return nil;
    }
    NSMutableArray *arrayM = [NSMutableArray array];
    // 获取当前类的属性数组
    // count -> 属性的数量
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList(newClass, &count);
    
    for (unsigned int i = 0; i < count; i++) {
        // 根据下标获取属性
        objc_property_t property = list[i];
        
        // 获取属性的名字
        const char *cName = property_getName(property);
        
        // 转换成OC字符串
        NSString *name = [NSString stringWithUTF8String:cName];
        [arrayM addObject:name];
    }
    
    /*! ⚠️注意： 一定要释放数组 class_copyPropertyList底层为C语言，所以我们一定要记得释放properties */
    free(list);
    
    // ---保存属性数组对象---
    objc_setAssociatedObject(self, jh_getPropertyListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, jh_getPropertyListKey);
}

#pragma mark - 获取本类所有 ‘方法‘ 的数组
const void *jh_getMethodListKey = "jh_getMethodListKey";
+ (NSArray *)getMethodListWithName:(NSString *)name{
    // 1. 使用运行时动态添加属性
    NSArray *methodsList = objc_getAssociatedObject(self, jh_getMethodListKey);
    
    // 2. 如果数组中直接返回方法数组
    if (methodsList != nil){
        return methodsList;
    }
    NSString *class = name;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        NSLog(@"%@不存在",name);
        return nil;
    }
    // 3. 获取当前类的方法数组
    unsigned int count = 0;
    Method *list = class_copyMethodList(newClass, &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++){
        // 根据下标获取方法
        Method method = list[i];
        
        SEL methodName = method_getName(method);
        
        NSString *methodName_OC = NSStringFromSelector(methodName);
        
        //        IMP imp = method_getImplementation(method);
        const char *name_s =sel_getName(method_getName(method));
        int arguments = method_getNumberOfArguments(method);
        const char* encoding =method_getTypeEncoding(method);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        
        [arrayM addObject:methodName_OC];
    }
    
    // 4. 释放数组
    free(list);
    
    // 5. 保存方法的数组对象
    objc_setAssociatedObject(self, jh_getMethodListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, jh_getMethodListKey);
}


#pragma mark - 获取本类所有 ‘成员变量‘ 的数组 <用来调试>
/** 获取当前类的所有成员变量 */
const char *jh_getIvarListKey = "jh_getIvarListKey";
+ (NSArray *)getIvarListWithName:(NSString *)name{
    
    // 1. 查询根据key 保存的成员变量数组
    NSArray *ivarList = objc_getAssociatedObject(self, jh_getIvarListKey);
    
    // 2. 判断数组中是否有值, 如果有直接返回
    if (ivarList != nil){
        return ivarList;
    }
    NSString *class = name;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        NSLog(@"%@不存在",name);
        return nil;
    }
    // 3. 如果数组中没有, 则根据当前类,获取当前类的所有 ‘成员变量‘
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(newClass, &count);
    
    // 4. 遍历 成员变量 数组, 获取成员变量的名
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // - C语言的字符串都是 ‘char *‘ 类型的
        const char *ivarName_C = ivar_getName(ivar);
        
        // - 将 C语言的字符串 转换成 OC字符串
        NSString *ivarName_OC = [NSString stringWithUTF8String:ivarName_C];
        // - 将本类 ‘成员变量名‘ 添加到数组
        [arrayM addObject:ivarName_OC];
    }
    
    // 5. 释放ivars
    free(ivars);
    
    // 6. 根据key 动态获取保存在关联对象中的数组
    objc_setAssociatedObject(self, jh_getIvarListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, jh_getIvarListKey);
}

#pragma mark - 获取本类所有 ‘协议‘ 的数组
/** 用来获取动态保存在关联对象中的协议数组 |运行时的关联对象根据key动态取值| */
const char *jh_getProtocolListKey = "jh_getProtocolListKey";

+ (NSArray *)getProtocolListWithName:(NSString *)name{
    NSArray *protocolList = objc_getAssociatedObject(self, jh_getProtocolListKey);
    if (protocolList != nil){
        return protocolList;
    }
    NSString *class = name;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        NSLog(@"%@不存在",name);
        return nil;
    }
    unsigned int count = 0;
    Protocol * __unsafe_unretained *protocolLists = class_copyProtocolList(newClass, &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++) {
        // 获取 协议名
        Protocol *protocol = protocolLists[i];
        const char *protocolName_C = protocol_getName(protocol);
        NSString *protocolName_OC = [NSString stringWithUTF8String:protocolName_C];
        
        // 将 协议名 添加到数组
        [arrayM addObject:protocolName_OC];
    }
    
    // 释放数组
    free(protocolLists);
    // 将保存 协议的数组动态添加到 关联对象
    objc_setAssociatedObject(self, jh_getProtocolListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, jh_getProtocolListKey);
}

@end
