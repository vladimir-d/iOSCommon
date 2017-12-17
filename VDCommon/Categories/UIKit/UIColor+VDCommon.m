//
//  UIColor+Common.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "UIColor+VDCommon.h"

UIColor * colorWithRGB(Byte r, Byte g, Byte b){
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

UIColor * colorWithRGBA(Byte r, Byte g, Byte b, CGFloat alpha){
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}


@implementation UIColor (VDCommon)

+ (UIColor *) colorWithHexValue:(NSUInteger)aHexValue{
    return [UIColor colorWithHexValue:aHexValue alpha:1.0];
}


+ (UIColor *) colorWithHexValue:(NSUInteger)aHexValue alpha:(CGFloat)anAlpha{
	NSUInteger b = aHexValue % 0x100;
	NSUInteger g = (aHexValue / 0x100) % 0x100;
	NSUInteger r = (aHexValue / 0x10000);
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:anAlpha];
}




+ (void)setContext:(CGContextRef)context fillCollor:(NSUInteger)aHexValue alpha:(CGFloat)anAlpha {
    NSUInteger b = aHexValue % 0x100;
	NSUInteger g = (aHexValue / 0x100) % 0x100;
	NSUInteger r = (aHexValue / 0x10000);
    CGContextSetRGBFillColor(context, r, g, b, anAlpha);
}

+ (UIColor *) colorWithRGBColorStruct:(RGBColor)rgbColor{
    return [UIColor colorWithRed:rgbColor.r/255.0 green:rgbColor.g/255.0 blue:rgbColor.b/255.0 alpha:1.0];
}






@end
