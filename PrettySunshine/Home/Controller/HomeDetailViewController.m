//
//  HomeDetailViewController.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "HomeDetailViewController.h"

#import "KACircleProgressView.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self shapeLayer];
    
}

- (void)shapeLayer{
    
    KACircleProgressView *progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:progress];
    progress.trackColor = [UIColor blackColor];
    progress.progressColor = [UIColor orangeColor];
    progress.progress = .7;
    progress.progressWidth = 10;
    
    /*
     // 创建矩形
     + (UIBezierPath *)bezierPathWithRect:(CGRect)rect
     
     // 创建圆角矩形
     + (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius
     
     // 创建矩形内切圆
     + (UIBezierPath *)bezierPathWithOvalInRect:(CGRect)rect
     
     // 创建弧形
     + (UIBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
     */
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 80, 60, 60)];
//    
//    CAShapeLayer *layer = [CAShapeLayer layer];
////    layer.frame =
//    layer.path = (__bridge CGPathRef _Nullable)(path);
//    
//    layer.fillColor = [UIColor orangeColor].CGColor;
//    layer.strokeColor =  kTitleColor.CGColor;
//    
//    [self.view.layer addSublayer:layer];
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
