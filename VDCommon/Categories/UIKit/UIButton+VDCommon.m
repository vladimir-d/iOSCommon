//
//  UIButton+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "UIButton+VDCommon.h"
#import "VDCommon.h"

@implementation UIButton (VDCommon)

+ (id) newWithFrame:(CGRect)frame{
    UIButton * btn = [self buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    return btn;
}

- (void) setImagesFromDictionary:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        [self setImage:obj forState:state];
    }];
}

- (void) setBackgroundImagesFromDictionary:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        [self setBackgroundImage:obj forState:state];
    }];
}

- (void) setImagesByNameFromDictionary:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        [self setImage:[UIImage imageWithCheckedName:obj] forState:state];
    }];
}

- (void) setBackgroundImagesByNameFromDictionary:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        [self setBackgroundImage:[UIImage imageWithCheckedName:obj] forState:state];
    }];
}

+ (id) newWithImagesByNameFromDictionary:(NSDictionary *)dict{
    UIButton * btn = [self buttonWithType:UIButtonTypeCustom];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        UIImage * image = [UIImage imageWithCheckedName:obj];
        if (state == UIControlStateNormal){
            btn.size = image.size;
        }
        [btn setImage:image forState:state];
    }];
    return btn;
}

+ (id) newWithBackgroundImagesByNameFromDictionary:(NSDictionary *)dict{
    UIButton * btn = [self buttonWithType:UIButtonTypeCustom];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSUInteger state = [key unsignedIntegerValue];
        UIImage * image = [UIImage imageWithCheckedName:obj];
        if (state == UIControlStateNormal){
            btn.size = image.size;
        }
        [btn setBackgroundImage:image forState:state];
    }];
    return btn;
}

- (void) addClickTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
