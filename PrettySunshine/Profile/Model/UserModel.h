//
//  UserModel.h
//  PrettySunshine
//
//  Created by Groupfly on 16/6/30.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/**
 *  用户名称
 */
@property (nonatomic,copy) NSString *userName;
/**
 *  用户地址
 */
@property (nonatomic,copy) NSString *userAddress;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *userPhotoName;
/**
 *  用户主页
 */
@property (nonatomic,copy) NSString *userUrl;

/**
 *  获取当前用户
 */
+ (instancetype)sharedUserModel;

@end
