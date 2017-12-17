//
//  NSMutableArray+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>


@interface NSMutableArray (VDCommon)

- (void) addObjectOrNSNull:(id) anObject;
- (void) addObjectOrNothing:(id) anObject;
- (void) removeAllObjectsFromIndex:(NSUInteger)idx;
- (void) removeAllObjectsAfterIndex:(NSUInteger)idx;
- (void) reverse;
- (void) shuffle;

@end
