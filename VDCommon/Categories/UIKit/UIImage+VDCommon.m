//
//  UIImage+VDCommon.m
//  VDCommon
//
//  Created by Vladimir on 11/22/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "UIImage+VDCommon.h"
#import "VDCommon.h"

@implementation UIImage (VDCommon)

+ (UIImage *)imageWithCheckedName:(NSString *)imageName{
    if (imageName.hasContent){
        return [self imageNamed:imageName];
    }
    else{
        //ERRLOG(@"imageName is empty or nil");
        return nil;
    }
}
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end
