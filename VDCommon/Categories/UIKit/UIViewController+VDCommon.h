//
//  UIViewController+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIViewController (VDCommon)

- (UIViewController *) selfOrTopViewController;
- (UIViewController *) previousControllerInNavigationStack;
- (UIViewController *) findParentViewControllerOfClass:(Class) parentViewControllerClass;
- (void)addFullSizeChildViewController:(UIViewController *)childViewController;
- (void)addChildViewController:(UIViewController *)childViewController toView:(UIView *)view;
- (void)removeWithViewFromParentViewController;
+ (UIViewController *)rootViewController;

+ (id)initialFromStoryboardWithName:(NSString *)name;


// Only if Class name used as storyboard id
+ (instancetype)newFromStoryboardWithName:(NSString *)name;
+ (instancetype)newFromStoryboard:(UIStoryboard *)storyboard;

- (void) adjustInsetsAtTop:(BOOL)adjustTop bottom:(BOOL)adjustBottom forScrollView:(UIScrollView *)scrollView;

@end
