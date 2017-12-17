//
//  UIScreen+AutoScale.h
//  VDCommon
//
//  Created by Vladimir on 05/11/13.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>


CGFloat wScreenFactor();
CGFloat hScreenFactor();
CGFloat wScreenFScale(CGFloat value);
CGFloat wScreenRScale(CGFloat value);
CGFloat hScreenRScale(CGFloat value);
CGSize wScreenRScaleSize(CGSize size);
CGRect wScreenRScaleRect(CGRect rect);
UIEdgeInsets wScreenRScaleInsets(UIEdgeInsets insets);

@interface UIScreen (AutoScale)

+ (CGSize) scalingFrom640WidthScreenPixelSize;

+ (void)setupScaleFactorsForBaseScreenSize:(CGSize)baseSize;

@end
