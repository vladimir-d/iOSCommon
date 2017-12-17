//
//  UIViewController+Common.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//
@import UIKit;
#import "UIViewController+VDCommon.h"
#import "VDCommon.h"

@implementation UIViewController (VDCommon)

- (UIViewController *) selfOrTopViewController{
    UINavigationController * nc = [UINavigationController castObject:self];
    if (nc != nil){
        return nc.topViewController;
    }
    else{
        return self;
    }
}

- (UIViewController *) previousControllerInNavigationStack {
    NSArray * controllers = self.navigationController.viewControllers;
    NSUInteger ownIndex = [controllers indexOfObject:self];
    if (ownIndex != NSNotFound && ownIndex > 0){
        return [controllers objectAtIndex:ownIndex - 1];
    }
    return nil;
}

- (UIViewController *) findParentViewControllerOfClass:(Class) parentViewControllerClass {
	UIViewController *parent = self.parentViewController;
    
	while ( parent != nil && ![parent isKindOfClass:parentViewControllerClass] ) {
		parent = parent.parentViewController;
	}

	return parent;
}


- (void)addFullSizeChildViewController:(UIViewController *)childViewController {
    [self addChildViewController:childViewController toView:self.view];
}

- (void)addChildViewController:(UIViewController *)childViewController toView:(UIView *)view {
    if (childViewController != nil){
        [self addChildViewController:childViewController];
        childViewController.view.frame = view.bounds;
        childViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view addSubview:childViewController.view];
        [childViewController didMoveToParentViewController:self];
    }
}

- (void)removeWithViewFromParentViewController {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

+ (UIViewController *)rootViewController{
    return [[UIApplication sharedApplication] keyWindow].rootViewController;
}

+ (instancetype)newFromStoryboardWithName:(NSString *)name{
    return [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:[self className]];
}
+ (instancetype)newFromStoryboard:(UIStoryboard *)storyboard{
    return [storyboard instantiateViewControllerWithIdentifier:[self className]];
}

+ (id)initialFromStoryboardWithName:(NSString *)name{
   return [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController];
}

- (void) adjustInsetsAtTop:(BOOL)adjustTop bottom:(BOOL)adjustBottom forScrollView:(UIScrollView *)scrollView{
    UIEdgeInsets currentInsets = scrollView.contentInset;
    if (adjustTop && [self respondsToSelector:@selector(topLayoutGuide)]) {
        currentInsets.top = self.topLayoutGuide.length;
    }
    if (adjustBottom && [self respondsToSelector:@selector(bottomLayoutGuide)]) {
        currentInsets.bottom = self.bottomLayoutGuide.length;
    }
    scrollView.contentInset = currentInsets;
    if (currentInsets.top > 0.0){
        CGPoint contentOffset = scrollView.contentOffset;
        contentOffset.y = -currentInsets.top;
        scrollView.contentOffset = contentOffset;
    }
}



@end
