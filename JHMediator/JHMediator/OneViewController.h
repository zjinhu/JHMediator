//
//  OneViewController.h
//  JHMediator
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController

@property (nonatomic ,strong) NSString *message;
@property (nonatomic ,strong) NSDictionary *messageDic;

-(void)getMessage;
+(NSString *)setMessage;
@end
