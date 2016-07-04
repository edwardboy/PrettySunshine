//
//  BasicLoginView.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/1.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^LoginBlock)(NSString *userName,NSString *psd);

typedef  void (^RegisterBlock)();

typedef  void (^ForgetPsdBlock)();

@interface BasicLoginView : UIView

@property (nonatomic,copy) LoginBlock loginBlock;

@property (nonatomic,copy) RegisterBlock registerBlock;

@property (nonatomic,copy) ForgetPsdBlock forgetBlock;

//- (instancetype)initWithLoginBlock:(LoginBlock)loginBlock registerBlock:(RegisterBlock)registerBlock forgetBlock:(ForgetPsdBlock)forgetBlock;

@end
