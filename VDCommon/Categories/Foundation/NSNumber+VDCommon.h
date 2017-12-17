//
//  NSNumber+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (VDCommon)

- (NSString *)stringWithThousandSeparator:(NSString *)separator;
- (NSString *)stringWithThousandSeparator:(NSString *)groupingSeparator decimalSeparator:(NSString *)decimalSeparator;
+ (instancetype) boolNumberWithObject:(id)object;
@end
