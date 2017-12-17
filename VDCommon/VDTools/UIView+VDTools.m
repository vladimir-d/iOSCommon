//
//  UIView+VDTools.m
//  VDTools
//
//  Created by Vladimir Dudkin on 24/02/2014.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "UIView+VDTools.h"

void import_UIView_VDTools( ){}



@implementation UIView (VDTools)

+ (UIWindow *) keyWindow{
    return [[UIApplication sharedApplication] keyWindow];
}

- (NSString *) superviewsAndParentControllerDescription{
    NSMutableArray * parentResponders = [NSMutableArray new];
    Class controllerClass = [UIViewController class];
    for(UIView * view = self; view != nil; view = view.superview){
        [parentResponders addObject:view];
        UIViewController * viewController = ( UIViewController *)self.nextResponder;
        if ([viewController isKindOfClass:controllerClass]){
            [parentResponders addObject:viewController];
        }
    }
    
    NSUInteger count = [parentResponders count];
	NSUInteger halfCount = count / 2;
	for (int i = 0; i < halfCount; i++) {
		[parentResponders exchangeObjectAtIndex:i withObjectAtIndex:count - i - 1];
	}
    
    NSMutableString * desc = [NSMutableString new];
    for(UIResponder * responder in parentResponders){
        [desc appendFormat:@"* %@\n", responder.description];
    }
    return [NSString stringWithString:desc];
}

- (NSArray *) respondersChain{
    NSMutableArray * responders = [NSMutableArray new];
    for(UIResponder * rsp = self; rsp != nil; rsp = [rsp nextResponder]){
        [responders addObject:rsp];
    }
    return [NSArray arrayWithArray:responders];
}

- (NSArray *) superviewsChain{
    NSMutableArray * sViews = [NSMutableArray new];
    for(UIView * view = self; view != nil; view = view.superview){
        [sViews addObject:view];
    }
    return [NSArray arrayWithArray:sViews];
}

- (UIView *) superviewWithInvalidBounds{
    CGRect selfBounds = self.bounds;
    for (UIView * sv = [self superview]; sv != nil; sv = [sv superview]) {
        CGRect relFrame = [sv convertRect:selfBounds fromView:self];
        if (!CGRectContainsRect(sv.bounds, relFrame)){
            return sv;
        }
    }
    return nil;
}

- (NSString *)originCompositionInView:(UIView *)view{
    NSString * r =  NSStringFromCGRect(self.frame);
    return [NSString stringWithFormat:@"ssssss:%@", r];
}



#pragma  mark - recursiveSubviews

- (void) addRecursiveSubviewsToArray:(NSMutableArray *)viewsArray{
    for(UIView * subview in self.subviews){
        [viewsArray addObject:subview];
        [subview addRecursiveSubviewsToArray:viewsArray];
    }
}

- (void) addToArray:(NSMutableArray *)viewsArray recursiveSubviewsPassingTest:(ViewTestBlock)block{
    for(UIView * subview in self.subviews){
        if (block(subview)){
            [viewsArray addObject:subview];
            [subview addRecursiveSubviewsToArray:viewsArray];
        }
    }
}

- (NSArray *)recursiveSubviewsPassingTest:(ViewTestBlock)block{
    NSMutableArray * subviews = [NSMutableArray new];
    [self addToArray:subviews recursiveSubviewsPassingTest:block];
    return [NSArray arrayWithArray:subviews];
}

- (NSArray *)recursiveSubviews{
    NSMutableArray * subviews = [NSMutableArray new];
    [self addRecursiveSubviewsToArray:subviews];
    return [NSArray arrayWithArray:subviews];
}

- (NSArray *)recursiveSubviewsOfClass:(Class)aClass{
    NSMutableArray * classSubviews = [NSMutableArray new];
    for(UIView * subview in [self recursiveSubviews]){
        if ([subview isKindOfClass:aClass]){
            [classSubviews addObject:subview];
        }
    }
    return [NSArray arrayWithArray:classSubviews];
}

- (NSArray *)viewWithRecursiveSubviews{
    NSMutableArray * views = [NSMutableArray new];
    [views addObject:self];
    [self addRecursiveSubviewsToArray:views];
    return [NSArray arrayWithArray:views];
}


