//
//  ViewController.m
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "ViewController.h"
#import "JHMediator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIViewController *vc = [JHMediator initVC:@"OneViewController"];
//    [self presentViewController:vc animated:YES completion:^{ }];
//
//    [JHMediator basePush:@"OneViewController" dic:nil];
    NSLog(@"%@",[JHMediator getMethodListWithName:@"ViewController"]);
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [JHMediator basePresent:@"OneViewController" dic:nil];
    });
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
