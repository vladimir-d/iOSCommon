//
//  NSNumber+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSNumber+VDCommon.h"
#import "VDCommon.h"

@implementation NSNumber (VDCommon)

- (NSString *)stringWithThousandSeparator:(NSString *)separator{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.usesGroupingSeparator = YES;
    numberFormatter.groupingSeparator = separator;
    numberFormatter.groupingSize = 3;
    
    return [numberFormatter stringFromNumber: self];
}

- (NSString *)stringWithThousandSeparator:(NSString *)groupingSeparator decimalSeparator:(NSString *)decimalSeparator{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.usesGroupingSeparator = YES;
    numberFormatter.groupingSeparator = groupingSeparator;
    numberFormatter.decimalSeparator = decimalSeparator;
    numberFormatter.groupingSize = 3;
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    return [numberFormatter stringFromNumber: self];
}

+ (instancetype) boolNumberWithObject:(id)object{
    //bool from all possible backend results
    if ([NSNumber isClassOfObject:object]){
        return object;
    }
    else{
        NSString * str = [NSString castObject:object];
        if (str != nil){
            str = [str uppercaseString];
            if ([str isEqualToString:@"TRUE"] || [str isEqualToString:@"YES"]){
                return @(YES);
            }
            else if ([str isEqualToString:@"FALSE"] || [str isEqualToString:@"NO"]){
                return @(NO);
            }
            else{
                return @([str intValue] != 0);
            }
        }
        return @(object != nil);
    }
}

@end
