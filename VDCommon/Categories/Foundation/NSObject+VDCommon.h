//
//  NSObject+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>


@interface NSObject (VDCommon)

#pragma mark - Object info
- (NSArray *) superclasses;
- (NSString *) objectPropertiesInfo;
- (NSString *) objectPropertiesInfoSubLevels:(NSInteger)aSubLevels;
- (NSString *) descriptionForFields:(NSArray *)fields prefix:(NSString *)prefix;
+ (NSString *)className;
- (NSString *)className;

#pragma mark - Casting and checking types
- (id) castToClass:(Class)aClass;

// used when other type or nil value of object is within normal application logic e.g. just to choose one of possible types
+ (id) castObject:(NSObject *)object;

// same as castObject: but only for exact class
+ (id) castMemberObject:(NSObject *)object;

// used when other type or nil value of object is not normal - in this case assertion will occure
+ (id) assertCastObject:(NSObject *)object;

// used when valid object must be returned in any case: for other type or nil value of object given default object will be returned
+ (id) castObject:(NSObject *)object or:(id)defaultObject;

+ (BOOL) isClassOfObject:(id)obj;

#pragma mark - KVC
// to make a dictionary from object with entries for valueKeys constructed from selected object properties with corresponding names
// similar to <NSKeyValueCoding.h> dictionaryWithValuesForKeys, but nil values skipped
- (NSMutableDictionary *) mutableDictionaryWithExistingValuesForKeys:(NSArray *)valueKeys;

// to make a dictionary from object with entries for dictionaryKeys constructed from selected object properties (valueKeys is property names)
- (NSMutableDictionary *) mutableDictionaryWithExistingValuesKeys:(NSArray *)valueKeys andKeys:(NSArray *)dictionaryKeys;

- (id)safeValueForKeyPath:(NSString *)path;

+ (instancetype) safeObjectForKey:(NSString *)key fromDictionary:(NSDictionary *)dict;

- (NSDictionary *)dictionaryForKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSNumber *)numberForKey:(id)key;
- (void) setValuesForKeys:(NSArray *)keys fromObject:(id)otherObject;

@end
