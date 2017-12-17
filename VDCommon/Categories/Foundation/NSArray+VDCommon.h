//
//  NSArray+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>

@interface NSArray (VDCommon)

#pragma mark - Safe methods and validation
- (BOOL) isValidIndex:(NSInteger) index;
- (id) objectAtIndex:(NSInteger)index or:(id) defObj;
- (id)objectAtIndexFromEnd:(NSInteger)indexFromEnd or:(id) defObj;

#pragma mark - Search and filter
- (NSArray*) filteredArrayUsingPredicateFormat:(NSString*) predicateFormat, ...;
- (id)objectWithValue:(id)value forKey:(NSString*)key;
- (NSUInteger)indexOfObjectWithValue:(id)value forKey:(NSString*)key;
- (id)objectAtIndex:(NSUInteger *)index passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

#pragma mark - Random 
- (id) randomObject;
- (NSArray *)shuffledArray;
+ (NSArray *)arrayWithRandomUnsignedIntegers:(NSUInteger)aCount;

@end
