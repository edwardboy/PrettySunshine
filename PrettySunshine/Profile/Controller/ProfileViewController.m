//
//  ProfileViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "ProfileViewController.h"
#import "InformationViewController.h"
#import "UserModel.h"

static NSString *identifier = @"cell";

#define NavigationBarHight 64.0f

#define ImageHight 200.0f

@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_zoomImageView;//变焦图片做底层
    
    UIImageView *_circleView;//类似头像的UIImageView
    
    UILabel *_textLabel;//类似昵称UILabel
    
    UIImageView *_navBackgtoundImageView;   // 导航栏背景图片
}

@property (nonatomic,strong)  UITableView *listView;

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
    
    // 当前用户信息
    UserModel *model = [UserModel sharedUserModel];
    model.userName = @"Pretty Boy";
    model.userAddress = @"上海市宝山区华滋奔腾大厦A404";
    model.userPhotoName = @"car.png";
    model.userUrl = @"https://www.baidu.com";
    
    //1.定义全局tableView
    
    //2.初始化_tableView
    self.listView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
    self.listView.delegate = self;
    self.listView.dataSource = self;
    //4.设置contentInset属性（上左下右 的值）
    self.listView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    //5.添加_tableView
    [self.view addSubview:self.listView];
    
    self.listView.tableFooterView = [[UIView alloc]init];
    
    //  跟图片大小有关
    _zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:model.userPhotoName]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    
    [self.listView addSubview:_zoomImageView];
    
//    _zoomImageView.autoresizesSubviews = YES;
    
//    _circleView = [[UIImageView alloc]initWithFrame:CGRectMake(10, ImageHight-50, 40, 40)];
//    _circleView.backgroundColor = [UIColor redColor];
//    _circleView.layer.cornerRadius = 7.5f;
//    _circleView.image = [UIImage imageNamed:model.userPhotoName];
//    _circleView.clipsToBounds = YES;
//    _circleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
//    [_zoomImageView addSubview:_circleView];
    
//    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, ImageHight-30, 280, 20)];
//    _textLabel.textColor = [UIColor whiteColor];
//    _textLabel.text = model.userName;
//    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
//    [_zoomImageView addSubview:_textLabel];
    
    // 导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的二维码" style:UIBarButtonItemStyleDone target:self action:@selector(lookInformation)];
    
}

/**
 *  查看我的二维码
 */
- (void)lookInformation{
    DLog(@"我的二维码");
    
    [self.navigationController pushViewController:[InformationViewController new] animated:YES];
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    
    // 缩放图片
    CGFloat y = scrollView.contentOffset.y ;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
}

@end
