//
//  NSMutableDictionary+Common.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "NSMutableDictionary+VDCommon.h"


@implementation NSMutableDictionary (VDCommon)

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys{
    for(id key in keys){
        id value = [otherDictionary objectForKey:key];
        if (value){
            [self setObject:value forKey:key];
        }
    }
}

+ (NSMutableDictionary *) dictionaryWithEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:[keys count]];
    [dict addEntriesFromDictionary:otherDictionary forKeys:keys];
    return dict;
}




@end
