//
//  UIScreen+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 05/11/13.
//  Copyright (c) 2017. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VDCScreenHeight){
    VDCScreenHeight480,
    VDCScreenHeight568,
    VDCScreenHeight667,
    VDCScreenHeight736,
    VDCScreenHeightCount
};

typedef NS_ENUM(NSUInteger, VDCScreenHeightType){
    VDCScreenHeightType3_5inch,
    VDCScreenHeightType4_0inchOrMore,
    VDCScreenHeightTypeCount
};


@interface UIScreen (Common)

+ (CGSize) pixelSizeForPointsSize:(CGSize) pointSize;
+ (CGSize) screenPixelSize;
+ (CGSize) screenSize;

+ (VDCScreenHeight) screenHeight;
+ (VDCScreenHeightType) screenHeightType;

@end
