//
//  UIViewController+NavigationBarColor.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/6.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBarColor)
/**
 *  <#Description#>
 *
 *  @param scrollView  <#scrollView description#>
 *  @param titleView   <#titleView description#>
 *  @param movableView <#movableView description#>
 *  @param offset      <#offset description#>
 *  @param color       <#color description#>
 */
- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color;

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView offset:(CGFloat)offset color:(UIColor *)color;

/**
 *  adjust the color and alpha of navigationBar for current viewController
 *
 *  @param color color
 *  @param alpha alpha
 */
- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