#pragma  mark - above views
- (NSArray *)aboveSiblingViews{
    UIView * superView = [self superview];
    if (superView != nil){
        NSArray * siblings = [superView subviews];
        NSUInteger startIndex = [siblings indexOfObject:self] + 1;
        NSInteger length = [siblings count] - startIndex;
        if (length > 0){
            NSArray * aboveSiblings = [siblings subarrayWithRange:NSMakeRange(startIndex, length)];
            return  aboveSiblings;
        }
    }
    return nil;
}

- (NSArray *)allAboveViews{
    NSMutableArray * views = [NSMutableArray new];
    [self addRecursiveSubviewsToArray:views];
    for(UIView * v = self; v != nil; v = v.superview){
        NSArray * aboveSiblings = [v aboveSiblingViews];
        for(UIView * sibling in aboveSiblings){
            [views addObject:sibling];
            [sibling addRecursiveSubviewsToArray:views];
        }
    }
    return [NSArray arrayWithArray:views];
}


- (NSArray *)allAboveViewsPassingTest:(ViewTestBlock)block{
    NSMutableArray * views = [NSMutableArray new];
    [self addToArray:views recursiveSubviewsPassingTest:block];
    for(UIView * v = self; v != nil; v = v.superview){
        NSArray * aboveSiblings = [v aboveSiblingViews];
        for(UIView * sibling in aboveSiblings){
            if (block(sibling)){
                [views addObject:sibling];
                [sibling addToArray:views recursiveSubviewsPassingTest:block];
            }
        }
    }
    return [NSArray arrayWithArray:views];
}

- (NSArray *)overlappingAboveViews{
    CGRect selfBounds = self.bounds;
    NSArray * aboveViews = [self allAboveViews];
    NSMutableArray * overlapViews = [NSMutableArray new];
    
    for(UIView * view in aboveViews){
        CGRect relFrame = [view convertRect:selfBounds fromView:self];
        if (CGRectIntersectsRect(relFrame, view.bounds)){
            [overlapViews addObject:view];
        }
    }
    return [NSArray arrayWithArray:overlapViews];
}

- (NSArray *)overlappingAboveViewsPassingTest:(ViewTestBlock)block{
    CGRect selfBounds = self.bounds;
    NSArray * aboveViews = [self allAboveViewsPassingTest:block];
    NSMutableArray * overlapViews = [NSMutableArray new];
    
    for(UIView * view in aboveViews){
        CGRect relFrame = [view convertRect:selfBounds fromView:self];
        if (CGRectIntersectsRect(relFrame, view.bounds)){
            [overlapViews addObject:view];
        }
    }
    return [NSArray arrayWithArray:overlapViews];
}

- (NSArray *)touchBlockingViews{
    ViewTestBlock touchableBlock = ^(UIView * view){
        BOOL res = (view.userInteractionEnabled && view.alpha > 0.01 && !view.hidden);
        return res;
    };
    NSArray * overlapTouchViews = [self overlappingAboveViewsPassingTest:touchableBlock];
    return overlapTouchViews;
}

- (NSString *) whyNotRespondingToTouches{
    NSMutableArray * reasons = [NSMutableArray new];
    if (!self.userInteractionEnabled){
        [reasons addObject:@"UserInteractionEnabled is not enabled"];
    }
    if (self.alpha < 0.01){
        [reasons addObject:@"Alpha is less then 0.01"];
    }
    if (self.hidden){
        [reasons addObject:@"View is hidden"];
    }
    
    UIView * sView = [self superviewWithInvalidBounds];
    if (sView != nil){
        [reasons addObject:[NSString stringWithFormat:@"Part of view is outside of one of its superviews: %@", sView.description]];
    }
    
    NSArray * blockingViews = [self touchBlockingViews];
    if ([blockingViews count] > 0){
        [reasons addObject:[NSString stringWithFormat:@"View is overlapped by views: %@", blockingViews.description]];
    }
    
    if ([reasons count] > 0){
        return [NSString stringWithFormat:@"Possible reasons: \n* %@", [reasons componentsJoinedByString:@"\n* "]];
    }
    return nil;
}




@end
