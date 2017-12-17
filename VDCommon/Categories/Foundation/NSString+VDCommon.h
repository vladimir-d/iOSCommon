//
//  NSString+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>


@interface NSString (VDCommon)

#pragma mark - access to bundle
- (NSString *)stringWithBundlePath;
- (NSString *)stringWithContentsForBundlePath;
+ (id)pathToBundleFile:(NSString *)aFileName;
+ (id)stringFromBundleFile:(NSString *)aFileName;

#pragma mark - Numbers
- (NSComparisonResult) compareNumbers:(NSString*) right;
+ (NSString *)stringHexFromData:(NSData *)data;
- (unsigned) hexIntValue;

#pragma mark - content
@property (readonly, nonatomic) BOOL hasContent;
@property (readonly, nonatomic) BOOL isLatin;
@property (readonly, nonatomic) BOOL isLatinLettersOrDots;


#pragma mark - trimming
- (NSString *) stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *) stringByTrimmingToLength:(NSUInteger)length;

#pragma mark - regex
- (NSArray *) captureGroupSubstringOfFirstMatchForRegexPattern:(NSString *)regexPattern;
- (NSArray *) allMatchesForRegexPattern:(NSString *)regexPattern;
- (BOOL) hasMatchesForRegexPattern:(NSString *)regexPattern;
- (NSTextCheckingResult *) matchForRegexPattern:(NSString *)regexPattern;
- (NSArray *)matchingStringsForRegexPattern:(NSString *)regexPattern;

// Capture groups indices start from 1. 0 is index of whole match.
- (NSArray *)matchingStringsForRegexPattern:(NSString *)regexPattern captureGroupIndex:(NSInteger)groupIndex;

- (NSString *) stringByReplacingMatchesOfRegexPattern:(NSString *)regexPattern withTemplate:(NSString *)templateString;
- (BOOL)isValidEmail;

#pragma mark - Misc
+ (id) stringWithUUID;
+ (NSString *) stringByCombiningNonEmptyStrings:(NSArray *)strings withDelimeter:(NSString *)delimeter;

@end
