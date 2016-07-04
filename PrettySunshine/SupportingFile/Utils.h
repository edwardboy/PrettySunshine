//
//  Utils.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/1.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)showHudWithText:(NSString *)text view:(UIView *)view model:(MBProgressHUDMode)model;

+ (void)hiddenHudWithView:(UIView *)view;


@end
