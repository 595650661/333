//
//  PresentationC.m
//  CWLateralSlideDemo
//
//  Created by 程云飞 on 2018/8/17.
//  Copyright © 2018年 chavez. All rights reserved.
//

#import "PresentationC.h"
#import "CWDrawerTransition.h"

@implementation PresentationC

- (void)presentationTransitionWillBegin {
    
    CWMaskView *maskView = [CWMaskView shareInstance];
    
    [self.containerView addSubview: maskView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
       maskView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width * 0.75, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionWillBegin {
    
    CWMaskView *maskView = [CWMaskView shareInstance];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        maskView.alpha = 0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

@end
