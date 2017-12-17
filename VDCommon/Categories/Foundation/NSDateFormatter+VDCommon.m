//
//  NSDateFormatter+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "NSDateFormatter+VDCommon.h"

@implementation NSDateFormatter (VDCommon)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:format];
    return formatter;
}

+ (NSDateFormatter *)dateFormatterWithGMTFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:format];
    return formatter;
}


@end
