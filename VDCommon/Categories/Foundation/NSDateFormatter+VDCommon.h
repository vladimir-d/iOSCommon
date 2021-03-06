//
//  NSDateFormatter+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (VDCommon)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
+ (NSDateFormatter *)dateFormatterWithGMTFormat:(NSString *)format;

@end
