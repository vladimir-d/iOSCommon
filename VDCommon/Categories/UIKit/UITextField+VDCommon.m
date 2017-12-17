//
//  UITextField+VDCommon.m
//
//  Created by Vladimir on 11/8/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "UITextField+VDCommon.h"
#import "VDCommon.h"

@implementation UITextField (VDCommon)

- (void)setCursorPosition:(NSUInteger)position{
    [self setSelectionRange:NSMakeRange(position, 0)];
}

- (void)setSelectionRange:(NSRange)range{
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}


- (void) replaceRange:(NSRange)range withReplacementString:(NSString *)replacementString limitedToLength:(NSInteger)length{
    NSInteger curLength = [self.text length];
    NSInteger allowedRepLength = length - (curLength - range.length);
    NSString * limitedString = [replacementString stringByTrimmingToLength:MAX(0, allowedRepLength)];
    self.text = [self.text stringByReplacingCharactersInRange:range withString:limitedString];
    [self setCursorPosition:range.location + limitedString.length];
}

- (BOOL) isTextPrimaryLanguage{
    NSString * primaryLanguage = [[self textInputMode] primaryLanguage];
    return (primaryLanguage != nil && ![primaryLanguage isEqualToString:@"emoji"]);
}

@end
