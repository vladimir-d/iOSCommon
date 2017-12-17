//
//  NSData+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSData+VDCommon.h"

@implementation NSData (VDCommon)


- (NSString *) utf8String{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
