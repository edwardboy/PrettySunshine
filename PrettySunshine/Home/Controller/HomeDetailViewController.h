//
//  HomeDetailViewController.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailViewController : UIViewController

/**
 *  frame of the delivered imageView
 */
@property (nonatomic,assign) CGRect imageRect;
/**
 *  the delivered imageName
 */
@property (nonatomic,copy) NSString *imageName;

@end
