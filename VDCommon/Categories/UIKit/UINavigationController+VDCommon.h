//
//  UINavigationController+VDCommon.h
//  VDCommon
//
//  Created by Vladimir on 11/22/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (VDCommon)

- (UIViewController*) viewControllerInStackWithClass:(Class) aClass;
- (UIViewController*) rootViewController;

+ (UINavigationController *) newWithRootViewController:(UIViewController *)rootViewController;
+ (UINavigationController *) newWithRootViewController:(UIViewController *)rootViewController barHidden:(BOOL)hidden;

- (UIViewController *)viewControllerBeforeTopBy:(NSUInteger)steps;

- (void) pushOrPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void) pushOrPopToSameTypeViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
