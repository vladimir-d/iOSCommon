//
//  UIViewController+VDTools.m
//  VDTools
//
//  Created by Vladimir Dudkin on 24/02/2014.
//  Copyright (c) 2017 Vlad. All rights reserved.
//


#import "UIViewController+VDTools.h"
#import "UIView+VDTools.h"

@implementation UIViewController (VDTools)

- (void) addRecursiveControllersToArray:(NSMutableArray *)controllersArray{
    for(UIViewController * vc in self.childViewControllers){
        [controllersArray addObject:vc];
        [vc addRecursiveControllersToArray:controllersArray];
    }
}

- (void) addRecursiveControllersToArray:(NSMutableArray *)controllersArray level:(NSInteger)level{
    for(UIViewController * vc in self.childViewControllers){
        NSString * padding = @"";
        for (int i = 0; i < level;  i++) {
            padding = [padding stringByAppendingString:@"-   "];
        }
        NSString * vcDesc = [NSString stringWithFormat:@"%@ (%x) view:%@", [vc class], (int)vc, vc.view];
        NSString * desc = [NSString stringWithFormat:@"%@%@", padding, vcDesc];
        [controllersArray addObject:desc];
        [vc addRecursiveControllersToArray:controllersArray level:level + 1];
    }
}

- (void) addRecursiveControllersToDescription:(NSMutableString *)descString padding:(NSString *)padding{
//    NSString * padding = @"";
//    for (int i = 0; i < level;  i++) {
//        padding = [padding stringByAppendingString:@"-   "];
//    }
    NSString * vcDesc = [NSString stringWithFormat:@"%@ (%x) view:%@\n", [self class], (int)self, self.view];
    [descString appendFormat:@"%@%@", padding, vcDesc];
    padding = [padding stringByAppendingString:@"-   "];
    for(UIViewController * vc in self.childViewControllers){
        [vc addRecursiveControllersToDescription:descString padding:padding];
    }
}

+ (NSArray *)rootRecursiveControllers{
    UIWindow * keyWindow = [UIView keyWindow];
    return [keyWindow.rootViewController recursiveControllers];
}

- (NSArray *)recursiveControllers{
    NSMutableArray * controllers = [NSMutableArray new];
    [controllers addObject:self.description];
    [self addRecursiveControllersToArray:controllers];
    return [NSArray arrayWithArray:controllers];
}

- (NSString *)recursiveControllersDescription{
    NSMutableString * str = [NSMutableString new];
    [self addRecursiveControllersToDescription:str padding:@""];
    return [NSString stringWithString:str];
}

+ (NSString *)rootRecursiveControllersDescription{
    UIWindow * keyWindow = [UIView keyWindow];
    return [keyWindow.rootViewController recursiveControllersDescription];
}

+ (NSString *)allWidowsRootRecursiveControllersDescription{
    NSMutableString * str = [NSMutableString new];
    [[[UIApplication sharedApplication] windows] enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendFormat:@"W%@: %@\n***Controllers:***\n%@", @(idx), obj, [obj.rootViewController recursiveControllersDescription]];
    }];
    return [NSString stringWithString:str];
}



@end
