//
//  UIColor+Util.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-18.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;


//+ (UIColor *)themeColor;
//+ (UIColor *)nameColor;
//+ (UIColor *)titleColor;
//+ (UIColor *)separatorColor;
//+ (UIColor *)cellsColor;
//+ (UIColor *)titleBarColor;
//+ (UIColor *)selectTitleBarColor;
//+ (UIColor *)navigationbarColor;
//+ (UIColor *)selectCellSColor;
//+ (UIColor *)labelTextColor;
//+ (UIColor *)teamButtonColor;
//
//+ (UIColor *)infosBackViewColor;
//+ (UIColor *)lineColor;
//
//+ (UIColor *)contentTextColor;
//+ (UIColor *)borderColor;
//+ (UIColor *)refreshControlColor;


@end
