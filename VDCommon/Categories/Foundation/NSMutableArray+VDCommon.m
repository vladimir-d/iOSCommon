//
//  NSMutableArray+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSMutableArray+VDCommon.h"

@implementation NSMutableArray (VDCommon)

- (void) addObjectOrNSNull:(id) anObject {
	[self addObject:( anObject == nil ) ? [NSNull null] : anObject ];
}

- (void) addObjectOrNothing:(id) anObject {
	if ( anObject ) {
		[self addObject:anObject];
	}
}

- (void) removeAllObjectsAfterIndex:(NSUInteger)idx{
    NSUInteger count = [self count];
    if (count > idx + 1){
        [self removeObjectsInRange:NSMakeRange(idx + 1, count - idx - 1)];
    }
}

- (void) removeAllObjectsFromIndex:(NSUInteger)idx{
    NSUInteger count = [self count];
    if (count > idx){
        [self removeObjectsInRange:NSMakeRange(idx, count - idx)];
    }
}

- (void) reverse {
	NSUInteger count = [self count];
	NSUInteger halfCount = count / 2;
	for (int i = 0; i < halfCount; i++) {
		[self exchangeObjectAtIndex:i withObjectAtIndex:count - i - 1];
	}
}

- (void)shuffle {
    NSUInteger count = [self count];
    if (count < 2){
        return;
    }
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
