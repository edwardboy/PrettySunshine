//
//  EDTabBarController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "EDTabBarController.h"

#import "EDNavigationController.h"

#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "NewsViewController.h"
#import "ProfileViewController.h"

#import "PopView.h"


@interface EDTabBarController ()
{
    PopView *_pop;
}
@end

@implementation EDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
    
    
    ProfileViewController *profileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"profile"];
    
    self.viewControllers = @[
                             [self addChildViewController:homeVC title:@"首页" selectedImageName:@"tabbar-news-selected" normalImageName:@"tabbar-news"],
                             
                             [self addChildViewController:[[NewsViewController alloc]init] title:@"动弹" selectedImageName:@"tabbar-tweet-selected" normalImageName:@"tabbar-tweet"],
                             
                             [UIViewController new],
                             
                             [self addChildViewController:[[DiscoverViewController alloc]init] title:@"发现" selectedImageName:@"tabbar-discover-selected" normalImageName:@"tabbar-discover"],
                             
                             [self addChildViewController:profileVC title:@"我" selectedImageName:@"tabbar-me-selected" normalImageName:@"tabbar-me"]
                             ];
    
    [self.tabBar.items[2] setEnabled:NO];
    
    // 添加中间➕按钮
    [self addCenterButton];
    
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage imageFromColor:[UIColor whiteColor]];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 49)];
    imgView.image = img;
    
    [self.tabBar insertSubview:imgView atIndex:0];
    
}

/**
 *  添加中间按钮
 */
- (void)addCenterButton{
    UIButton *centerButton = [[UIButton alloc]init];
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);
    centerButton.layer.cornerRadius = buttonSize.height/2;
    [centerButton setBackgroundColor:[UIColor orangeColor]];
    [centerButton setImage:[UIImage imageNamed:@"team-create"] forState:UIControlStateNormal];
    
    [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:centerButton];
}
/**
 *  中间按钮点击事件
 */
- (void)centerButtonClick{
    NSLog(@"centerButtonClick");
    
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat ScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    PopView *v = [[PopView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight)];
    
    [self.view addSubview:v];
    
}

- (UINavigationController *)addChildViewController:(UIViewController *)vc title:(NSString *)title selectedImageName:(NSString *)selectedImageName normalImageName:(NSString *)normalImageName{
#warning 此处设置vc的背景颜色报错  问题在哪里
//    vc.view.backgroundColor = [UIColor whiteColor];
    // 标题
    vc.navigationItem.title = title;
    
    // 设置普通、选中状态的图片
    vc.tabBarItem.image = [UIImage imageNamed:normalImageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    vc.tabBarItem.title = title;
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 添加导航控制器
    EDNavigationController *nav = [[EDNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    return nav;
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
