//
//  Utils.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/1.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)showCornerRadius:(CGFloat)cornerRadius  view:(UIView *)view
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

+ (void)showHudWithText:(NSString *)text view:(UIView *)view model:(MBProgressHUDMode)model
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = model;
    hud.dimBackground = NO;
    
    if(model == MBProgressHUDModeText)
    {
        [hud hide:YES afterDelay:1.0];
    }
    
}

+ (void)hiddenHudWithView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
@end
