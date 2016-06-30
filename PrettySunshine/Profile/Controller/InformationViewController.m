//
//  InformationViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/6/30.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "InformationViewController.h"
#import "MyQRCodeView.h"
#import "UIView+Layout.h"

@interface InformationViewController ()
{
    MyQRCodeView *_qrView;
}
@end

@implementation InformationViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // view 的高度 = view宽 + 上面高 + 下面高
    _qrView = [[MyQRCodeView alloc] initWithFrame:
                            CGRectMake(20, 40, self.view.width - 20 * 2, self.view.width - 20 * 2 + 60 + 30 + 30)];
    
    if ([UIScreen mainScreen].bounds.size.height <= 480) { // 4s 重新调整下高度
        _qrView.frame = CGRectMake(20, 20, self.view.width - 20 * 2, self.view.width - 20 * 2 + 60 + 30 + 10);
    }
    
    [self.view addSubview:_qrView];
    
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
