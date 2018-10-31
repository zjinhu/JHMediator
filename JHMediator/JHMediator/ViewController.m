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
//    UIViewController *vc = [JHMediator initVC:@"OneViewController"];
//    [self presentViewController:vc animated:YES completion:^{ }];
//
//    [JHMediator basePush:@"OneViewController" dic:nil];
    NSLog(@"%@",[JHMediator getMethodListWithName:@"OneViewController"]);
//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [JHMediator basePresent:@"OneViewController" dic:nil];
//    });
    // Do any additional setup after loading the view, typically from a nib.
//    Class p = NSClassFromString(@"OneViewController");
//    objc_msgSend([p new], sel_registerName("getMessage"));
    
    //类方法
    Class class = NSClassFromString(@"OneViewController");
    
    SEL sel     = NSSelectorFromString(@"setMessage");
    NSMethodSignature *ys_methodSignature = [class methodSignatureForSelector:sel];


    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:ys_methodSignature];
    invocation.target = class;
    invocation.selector = sel;
    [invocation retainArguments];
    //消息调用
    [invocation invoke];
    id returnObj;
    [invocation getReturnValue:&returnObj];
    NSLog(@"%@",returnObj);
    
    
    id objc = [[class alloc] init];
    SEL sel1     = NSSelectorFromString(@"getMessage");
    NSMethodSignature *ys_methodSignature1 = [class instanceMethodSignatureForSelector:sel1];
    
    NSInvocation *invocation1=[NSInvocation invocationWithMethodSignature:ys_methodSignature1];
    invocation1.target = objc;
    invocation1.selector = sel1;
    [invocation1 retainArguments];
    //消息调用
    [invocation1 invoke];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
