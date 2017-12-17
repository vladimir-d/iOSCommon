//
//  NSString+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSString+VDCommon.h"


@implementation NSString (VDCommon)

+ (id)stringWithUUID {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	NSString *uString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid);
	return uString;
}

- (NSString *)stringWithBundlePath{
	return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self];
}

- (NSString *)stringWithContentsForBundlePath{
    return [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self] encoding:NSUTF8StringEncoding error:NULL];
}

+ (id)pathToBundleFile:(NSString *)aFileName{
	return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:aFileName];
}

+ (id)stringFromBundleFile:(NSString *)aFileName{
	return [NSString stringWithContentsOfFile:[NSString pathToBundleFile:aFileName] encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL)hasContent{
    return [self length] > 0;
}


- (NSComparisonResult) compareNumbers:(NSString*) right {
    
	static NSCharacterSet *charSet = nil;
    if ( charSet == nil ) {
        charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.,"] invertedSet];
    }
	
	return [[self stringByTrimmingCharactersInSet:charSet] 
            compare:[right stringByTrimmingCharactersInSet:charSet] 
			options:NSCaseInsensitiveSearch | NSNumericSearch];
}


+ (NSString *)stringHexFromData:(NSData *)data{
    return [[[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (unsigned) hexIntValue{
    unsigned result;
    NSScanner *scanner = [NSScanner scannerWithString: self];
    [scanner scanHexInt: &result];
    return result;
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (NSString *) stringByTrimmingToLength:(NSUInteger)length{
    if ([self length] > length){
        return [self substringToIndex:length];
    }
    else{
        return self;
    }
}

- (BOOL) isLatin{
    return [self canBeConvertedToEncoding:NSISOLatin1StringEncoding];
}
- (BOOL) isLatinLettersOrDots{
    if ([self canBeConvertedToEncoding:NSISOLatin1StringEncoding]){
        NSMutableCharacterSet * letterAndDotSet = [NSMutableCharacterSet letterCharacterSet];
        [letterAndDotSet addCharactersInString:@"."];
        if ([self rangeOfCharacterFromSet:[letterAndDotSet invertedSet]].length == 0){
            return YES;
        }
    }
    return NO;
}

#pragma mark - Regular Expressions

- (NSArray *) captureGroupSubstringOfFirstMatchForRegexPattern:(NSString *)regexPattern{
    NSRegularExpression *testExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult * match = [testExpression firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    NSMutableArray *tmpGroups = [NSMutableArray new];
    NSUInteger numberOfRanges = [match numberOfRanges];
    for (int i = 1; i < numberOfRanges; ++i) {
        NSRange range = [match rangeAtIndex:i];
        if (range.length == 0){
            range.location = 0;
        }
        [tmpGroups addObject: [self substringWithRange:range]];
    }
    return [NSArray arrayWithArray:tmpGroups];
}

- (NSArray *)matchingStringsForRegexPattern:(NSString *)regexPattern{
    NSArray * matches = [self allMatchesForRegexPattern:regexPattern];
    NSMutableArray * matchingStrings =[NSMutableArray new];
    for(NSTextCheckingResult * match in matches){
        NSRange matchRange = [match rangeAtIndex:0];
        [matchingStrings addObject:[self substringWithRange:matchRange]];
    }
    return [matchingStrings copy];
}

// Capture groups indices start from 1. 0 is index of whole match.
- (NSArray *)matchingStringsForRegexPattern:(NSString *)regexPattern captureGroupIndex:(NSInteger)groupIndex{
    NSArray * matches = [self allMatchesForRegexPattern:regexPattern];
    NSMutableArray * matchingStrings =[NSMutableArray new];
    for(NSTextCheckingResult * match in matches){
        NSUInteger numberOfRanges = [match numberOfRanges];
        if (groupIndex <= numberOfRanges){
            NSRange matchRange = [match rangeAtIndex:groupIndex];
            [matchingStrings addObject:[self substringWithRange:matchRange]];
        }
    }
    return [matchingStrings copy];
}

- (NSTextCheckingResult *) matchForRegexPattern:(NSString *)regexPattern{
    NSRegularExpression *testExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult * match = [testExpression firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    return match;
}

- (NSArray *) allMatchesForRegexPattern:(NSString *)regexPattern{
    NSRegularExpression *testExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * matches = [testExpression matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches;
}

- (BOOL) hasMatchesForRegexPattern:(NSString *)regexPattern{
    return ([[self allMatchesForRegexPattern:regexPattern] count] > 0);
}

- (NSString *) stringByReplacingMatchesOfRegexPattern:(NSString *)regexPattern withTemplate:(NSString *)templateString{
    NSRegularExpression *testExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString * res = [testExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:templateString];
    return res;
}

- (BOOL)isValidEmail{
    //NSString *emailPattern = @"\\S+@[A-Za-z0-9][A-Za-z0-9-]*\\.([A-Za-z0-9-]+\\.)*[A-Za-z]{2,4}";
    NSString *emailPattern = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9][A-Za-z0-9-]*\\.([A-Za-z0-9-]+\\.)*[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailPattern];
    return [emailTest evaluateWithObject:self];
}

+ (NSString *) stringByCombiningNonEmptyStrings:(NSArray *)strings withDelimeter:(NSString *)delimeter{
    NSMutableString * res = [NSMutableString new];
    __block BOOL needDelimeter = NO;
    [strings enumerateObjectsUsingBlock:^(NSString * str, NSUInteger idx, BOOL * _Nonnull stop) {
        if (str.hasContent){
            if (needDelimeter){
                [res appendString:delimeter];
            }
            [res appendString:str];
            needDelimeter = YES;
        }
    }];
    return [NSString stringWithString:res];
}

@end


