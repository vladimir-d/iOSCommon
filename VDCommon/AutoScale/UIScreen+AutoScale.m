//
//  UIScreen+AutoScale.m
//  VDCommon
//
//  Created by Vladimir on 05/11/13.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "UIScreen+AutoScale.h"
#import "UIScreen+VDCommon.h"

@implementation UIScreen (VDCommon)


static CGFloat wScreenRScaleFactor = 1.0;
static CGFloat hScreenRScaleFactor = 1.0;

CGFloat wScreenFactor(){
    return wScreenRScaleFactor;
}

CGFloat hScreenFactor(){
    return  hScreenRScaleFactor;
}

CGFloat wScreenFScale(CGFloat value){
    return value * wScreenRScaleFactor;
}

CGFloat wScreenRScale(CGFloat value){
    return round(value * wScreenRScaleFactor);
}

CGFloat hScreenRScale(CGFloat value){
    return  round(value * hScreenRScaleFactor);
}

CGSize wScreenRScaleSize(CGSize size){
    return CGSizeMake(round(size.width * wScreenRScaleFactor), round(size.height * wScreenRScaleFactor)) ;
}

CGRect wScreenRScaleRect(CGRect rect){
    return CGRectMake(round(rect.origin.x * wScreenRScaleFactor), round(rect.origin.y * wScreenRScaleFactor), round(rect.size.width * wScreenRScaleFactor), round(rect.size.height * wScreenRScaleFactor)) ;
}

UIEdgeInsets wScreenRScaleInsets(UIEdgeInsets insets){
    return UIEdgeInsetsMake(round(insets.top * wScreenRScaleFactor), round(insets.left * wScreenRScaleFactor), round(insets.bottom * wScreenRScaleFactor), round(insets.right * wScreenRScaleFactor));
}

+ (CGSize) scalingFrom640WidthScreenPixelSize
{
    CGSize resSize = {640.0, 1136.0};
    CGSize ownSize = [UIScreen mainScreen].bounds.size;
    if (ownSize.height == VDCScreenHeight480){
        resSize.height = 960.0;
    }
    return resSize;
}

+ (void)setupScaleFactorsForBaseScreenSize:(CGSize)baseSize{
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	// scaling assumes portrait orientation, so w < h
    wScreenRScaleFactor = MIN(screenSize.width, screenSize.height) / baseSize.width;
    hScreenRScaleFactor = MAX(screenSize.width, screenSize.height) / baseSize.height;
}

+ (CGFloat)byWidthScale:(CGFloat)value{
    return  wScreenRScale(value);
}

+ (CGFloat)byHeightScale:(CGFloat)value{
    return  hScreenRScale(value);
}

@end
