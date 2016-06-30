//
//  HomeViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "HomeViewController.h"
#import "ScannerViewController.h"


static NSString *identifier = @"cell";

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    CGFloat _beginOffsetY;   // 记录contentoffset的y
    BOOL _serviceHidden;    // 对客服按钮的hidden属性记录
}
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) UIButton *serviceButton;
@end


@implementation HomeViewController

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
    UIButton * keFu = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, SCREEN_HEIGHT - 64 - 80 - 10 - 49 , 80, 80)];
    [keFu setImage:[UIImage imageNamed:@"kefu03"] forState:UIControlStateNormal];
    [keFu addTarget:self action:@selector(service) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keFu];
    self.serviceButton = keFu;
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"section-%ld,row-%ld",indexPath.section,indexPath.row];
    
    return cell;
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
    if (scrollView.contentOffset.y > _beginOffsetY && _serviceHidden == NO) {
        _serviceHidden = YES;
        [self hide];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewWillBeginDragging");
    
    _beginOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"scrollViewDidEndDragging---%d",decelerate);
    if (_serviceHidden == YES && !decelerate) {
        [self show];
        _serviceHidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidEndDecelerating");
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
