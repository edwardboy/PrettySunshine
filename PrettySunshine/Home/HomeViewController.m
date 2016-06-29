//
//  HomeViewController.m
//  CustomTabbarController
//
//  Created by Groupfly on 16/6/27.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "HomeViewController.h"



static NSString *identifier = @"cell";

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listView;

@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listView.rowHeight = 80;
    
    [self.listView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

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
    
    CGFloat offsetY = scrollView.contentOffset.y + self.listView.contentInset.top;
    
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.listView].y;
    
    if (offsetY>64) {
        if (panTranslationY>0) {
            [self.navigationController setNavigationBarHidden:false animated:true];
            
        }else{
            [self.navigationController setNavigationBarHidden:true animated:true];
            
        }
    }else{
        [self.navigationController setNavigationBarHidden:false animated:true];
    
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
