//
//  BasicLoginView.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/1.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "BasicLoginView.h"
//#import "UIView+Layout.h"
#define kColor1 [UIColor colorWithRed:141/255.0 green:234/255.0 blue:255/255.0 alpha:1]
@interface BasicLoginView ()
{
    CAShapeLayer *_circleShapeLayer;
}
// 背景容器视图
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
// logo
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
// 状态提示标签
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
// 用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPsdButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;
@property (weak, nonatomic) UIButton *loginButton;

@end

@implementation BasicLoginView

- (void)awakeFromNib{
    self.backgroundColor = [UIColor whiteColor];
    
    self.statusLabel.textColor = kTitleColor;
    
    [self.registerButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    [self.forgetPsdButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    self.firstLineView.backgroundColor = kTitleColor;
    self.secondLineView.backgroundColor = kTitleColor;
    
    // 添加登陆按钮
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = CGRectGetMinX(self.userNameTextField.frame);
    CGRect loginButtonFrame = CGRectMake(30 , CGRectGetMaxY(self.forgetPsdButton.frame) + 30, width - 60, 36);
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:loginButtonFrame];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = kTitleColor;
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = 18;
    loginButton.layer.masksToBounds = YES;
    [self.backgroundView addSubview:loginButton];
    
    self.loginButton = loginButton;
    DLog(@"%@--%@--margin-%.1f",NSStringFromCGRect(self.loginButton.frame),self.backgroundView.subviews,margin);
}

/**
 *  登录
 */
- (void)login:(UIButton *)button{
    
    
    if(self.userNameTextField.text.length == 0){
        
        [Utils showHudWithText:@"请输入用户名" view:self model:MBProgressHUDModeText];
        return;
    
    }else if(self.psdTextField.text.length == 0){
        
        [Utils showHudWithText:@"请输入密码" view:self model:MBProgressHUDModeText];
        return;
        
    }else{
        
        [self animateWithLoginButton:button];
        
        self.loginBlock(self.userNameTextField.text,self.psdTextField.text);
        
    }
}

- (void)animateWithLoginButton:(UIButton *)btn{
    DLog(@"登录按钮动画效果");
    
    [UIView animateWithDuration:1.f animations:^{
        [btn setTitle:@"OK" forState:UIControlStateNormal];
        CGPoint center = btn.center;
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.center = center;
        
    }completion:^(BOOL finished) {
        //
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointMake(btn.frame.origin.x, btn.frame.origin.y),CGSizeMake(btn.frame.size.width, btn.frame.size.width)} cornerRadius:btn.frame.size.width * 0.5];
        
        CAShapeLayer *shapeLayerCircle = [CAShapeLayer layer];
        _circleShapeLayer = shapeLayerCircle;
        shapeLayerCircle.frame = CGRectZero;
        shapeLayerCircle.lineWidth = 3.f;
        shapeLayerCircle.strokeColor = kColor1.CGColor;
        shapeLayerCircle.fillColor = [UIColor clearColor].CGColor;
        shapeLayerCircle.path = path.CGPath;
        [_backgroundView.layer addSublayer:shapeLayerCircle];
        CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        bas.duration=1;
        bas.delegate=self;
        bas.fromValue=[NSNumber numberWithInteger:0];
        bas.toValue=[NSNumber numberWithInteger:1];
        [shapeLayerCircle addAnimation:bas forKey:@"key"];
        [self performSelector:@selector(centerAddress) withObject:nil afterDelay:1];
    }];

}

-(void)centerAddress{
    _loginButton.hidden = YES;
    
    CGFloat radius =hypotf(_backgroundView.bounds.size.width, _backgroundView.bounds.size.height);
    // 创建矩形内切圆曲线
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:_loginButton.frame];
    // 创建弧形曲线
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:_loginButton.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    _backgroundView.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = 1;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

#pragma mark - private method
-(UIImage *)createImageFromColor:(UIColor *)color imgSize:(CGSize)size
{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  忘记密码
 */
- (IBAction)rememberPsd {
    if (self.forgetBlock) {
        self.forgetBlock();
    }
//    _forgetBlock();
    
}

/**
 *  注册
 */
- (IBAction)registerClick {
    if (self.registerBlock) {
        self.registerBlock();
    }
//    _registerBlock();
}

@end
