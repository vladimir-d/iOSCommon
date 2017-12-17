//
//  UIView+VDTools.h
//  VDTools
//
//  Created by Vladimir Dudkin on 24/02/2014.
//  Copyright (c) 2017. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^ViewTestBlock)(UIView *);

void import_UIView_VDTools( );

__attribute__((used)) static void importCategories ()
{
    import_UIView_VDTools();
    // add more import calls here
}


@interface UIView (VDTools)

+ (UIWindow *) keyWindow;
- (UIView *) superviewsAndParentControllerDescription;
- (NSArray *) respondersChain;
- (NSArray *) superviewsChain;
- (UIView *) superviewWithInvalidBounds;

- (NSArray *)recursiveSubviews;
- (NSArray *)viewWithRecursiveSubviews;
- (NSArray *)recursiveSubviewsPassingTest:(ViewTestBlock)block;
- (NSArray *)recursiveSubviewsOfClass:(Class)aClass;

- (NSArray *)allAboveViews;
- (NSArray *)allAboveViewsPassingTest:(ViewTestBlock)block;
- (NSArray *)overlappingAboveViews;
- (NSArray *)overlappingAboveViewsPassingTest:(ViewTestBlock)block;

- (NSString *) whyNotRespondingToTouches;
- (NSString *)originCompositionInView:(UIView *)view;
@end
