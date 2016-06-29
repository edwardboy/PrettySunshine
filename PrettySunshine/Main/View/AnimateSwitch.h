//
//  AnimateSwitch.h
//  PrettySunshine
//
//  Created by Groupfly on 16/6/29.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock_T)(BOOL isOn);

@interface AnimateSwitch : UIView

@property (nonatomic, assign, getter=isOn) BOOL on;

- (instancetype)initWithFrame:(CGRect)frame andActionBlock:(ActionBlock_T)actionBlock;


@end
