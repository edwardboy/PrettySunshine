//
//  EDPopButton.m
//  PrettySunshine
//
//  Created by Groupfly on 16/7/5.
//  Copyright © 2016年 Groupfly. All rights reserved.
//

#import "EDPopButton.h"
#import <objc/runtime.h>
#import "EDNavigationController.h"
#import "ChatRoomViewController.h"

#import "EDAnimatedTransitioning.h"

@interface EDPopButton () <UIViewControllerTransitioningDelegate>

//@property (nonatomic,strong) CAShapeLayer * roundShapeLayer;
//@property (nonatomic,strong) CAShapeLayer * horizontalShapeLayer;
//@property (nonatomic,strong) CAShapeLayer * verticalShapeLayer;

@end

@implementation EDPopButton
static char kWhenTappedBlockKey;

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self clickButton:^{
        
        EDNavigationController *nav = [[EDNavigationController alloc]initWithRootViewController:[ChatRoomViewController new]];
        [nav setTransitioningDelegate:self];
        if (self.currentVC) {
            [self.currentVC presentViewController:nav animated:YES completion:nil];
        }
        
    }];
    
}

- (void)clickButton:(ClickBlock)block{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
//    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    [self setBlock:block forKey:&kWhenTappedBlockKey];
}

/**
 *  gesture
 */
- (void)tapEvent{
    
    [self runBlockForKey:&kWhenTappedBlockKey];
    
}

/**
 *   绑定
 */
- (void)runBlockForKey:(void *)blockKey {
    ClickBlock block = objc_getAssociatedObject(self, blockKey);
    if (block) block();
}

/**
 *   绑定
 */
- (void)setBlock:(ClickBlock)block forKey:(void *)blockKey {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.center;
    
    center.x += current.x - previous.x; center.y += current.y - previous.y;
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat xMin = self.frame.size.width  * 0.5f; CGFloat xMax = screenWidth  - xMin;
    CGFloat yMin = self.frame.size.height * 0.5f; CGFloat yMax = screenHeight - yMin - 49;
    
    if (center.x > xMax) center.x = xMax; if (center.y > yMax) center.y = yMax;
    if (center.x < xMin) center.x = xMin; if (center.y < yMin) center.y = yMin;
    
    self.center = center;
}
/*
 *  animatedTransitioning
 */
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    EDAnimatedTransitioning * animatedTransitioning = [EDAnimatedTransitioning new];
    animatedTransitioning.frame = self.frame;
//    animatedTransitioning.isPresent = NO;
    return animatedTransitioning;
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    EDAnimatedTransitioning * animatedTransitioning = [EDAnimatedTransitioning new];
//    animatedTransitioning.frame = self.frame;
//    animatedTransitioning.isPresent = YES;
//    return animatedTransitioning;
//}

@end
