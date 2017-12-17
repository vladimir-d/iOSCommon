//
//  NSMutableDictionary+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSMutableDictionary (VDCommon)

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys;
+ (NSMutableDictionary *) dictionaryWithEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys;
@end
