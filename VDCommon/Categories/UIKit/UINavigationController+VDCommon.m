//
//  UINavigationController+VDCommon.m
//  VDCommon
//
//  Created by Vladimir on 11/22/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "UINavigationController+VDCommon.h"


@implementation UINavigationController (VDCommon)

- (UIViewController*) viewControllerInStackWithClass:(Class) aClass{
	for (UIViewController *ctrl in self.viewControllers) {
		if ( [ctrl isMemberOfClass:aClass] ) {
			return ctrl;
		}
	}
	return nil;
}

- (UIViewController*) rootViewController{
	UIViewController* root = nil;
	if ([self.viewControllers count]){
		root = [self.viewControllers objectAtIndex:0];
	}
	return root;
}

+ (UINavigationController *) newWithRootViewController:(UIViewController *)rootViewController{
    return [[self alloc] initWithRootViewController:rootViewController];
}

+ (UINavigationController *) newWithRootViewController:(UIViewController *)rootViewController barHidden:(BOOL)hidden{
    UINavigationController * nc = [[self alloc] initWithRootViewController:rootViewController];
    nc.navigationBarHidden = hidden;
    return nc;
}

- (UIViewController *)viewControllerBeforeTopBy:(NSUInteger)steps{
    NSArray * items = self.viewControllers;
    NSUInteger count = [items count];
    if (steps < count){
        return  items[count - steps - 1];
    }
    return  nil;
}

- (void) pushOrPopToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == nil){
        return;
    }
    if ([self.viewControllers containsObject:viewController]){
        [self popToViewController:viewController animated:animated];
    }
    else{
        [self pushViewController:viewController animated:animated];
    }
}

- (void) pushOrPopToSameTypeViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == nil){
        return;
    }
    Class vcClass = [viewController class];
    for (UIViewController * vc in self.viewControllers) {
        if ([vc isKindOfClass:vcClass]){
            [self popToViewController:vc animated:animated];
            return;
        }
    }
    [self pushViewController:viewController animated:animated];
}


@end
