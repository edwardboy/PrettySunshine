//
//  HomeViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "HomeViewController.h"
#import "ScannerViewController.h"
#import "UIView+Layout.h"
#import "ChatRoomViewController.h"

#import "EDPopButton.h"

#import "HomeDetailViewController.h"


static NSString *identifier = @"cell";

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat _beginOffsetY;   // 记录contentoffset的y
    BOOL _serviceHidden;    // 对客服按钮的hidden属性记录
//    CGFloat _lastOffsetY;
}
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) EDPopButton *serviceButton;
@property (nonatomic,strong) UIView *popView;   // 弹出视图
@end


@implementation HomeViewController
/**
 *  lazy load popView
 *
 *  @return a view type of UIView
 */
- (UIView *)popView{
    
    if (!_popView) {
        
        _popView = [[UIView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _popView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _popView;
}

- (void)dealloc{
    // 清空弹出框
    [self.popView removeFromSuperview];
    self.popView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupView];
    
}
/**
 *  设置界面
 */
- (void)setupView{

    self.view.backgroundColor = [UIColor whiteColor];
    self.listView.rowHeight = 80;
    
    [self.listView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    // 导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"扫描" style:UIBarButtonItemStyleDone target:self action:@selector(scanner)];
    
    // 客服按钮
    EDPopButton * keFu = [[EDPopButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, SCREEN_HEIGHT - 64 - 80 - 10 - 49 , 80, 80)];
    keFu.currentVC = self;
    [keFu setImage:[UIImage imageNamed:@"kefu03"] forState:UIControlStateNormal];
    [keFu addTarget:self action:@selector(service) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keFu];
    self.serviceButton = keFu;
    
    // 给客服按钮添加动画
    CAKeyframeAnimation * pop = [CAKeyframeAnimation animation];
    pop.keyPath     = @"transform.scale";
    pop.values      = @[@0.1, @0.2, @0.3, @0.2, @0.1];
    pop.additive    = YES;
    
    CAAnimationGroup * group = [CAAnimationGroup new];
    group.animations = @[pop];
    group.duration = 0.25;
    group.removedOnCompletion = NO;
    [self.serviceButton.layer addAnimation:group forKey:nil];

}

/**
 *  扫描
 */
- (void)scanner{
    
    [self.navigationController pushViewController:[[ScannerViewController alloc]init] animated:true];
    
}
/**
 *  启用客服
 */
- (void)service{
//    NSLog(@"");
    DLog(@"启用客服");
    
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"kefu03"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"section-%ld,row-%ld",indexPath.section,indexPath.row];
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    HomeDetailViewController *detail = [HomeDetailViewController new];
    
    CGRect frame = [cell.imageView convertRect:cell.imageView.frame toView:self.view];
    
    CALayer *transitionLayer = [CALayer layer];
    transitionLayer.frame = frame;
    transitionLayer.contents = cell.imageView.layer.contents;
    [detail.view.layer addSublayer:transitionLayer];
    
//    [self presentViewController:detail animated:YES completion:nil];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat offsetY = 80;
    
    [self startAnimationWithView:cell offset:offsetY duration:1];
    
}


- (void)startAnimationWithView:(UIView *)view offset:(CGFloat)offset duration:(NSTimeInterval)duration{
    view.transform = CGAffineTransformMakeTranslation(0, offset);
    
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 滚动隐藏导航栏
//    CGFloat offsetY = scrollView.contentOffset.y + self.listView.contentInset.top;
//    
//    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.listView].y;
//    
//    if (offsetY>64) {
//        
//        if (panTranslationY>0) {
//            [self.navigationController setNavigationBarHidden:false animated:true];
//            
//        }else{
//            [self.navigationController setNavigationBarHidden:true animated:true];
//            
//        }
//    }else{
//        [self.navigationController setNavigationBarHidden:false animated:true];
//    
//    }
    
    [self navigationBarGradualChangeWithScrollView:scrollView titleView:nil movableView:nil offset:150 color:kTitleColor];
    
    if (scrollView.contentOffset.y > _beginOffsetY && _serviceHidden == NO) {
        _serviceHidden = YES;
        [self hide];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _beginOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (_serviceHidden == YES && !decelerate) {
        [self show];
        _serviceHidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_serviceHidden == YES) {
        [self show];
        _serviceHidden = NO;
    }
}

/**
 *  客服按钮显示
 */
- (void)hide{
    [UIView animateWithDuration:1 animations:^{
        self.serviceButton.transform = CGAffineTransformMakeTranslation(0, 100) ;
    }];
}
/**
 *  客服按钮隐藏
 */
- (void)show{
    
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionTransitionNone animations:^{
        
        self.serviceButton.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color {
    
    [self viewWillLayoutSubviews];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationController.navigationBar setUserInteractionEnabled:scrollView.contentOffset.y > offset ? YES : NO];
    
    float alpha = 1 - ((offset - scrollView.contentOffset.y) / offset);
    [self setNavigationBarColor:color alpha:alpha];
    
    if (titleView) {
        titleView  .hidden = scrollView.contentOffset.y > offset ? NO : YES;
        movableView.hidden = !titleView.hidden;
    }
}

- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[color colorWithAlphaComponent:alpha > 0.95f ? 0.95f : alpha]] forBarMetrics:UIBarMetricsDefault];
    if (self.navigationController.viewControllers.count > 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
        view.backgroundColor = color; [self.view addSubview:view];
    }
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
