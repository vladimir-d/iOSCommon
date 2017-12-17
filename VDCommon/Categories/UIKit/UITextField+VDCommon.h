//
//  UITextField+VDCommon.h
//  VDCommon
//
//  Created by Vladimir on 11/8/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (VDCommon)

- (void)setCursorPosition:(NSUInteger)position;
- (void)setSelectionRange:(NSRange)range;

- (void) replaceRange:(NSRange)range  withReplacementString:(NSString *)replacementString limitedToLength:(NSInteger)length;
- (BOOL) isTextPrimaryLanguage;

@end
