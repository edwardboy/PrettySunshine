//
//  EDPopButton.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)();

@interface EDPopButton : UIButton

@property (nonatomic,strong) UIViewController *currentVC;

@end
