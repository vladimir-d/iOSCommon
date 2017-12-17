//
//  UIColor+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

@import UIKit;
@import Foundation;

typedef struct {
    unsigned char r;
    unsigned char g;
    unsigned char b;
}RGBColor;

UIColor * colorWithRGB(Byte r, Byte g, Byte b);
UIColor * colorWithRGBA(Byte r, Byte g, Byte b, CGFloat alpha);

@interface UIColor (VDCommon)

+ (UIColor *) colorWithHexValue:(NSUInteger)aHexValue;
+ (UIColor *) colorWithHexValue:(NSUInteger)aHexValue alpha:(CGFloat)anAlpha;
+ (UIColor *) colorWithRGBColorStruct:(RGBColor)rgbColor;

+ (void)setContext:(CGContextRef)context fillCollor:(NSUInteger)aHexValue alpha:(CGFloat)anAlpha;

@end
