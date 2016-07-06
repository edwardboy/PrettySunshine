//
//  EDLoginViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/1.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "EDLoginViewController.h"
#import "BasicLoginView.h"
#import "EDTabBarController.h"

@interface EDLoginViewController ()

@end

@implementation EDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    BasicLoginView *loginView = (BasicLoginView *)[[NSBundle mainBundle]loadNibNamed:@"BasicLoginView" owner:self options:nil].firstObject;
    
    __weak typeof(self)weakself = self;
    
    loginView.loginBlock = ^(NSString *userName, NSString *psd){
    
        DLog(@"登录用户名:%@，密码:%@",userName,psd);
        
        if([userName isEqualToString:@"admin"] && [psd isEqualToString:@"123"]){
            
            EDTabBarController *tabbar = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            tabbar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [weakself presentViewController:tabbar animated:true completion:nil];
        }else{
            
            [Utils showHudWithText:@"请正确输入用户信息" view:weakself.view model:MBProgressHUDModeText];
            return;
        }
    };
    loginView.registerBlock = ^{
        DLog(@"注册");
    };
    
    loginView.forgetBlock = ^{
        DLog(@"忘记密码");
    };
    
    loginView.frame = self.view.bounds;
    self.view = loginView;
    
}

@end
