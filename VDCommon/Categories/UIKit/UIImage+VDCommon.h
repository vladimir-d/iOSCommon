//
//  UIImage+VDCommon.h
//  VDCommon
//
//  Created by Vladimir on 11/22/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VDCommon)

+ (NSString *)contentTypeForImageData:(NSData *)data;
+ (UIImage *)imageWithCheckedName:(NSString *)imageName;
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

@end
