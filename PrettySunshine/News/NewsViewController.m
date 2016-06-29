//
//  NewsViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "NewsViewController.h"
#import "AnimateSwitch.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    AnimateSwitch *mySwitch2 = [[AnimateSwitch alloc]initWithFrame:CGRectMake(100, 300, 100, 50) andActionBlock:^(BOOL isOn) {
        NSLog(@"%d",isOn);
    }];
    
    [self.view addSubview:mySwitch2];
    
}

@end
