//
//  CustomPopView.h
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBlock)();

@interface CustomPopView : UIView

/**
 *  a block to close this view
 */
@property (nonatomic,copy) CloseBlock closeBlock;

@end
