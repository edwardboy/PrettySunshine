//
//  ProfileViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "ProfileViewController.h"

static NSString *identifier = @"cell";

#define NavigationBarHight 64.0f

#define ImageHight 150.0f

@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_zoomImageView;//变焦图片做底层
    
    UIImageView *_circleView;//类似头像的UIImageView
    UILabel *_textLabel;//类似昵称UILabel
}
@property (nonatomic,strong) IBOutlet UITableView *listView;
@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
}
/**
 *  设置界面
 */
- (void)setUpView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    
    _zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car.png"]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    
    [self.listView addSubview:_zoomImageView];
    
    _zoomImageView.autoresizesSubviews = YES;
    
    _circleView = [[UIImageView alloc]initWithFrame:CGRectMake(10, ImageHight-50, 40, 40)];
    _circleView.backgroundColor = [UIColor redColor];
    _circleView.layer.cornerRadius = 7.5f;
    _circleView.image = [UIImage imageNamed:@"car.jpg"];
    _circleView.clipsToBounds = YES;
    _circleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [_zoomImageView addSubview:_circleView];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, ImageHight-30, 280, 20)];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.text = @"my sunshine";
    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [_zoomImageView addSubview:_textLabel];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    
    CGFloat y = scrollView.contentOffset.y ;//+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
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
