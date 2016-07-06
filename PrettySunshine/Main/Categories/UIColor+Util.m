//
//  UIColor+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-18.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "UIColor+Util.h"
//#import "AppDelegate.h"

@implementation UIColor (Util)

#pragma mark - Hex

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}


+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [[self class] colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    if('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    assert(7 == hexString.length || 4 == hexString.length);
    hexString = [[self class] hexStringTransformFromThreeCharacters:hexString];
    
    NSString * redHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt     = [[self class] hexValueToUnsigned:redHex];
    
    NSString * greenHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt   = [[self class] hexValueToUnsigned:greenHex];
    
    NSString * blueHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt    = [[self class] hexValueToUnsigned:blueHex];
    
    return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [[self class] colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    
    UIColor *color = nil;
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    color = [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#else
    color = [UIColor colorWithCalibratedRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#endif
    return color;
}
/** private method */
+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString {
    
    if(hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [hexString substringWithRange:NSMakeRange(1, 1)],[hexString substringWithRange:NSMakeRange(1, 1)],
                     [hexString substringWithRange:NSMakeRange(2, 1)],[hexString substringWithRange:NSMakeRange(2, 1)],
                     [hexString substringWithRange:NSMakeRange(3, 1)],[hexString substringWithRange:NSMakeRange(3, 1)]];
    }
    return hexString;
}
/** private method */
+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    
    unsigned value = 0;
    NSScanner * hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    return value;
}

#pragma mark - theme colors

//+ (UIColor *)themeColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
//    }
//    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
//}
//
//+ (UIColor *)nameColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:37.0/255 green:147.0/255 blue:58.0/255 alpha:1.0];
//    }
//    return [UIColor colorWithHex:0x087221];
//}
//
//+ (UIColor *)titleColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
//    }
//    return [UIColor blackColor];
//}
//
//+ (UIColor *)separatorColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.0];
//    }
//    return [UIColor colorWithRed:217.0/255 green:217.0/255 blue:223.0/255 alpha:1.0];
//}
//
//+ (UIColor *)cellsColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
//    }
//    return [UIColor whiteColor];
//}
//
//+ (UIColor *)titleBarColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return  [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
//    }
//    return [UIColor colorWithHex:0xE1E1E1];
//}
//
//+ (UIColor *)contentTextColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return  [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
//    }
//    return [UIColor colorWithHex:0x272727];
//}
//
//
//+ (UIColor *)selectTitleBarColor
//{
//    
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return  [UIColor colorWithRed:0.067 green:0.282 blue:0.094 alpha:1.0];
//    }
//    return [UIColor colorWithHex:0xE1E1E1];
//}
//
//+ (UIColor *)navigationbarColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.067 green:0.282 blue:0.094 alpha:1.0];
//    }
//    return [UIColor colorWithHex:0x15A230];//0x009000
//}
//
//+ (UIColor *)selectCellSColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:23.0/255 green:23.0/255 blue:23.0/255 alpha:1.0];
//    }
//    return [UIColor colorWithRed:203.0/255 green:203.0/255 blue:203.0/255 alpha:1.0];
//}
//
//+ (UIColor *)labelTextColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:74.0/255 green:74.0/255 blue:74.0/255 alpha:1.0];
//    }
//    return [UIColor whiteColor];
//}
//
//+ (UIColor *)teamButtonColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
//    }
//    return [UIColor colorWithRed:251.0/255 green:251.0/255 blue:253.0/255 alpha:1.0];
//}
//
//+ (UIColor *)infosBackViewColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:24.0/255 green:24.0/255 blue:24.0/255 alpha:0.6];
//    }
//    return [UIColor clearColor];
//}
//
//+ (UIColor *)lineColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:18.0/255 green:144.0/255 blue:105.0/255 alpha:0.6];
//    }
//    return [UIColor colorWithHex:0x2bc157];
//}
//
//+ (UIColor *)borderColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithRed:18.0/255 green:144.0/255 blue:105.0/255 alpha:0.6];
//    }
//    return [UIColor lightGrayColor];
//}
//
//+ (UIColor *)refreshControlColor
//{
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        return [UIColor colorWithHex:0x13502A];
//    }
//    return [UIColor colorWithHex:0x21B04B];
//}

@end
