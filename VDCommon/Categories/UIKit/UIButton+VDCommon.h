//
//  UIButton+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)

// dictionary keys are NSNumber's from UIControlState's
- (void) setImagesFromDictionary:(NSDictionary *)dict;
- (void) setBackgroundImagesFromDictionary:(NSDictionary *)dict;
- (void) setImagesByNameFromDictionary:(NSDictionary *)dict;
- (void) setBackgroundImagesByNameFromDictionary:(NSDictionary *)dict;
+ (id) newWithImagesByNameFromDictionary:(NSDictionary *)dict;
+ (id) newWithBackgroundImagesByNameFromDictionary:(NSDictionary *)dict;

- (void) addClickTarget:(id)target action:(SEL)action;

@end
