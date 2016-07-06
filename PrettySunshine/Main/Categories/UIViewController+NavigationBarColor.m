//
//  UIViewController+NavigationBarColor.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/6.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "UIViewController+NavigationBarColor.h"

@implementation UIViewController (NavigationBarColor)

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color {
    
    [self viewWillLayoutSubviews];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationController.navigationBar setUserInteractionEnabled:scrollView.contentOffset.y > offset ? YES : NO];
    
    float alpha = 1 - ((offset - scrollView.contentOffset.y) / offset);
    [self setNavigationBarColor:color alpha:alpha];
    
    NSLog(@"alpha---%.1f",alpha);
    
    titleView  .hidden = scrollView.contentOffset.y > offset ? NO : YES;
    movableView.hidden = !titleView.hidden;
}

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView offset:(CGFloat)offset color:(UIColor *)color{
    
    [self viewWillLayoutSubviews];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    [self.navigationController.navigationBar setUserInteractionEnabled:scrollView.contentOffset.y > offset ? YES : NO];
    
    float alpha = 1 - ((offset - scrollView.contentOffset.y) / offset);
    
    if (alpha < 0) {
        alpha = 0;
    }else if(alpha >1){
        alpha = 1;
    }
    
    [self setNavigationBarColor:color alpha:alpha];
    
}

- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[color colorWithAlphaComponent:alpha > 0.95f ? 0.95f : alpha]] forBarMetrics:UIBarMetricsDefault];
    if (self.navigationController.viewControllers.count > 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        view.backgroundColor = color; [self.view addSubview:view];
    }
}
@end
