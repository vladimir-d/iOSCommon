//
//  NSDictionary+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>

@interface NSDictionary (VDCommon)

#pragma mark - Safe methods and validation
- (id) objectForKey:(id)key or:(id)defaultObject;
- (id) valueForKey:(NSString*) key orDefaultForNSNull:(id)defaultForNSNull;

#pragma mark - Objects with checked type
- (NSDictionary *)dictionaryForKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSNumber *)numberForKey:(id)key;

#pragma mark - Create modified dictionaries
- (NSDictionary *) dictionaryByAddingAllEntriesFromDictionary:(NSDictionary *)otherDictionary;
+ (NSDictionary *) dictionaryWithEntriesFromDictionary:(NSDictionary *)otherDictionary forKeys:(NSArray *)keys;
- (NSDictionary *) dictionaryWithKeysAndObjectsReversed;
- (NSMutableDictionary *) mutableDictionaryWithKeysAndObjectsReversed;
- (NSDictionary *)dictionaryByAddingValue:(id)value forKey:(id)key;

#pragma mark - Quering objects and keys
// returns keys for all objects with specified value for valueKey
- (NSSet *) allKeysOfObjectWithValue:(id)value forKey:(NSString*)valueKey;

// returns key for object with specified value for valueKey
- (id) anyKeyOfObjectWithValue:(id)value forKey:(NSString*)valueKey;

- (NSArray *)objectsForKeys:(NSArray *)keys;

#pragma mark - Serialization with NSKeyedArchiver
- (void) saveToKADataFile:(NSString *)file;
+ (instancetype) newFromKADataFile:(NSString *)file;

@end
