//
//  NSArray+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSArray+VDCommon.h"

@implementation NSArray (VDCommon)


#pragma mark - Safe methods and validation

- (BOOL) isValidIndex:(NSInteger) index {
	return (index >= 0 && index < [self count]);
}

- (id) objectAtIndex:(NSInteger)index or:(id) defObj {
	return ([self isValidIndex:index]) ? [self objectAtIndex:index] : defObj ;
}

- (id)objectAtIndexFromEnd:(NSInteger)indexFromEnd or:(id) defObj{
    NSUInteger count = [self count];
    if (indexFromEnd >= 0 && indexFromEnd < count){
        return [self objectAtIndex:count - indexFromEnd - 1];
    }
    else{
        return defObj;
    }
}


#pragma mark - Search and filter

- (NSArray*) filteredArrayUsingPredicateFormat:(NSString*) predicateFormat, ... {
    va_list list;
    va_start(list, predicateFormat);
    NSArray *filteredArray = [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:predicateFormat arguments:list]];
    va_end(list);
    
    return filteredArray;
}

- (id)objectAtIndex:(NSUInteger *)index passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate{
    NSUInteger resIndex = [self indexOfObjectPassingTest:predicate];
    id resObj = nil;
    if (resIndex < [self count]){
        resObj = [self objectAtIndex:resIndex];
    }
    if (index){
        *index = resIndex;
    }
    return resObj;
}

- (NSUInteger)indexOfObjectWithValue:(id)value forKey:(NSString*)key{
    if (key == nil || value == nil) {
        return  NSNotFound;
    }
    return [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        *stop = [[obj valueForKey:key] isEqual:value];
        return *stop;
    }];
}

- (id)objectWithValue:(id)value forKey:(NSString*)key{
    if (key == nil || value == nil) {
        return  nil;
    }
	for (id anObject in self) {
		if ( [[anObject valueForKey:key] isEqual:value] ) {
			return anObject;
		}
	}
    return nil;
}

#pragma mark - Random

+ (NSArray *)arrayWithRandomUnsignedIntegers:(NSUInteger)aCount{
    NSMutableArray * src = [NSMutableArray arrayWithCapacity:aCount];
    NSMutableArray * res = [NSMutableArray arrayWithCapacity:aCount];
    if (aCount){
        for (unsigned i = 0; i < aCount; i++) {
           [src addObject:[NSNumber numberWithUnsignedInt:i]];
        }
        for (NSUInteger i = 0; i < aCount; i++) {
            NSUInteger r = arc4random()%(aCount - i);
            [res addObject:[NSNumber numberWithUnsignedInt:[[src objectAtIndex:r] unsignedIntValue]]];
            [src removeObjectAtIndex:r];
        }
    }
    return [NSArray arrayWithArray:res];
}

- (id) randomObject{
    NSUInteger count = [self count];
    return count ? [self objectAtIndex:arc4random()%count] : nil;
}
    
- (NSArray *)shuffledArray {
    NSMutableArray *ar = [[NSMutableArray alloc]initWithArray:self];
    NSUInteger count = [ar count];
    if (count > 1){
        for (NSUInteger i = 0; i < count; ++i) {
            NSUInteger nElements = count - i;
            NSUInteger n = (arc4random()%nElements)+i;
            [ar exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        NSArray *newArray = [[NSArray alloc]initWithArray:ar];
        return newArray;
    }
    else{
        return [NSArray arrayWithArray:self];
    }
}


@end
