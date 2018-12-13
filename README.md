# JHMediator
runtime调用VC，可以不引用头文件直接初始化任意类例如model，VC或者直接PUSH Present VC，或者调用类方法实例方法（有回调，可以block），可做组件化调用解耦中间件，不用添加注册表，方便易用

##API
```objc

//根据URL进行跳转页面    ***://push/WebViewController?ios=123&name=456 (注意传递的参数名)|| ***://present/WebViewController
//必须添加打开方式 push||present
//可以实现回调 传值可以是任意类型
//可以实现 推送打开,H5跳转,其他APP调起 任意页面   冒号前前缀外部APP调起需要填写APP的urlscheme  app内调用可随意填写


+ (void)baseOpenURL:(NSURL *)url;
///从URL拼接的参数转换成字典////根据ios=123&name=456格式转换
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
                     
```
## 使用方法，详见DEMO
 
```objc
    [JHMediator basePresent:@"OneViewController" dic:nil];

    UIViewController *vc = [JHMediator initVC:@"OneViewController"];
    [self presentViewController:vc animated:YES completion:^{ }];

    [JHMediator basePush:@"OneViewController" dic:nil];
    
    [JHMediator actionMethodFromObj:obj Selector:@"showFromControlle:body:" Prarms:@[self,body]];
    
    添加路由，通过URL跳转到工程的任意页面可以不用注册URLSchemes
    添加调用任意类别任意方法的函数，支持任意类型参数传参以及回调返回值，详见DEMO

```
##  安装
### 1.手动添加:<br>
*   1.将 JHMediator 文件夹添加到工程目录中<br>
*   2.导入 JHMediator.h

### 2.CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'JHMediator'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 JHMediator.h



##  许可证
JHMediator 使用 MIT 许可证，详情见 LICENSE 文件
