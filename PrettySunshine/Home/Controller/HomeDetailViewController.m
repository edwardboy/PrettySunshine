//
//  HomeDetailViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "HomeDetailViewController.h"

#import "KACircleProgressView.h"

#import "UIViewController+NavigationBarColor.h"

@interface HomeDetailViewController ()

@property (nonatomic,strong) KACircleProgressView *progress;

@end

@implementation HomeDetailViewController

- (KACircleProgressView *)progress{
    if (!_progress) {
        
        _progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
        [self.view addSubview:_progress];
        _progress.trackColor = [UIColor blackColor];
        _progress.progressColor = [UIColor orangeColor];
        _progress.progressWidth = 10;
        
    }
    return _progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"detail";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setNavigationBarColor:kTitleColor alpha:1];
    
    self.progress.progress = 0.7;
    
}

- (void)shapeLayer{
    
    KACircleProgressView *progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:progress];
    progress.trackColor = [UIColor blackColor];
    progress.progressColor = [UIColor orangeColor];
    progress.progress = .7;
    progress.progressWidth = 10;
    
}

@end
