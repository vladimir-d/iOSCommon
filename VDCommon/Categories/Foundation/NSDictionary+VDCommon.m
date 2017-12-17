//
//  NSDictionary+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import "NSDictionary+VDCommon.h"
#import "NSObject+VDCommon.h"

@implementation NSDictionary (VDCommon)


#pragma mark - Safe methods and validation

- (id) valueForKey:(NSString*) key orDefaultForNSNull:(id)aValueForNSNull{
    id value = [self valueForKey:key];
    return (value == [NSNull null]) ? aValueForNSNull : value ;
}

- (id) objectForKey:(id)key or:(id)defaultObject{
	id result = [self objectForKey:key];
	if (result){
			return result;
	}
    else {
			return defaultObject;
	}
}


#pragma mark - Objects with checked type 

- (NSDictionary *)dictionaryForKey:(id)key{
    if (key != nil){
        return [NSDictionary castObject:[self objectForKey:key]];
    }
    return nil;
}

- (NSArray *)arrayForKey:(id)key{
    if (key != nil){
        return [NSArray castObject:[self objectForKey:key]];
    }
    return nil;
}

- (NSString *)stringForKey:(id)key{
    if (key != nil){
        return [NSString castObject:[self objectForKey:key]];
    }
    return nil;
}

- (NSNumber *)numberForKey:(id)key{
    if (key != nil){
        return [NSNumber castObject:[self objectForKey:key]];
    }
    return nil;
}

#pragma mark - Create modified dictionaries

+ (NSDictionary *) dictionaryWithEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys{
    return [NSDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithEntriesFromDictionary:otherDictionary forKeys:keys]];
}

- (NSDictionary *) dictionaryByAddingAllEntriesFromDictionary:(NSDictionary *)otherDictionary{
    NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [mDict addEntriesFromDictionary:otherDictionary];
    NSDictionary * newDict = [NSDictionary dictionaryWithDictionary:mDict];
    return newDict;
}

- (NSDictionary *)dictionaryByAddingValue:(id)value forKey:(id)key{
    NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [tmpDict setValue:value forKey:key];
    return [NSDictionary dictionaryWithDictionary:tmpDict];
}

- (NSMutableDictionary *) mutableDictionaryWithKeysAndObjectsReversed{
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [dict setObject:key forKey:obj];
    }];
    return dict;
}

- (NSDictionary *) dictionaryWithKeysAndObjectsReversed{
    return [NSDictionary dictionaryWithDictionary:[self mutableDictionaryWithKeysAndObjectsReversed]];
}

#pragma mark - Quering objects and keys

- (NSSet *) allKeysOfObjectWithValue:(id)value forKey:(NSString*)valueKey{
    if (valueKey == nil || value == nil) {
        return  nil;
    }
    return [self keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
        *stop = [[obj valueForKey:valueKey] isEqual:value];
        return *stop;
    }];
}

- (id) anyKeyOfObjectWithValue:(id)value forKey:(NSString*)valueKey{
    return [[self allKeysOfObjectWithValue:value forKey:valueKey] anyObject];
}

- (NSArray *)objectsForKeys:(NSArray *)keys{
    NSMutableArray * arr = [NSMutableArray new];
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        id item = [self objectForKey:key];
        if (item != nil){
            [arr addObject:item];
        }
    }];
    return [NSArray arrayWithArray:arr];
}

#pragma mark - Serialization with NSKeyedArchiver

- (void) saveToKADataFile:(NSString *)file{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:file atomically:YES];
}

+ (instancetype) newFromKADataFile:(NSString *)file{
    NSData * data = [NSData dataWithContentsOfFile:file];
    return [NSDictionary castObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
}

@end
