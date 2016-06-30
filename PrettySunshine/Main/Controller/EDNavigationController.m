//
//  EDNavigationController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/6/30.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "EDNavigationController.h"
#import "UIImage+Util.h"

@interface EDNavigationController ()

@end

@implementation EDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // 导航栏子控件颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 导航栏背景色
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageFromColor:[UIColor orangeColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
