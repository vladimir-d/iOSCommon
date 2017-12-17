//
//  UIViewController+VDTools.m
//  VDTools
//
//  Created by Vladimir Dudkin on 24/02/2014.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (VDTools)

- (NSArray *)recursiveControllers;
+ (NSArray *)rootRecursiveControllers;

- (NSString *)recursiveControllersDescription;

+ (NSString *)rootRecursiveControllersDescription;


@end
