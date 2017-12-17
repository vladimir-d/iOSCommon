//
//  UIScreen+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 05/11/13.
//  Copyright (c) 2017. All rights reserved.
//

#import "UIScreen+VDCommon.h"

@implementation UIScreen (VDCommon)


+ (CGSize) pixelSizeForPointsSize:(CGSize) pointSize
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = pointSize;
    size.width *= scale;
    size.height *= scale;
    return size;
}

+ (CGSize) screenSize
{
    CGSize ownSize = [UIScreen mainScreen].bounds.size;
    return ownSize;
}

+ (CGSize) screenPixelSize
{
    CGSize ownSize = [UIScreen mainScreen].bounds.size;
    return [self pixelSizeForPointsSize:ownSize];
}


+ (VDCScreenHeight) screenHeight{
    NSUInteger screenHeight = [UIScreen mainScreen].bounds.size.height;
    VDCScreenHeight height = VDCScreenHeight480;
    switch (screenHeight) {
        case 480:
            height = VDCScreenHeight480;
            break;
        case 568:
            height = VDCScreenHeight568;
            break;
        case 667:
            height = VDCScreenHeight667;
            break;
        case 736:
            height = VDCScreenHeight736;
            break;
    }
    return height;
}

+ (VDCScreenHeightType) screenHeightType{
    if ([self screenHeight] == VDCScreenHeight480){
        return VDCScreenHeightType3_5inch;
    }
    else{
        return VDCScreenHeightType4_0inchOrMore;
    }
}



@end
