# JHMediator
runtime调用VC，可以不引用VC头文件直接初始化或者PUSH Present，可做组件化调用解耦中间件

##API
```objc
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
```
## 使用方法
 
```objc
    [JHMediator basePresent:@"OneViewController" dic:nil];
    
    [JHMediator getMethodListWithName:@"ViewController"]

    UIViewController *vc = [JHMediator initVC:@"OneViewController"];
    [self presentViewController:vc animated:YES completion:^{ }];

    [JHMediator basePush:@"OneViewController" dic:nil];

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
