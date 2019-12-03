//
//  ViewController.m
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "ViewController.h"
#import "JHMediator.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn1];
    btn1.tag = 1;
    btn1.frame = CGRectMake(10, 100, 150, 44);
    [btn1 setTitle:@"跳转页面 Present" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn2];
    btn2.tag = 2;
    btn2.frame = CGRectMake(200, 100, 150, 44);
    [btn2 setTitle:@"跳转页面 Push" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view, typically from a nib.
//    Class p = NSClassFromString(@"OneViewController");
//    objc_msgSend([p new], sel_registerName("getMessage"));
    
//    //类方法
//    Class class = NSClassFromString(@"OneViewController");
//
//    SEL sel     = NSSelectorFromString(@"setMessage");
//    NSMethodSignature *ys_methodSignature = [class methodSignatureForSelector:sel];
//
//
//    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:ys_methodSignature];
//    invocation.target = class;
//    invocation.selector = sel;
//    [invocation retainArguments];
//    //消息调用
//    [invocation invoke];
//    id returnObj;
//    [invocation getReturnValue:&returnObj];
//    NSLog(@"%@",returnObj);
//
//
//    id objc = [[class alloc] init];
//    SEL sel1     = NSSelectorFromString(@"getMessage");
//    NSMethodSignature *ys_methodSignature1 = [class instanceMethodSignatureForSelector:sel1];
//
//    NSInvocation *invocation1=[NSInvocation invocationWithMethodSignature:ys_methodSignature1];
//    invocation1.target = objc;
//    invocation1.selector = sel1;
//    [invocation1 retainArguments];
//    //消息调用
//    [invocation1 invoke];
//
//
//    int aInt= 100;
//    NSValue * number = SetValue(aInt);
//
//    CGPoint pointt = CGPointMake(121, 1144);
//    NSValue * number12 = SetValue(pointt);
//
//    int (^sjzBlock)(NSString *, int) = ^int (NSString * str, int a) {
//        NSLog(@"%@:%d", str, a);
//        return 1;
//    };
//    NSValue * value = [JHMediator actionMethodFromObj:self Selector:@"Param:string:point:block:" Prarms:@[number, @"今天的天气真好啊", number12, sjzBlock]];
//    int valueRerutn = GetValue(value, int);
//    NSLog(@"Param:string:point:block: 返回值为%d", valueRerutn);
//    NSLog(@"--------------------------");
//    NSLog(@"");
    
//    // 测试类方法
//    NSValue * value123 = [JHMediator actionMethodFromClass:@"Object" Selector:@"str:num:block:" Prarms:@[@"今天的天气真好啊", number, sjzBlock]];
//    int value123Return = GetValue(value123, int);
//    NSLog(@"value123Return = %d", value123Return);

}

- (void)backButtonClicked:(UIButton *)btn {

    switch (btn.tag) {
        case 1:
            [JHMediator basePresent:@"OneViewController" dic:nil];
            break;
        case 2:
            [JHMediator basePush:@"OneViewController" dic:nil];
            break;
        default:
            break;
    }
}

- (int)Param:(int)a string:(NSString *)str point:(CGPoint)point block:(int (^)(NSString *, int))block {
    NSLog(@"int参数%d", a);
    NSLog(@"NSString参数%@", str);
    NSLog(@"CGPoint：x = %f, y = %f", point.x, point.y);
    
    int ss = block(@"block: int为", 1000000);
    NSLog(@"block返回值为：%d", ss);
    
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
