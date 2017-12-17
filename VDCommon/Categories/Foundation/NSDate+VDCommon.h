//
//  NSDate+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>

#define SECONDS_IN_DAY 86400

@interface NSDate (VDCommon)

- (NSString *) stringValueWithFormat:(NSString *)format;
+ (NSDate *) dateFromString:(NSString *)string format:(NSString *)format;

- (NSString*) descriptionWithFormat:(NSString*) format;
- (NSString*) descriptionWithFormat:(NSString*) format withLocaleIdentifier:(NSString*) localeID;
+ (NSDate*) dateWithFormat:(NSString*) format fromString:(NSString*) text;
+ (NSDate*) dateWithFormat:(NSString*) format fromString:(NSString*) text withLocaleIdentifier:(NSString*) localeID;
- (NSString*) unixTimestamp;

// returns NSDate object where day is same and time = 0;
- (NSDate *)beginningOfDay;

- (NSDateComponents *)dateComponents;
+ (NSDate *)dateFromComponents:(NSDateComponents *)components;


@end
