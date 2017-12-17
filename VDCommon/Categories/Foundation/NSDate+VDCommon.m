//
//  NSDate+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSDate+VDCommon.h"
#import "NSDateFormatter+VDCommon.h"

@implementation NSDate (VDCommon)

- (NSString*) descriptionWithFormat:(NSString*) format {
    return [self descriptionWithFormat:format withLocaleIdentifier:@"en_US"];
}

- (NSString*) descriptionWithFormat:(NSString*) format withLocaleIdentifier:(NSString*) localeID {
    if ( localeID == nil || format == nil) {
        return nil;
    }
    
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeID];
    
	static NSDateFormatter *dateFormatter = nil;
    if ( dateFormatter == nil ) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }

	[dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:format];
	NSString *resultDescription = [dateFormatter stringFromDate:self];
	return resultDescription;
}

+ (NSDate *) dateFromString:(NSString *)string format:(NSString *)format{
    return [[NSDateFormatter dateFormatterWithFormat:format] dateFromString:string];
}

+ (NSDate*) dateWithFormat:(NSString*) format fromString:(NSString*) text {
	return [self dateWithFormat:format fromString:text withLocaleIdentifier:@"en_US"];
}

+ (NSDate*) dateWithFormat:(NSString*) format fromString:(NSString*) text withLocaleIdentifier:(NSString*) localeID {
    if ( text == nil || format == nil || localeID == nil) {
        return nil;
    }
    
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeID];
    
    static NSDateFormatter *dateFormatter = nil;
    if ( dateFormatter == nil ) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
	[dateFormatter setLocale:locale];
	[dateFormatter setDateFormat:format];
	NSDate *resultDate = [dateFormatter dateFromString:text];
	return resultDate;
}

- (NSString*) unixTimestamp{
	return [NSString stringWithFormat:@"%ld", (long)[self timeIntervalSince1970]];
}

- (NSDate *)beginningOfDay{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* components = [calendar components:unit fromDate:self];

    return [calendar dateFromComponents:components];
}

- (NSString *) stringValueWithFormat:(NSString *)format{
    return [[NSDateFormatter dateFormatterWithFormat:format] stringFromDate:self];
}

- (NSDateComponents *)dateComponents{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now];
    return components;
}

+ (NSDate *)dateFromComponents:(NSDateComponents *)components{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateFromComponents:components];
}

@end
