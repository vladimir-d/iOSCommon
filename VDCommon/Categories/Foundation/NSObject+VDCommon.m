//
//  NSObject+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017.  All rights reserved.


#import "NSObject+VDCommon.h"
#import "NSFoundation+VDCommon.h"


typedef float (*FloatReturnObjCMsgSendFunction)(id,SEL);
typedef int (*IntReturnObjCMsgSendFunction)(id,SEL);

@implementation NSObject (VDCommon)

#pragma mark - Object info

- (NSArray *) superclasses{
    NSMutableArray *classes = [NSMutableArray new];
    Class currentClass = [self class];
    while (currentClass != nil) {
        [classes addObject:currentClass];
        currentClass = [currentClass superclass];
    }
    [classes reverse];
    return [classes copy];
}

- (NSString *)objectPropertiesInfo{
    return [self objectPropertiesInfoSubLevels:0];
}

- (NSString *)objectPropertiesInfoSubLevels:(NSInteger)aSubLevels{
    id objClass =[self class];
    
    unsigned int outCount, i;
    NSString * name, * attributes;
    objc_property_t *properties = class_copyPropertyList(objClass, &outCount);
    
    NSMutableString * resStr = [NSMutableString new];
    [resStr appendString:@"==========================================================\n"];
    [resStr appendFormat:@"### Class: %@\n",NSStringFromClass(objClass)];
    
    
    for (i = 0; i < outCount; i++){
        objc_property_t property = properties[i];
        name = [NSString stringWithFormat:@"%s", property_getName(property)];
        attributes = [NSString stringWithFormat:@"%s", property_getAttributes(property)];
        
        
        SEL propGetSel = NSSelectorFromString(name);
        if ([self respondsToSelector:propGetSel]){
            if ([attributes hasPrefix:@"T@"]){
                //id objRes = objc_msgSend(self, propGetSel);
                //                    IMP theImplementation = [self methodForSelector:propGetSel];
                //                    theImplementation(self, propGetSel);
                
                //id objRes = ((id (*)(id, SEL))objc_msgSend)(self, propGetSel);
                id objRes = [self valueForKey:name];
                [resStr appendFormat:@">>> (class:%@) %@ = %@\n", [objRes className], name, [objRes description]];
                if (aSubLevels > 0){
                    [resStr appendFormat:@"%@", [objRes objectPropertiesInfoSubLevels:aSubLevels - 1]];
                }
            }
            else if ([attributes hasPrefix:@"Ti"]){
                int intRes = ((IntReturnObjCMsgSendFunction)objc_msgSend)(self,propGetSel);
                [resStr appendFormat:@">>> int %@ = %d\n", name, (int)intRes];
            }
            else if ([attributes hasPrefix:@"Tf"]){
                float floatRes = ((FloatReturnObjCMsgSendFunction)objc_msgSend)(self,propGetSel);
                [resStr appendFormat:@">>> float %@ = %f",name, (float)floatRes];
            }
            else if ([attributes hasPrefix:@"Tf"]){
                BOOL boolRes = (BOOL)((IntReturnObjCMsgSendFunction)objc_msgSend)(self,propGetSel);
                [resStr appendFormat:@">>>  BOOL %@ = %@",name, boolRes ? @"YES" : @"NO"];
            }
        }
    }
    
    return [NSString stringWithString:resStr];
}

+ (NSString *)className{
    return NSStringFromClass([self class]);
}

- (NSString *)className{
    return NSStringFromClass([self class]);
}

- (id) castToClass:(Class)aClass{
    if ([self isKindOfClass:aClass]){
        return self;
    }
    return nil;
}

#pragma mark - Casting and checking types

+ (id) castObject:(NSObject *)object{
    if ([object isKindOfClass:self]){
        return object;
    }
    return nil;
}

+ (id) assertCastObject:(NSObject *)object{
    if (object == nil){
        return nil;
    }
    if ([object isKindOfClass:self]){
        return object;
    }
    NSAssert(0, @"Attempt to cast to wrong type");
    return nil;
}

+ (id) castObject:(NSObject *)object or:(id)defaultObject{
    if ([object isKindOfClass:self]){
        return object;
    }
    return defaultObject;
}

+ (id) castMemberObject:(NSObject *)object{
    if ([object isMemberOfClass:self]){
        return object;
    }
    return nil;
}

+ (BOOL) isClassOfObject:(id)obj{
    return [obj isKindOfClass:self];
}


#pragma mark - KVC

- (NSMutableDictionary *) mutableDictionaryWithExistingValuesForKeys:(NSArray *)valueKeys{
    NSUInteger count = [valueKeys count];
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:count];
    [valueKeys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        id value = [self valueForKey:key];
        if (value != nil){
            [dict setValue:value forKey:key];
        }
    }];
    return dict;
}

- (NSMutableDictionary *) mutableDictionaryWithExistingValuesKeys:(NSArray *)valueKeys andKeys:(NSArray *)dictionaryKeys{
    NSUInteger count = [dictionaryKeys count];
    if ([valueKeys count] != count){
        return nil;
    }
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:count];
    [dictionaryKeys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        id valueKey = [valueKeys objectAtIndex:idx];
        id value = [self valueForKey:valueKey];
        if (value != nil){
            [dict setValue:value forKey:key];
        }
    }];
    return dict;
}

- (id)safeValueForKeyPath:(NSString *)path{
    NSArray * pathComponents = [path componentsSeparatedByString:@"."];
    id res = self;
    SEL sel = @selector(valueForKey:);
    for(NSString * component in  pathComponents){
        if ([res respondsToSelector:sel]){
            res = [res valueForKey:component];
        }
        else{
            res = nil;
            break;
        }
    }
    return res;
}

- (NSArray *)arrayOrNilForKeyPath:(NSString *)path{
    NSArray * res = [self safeValueForKeyPath:path];
    if ([res isKindOfClass:[NSArray class]]){
        return res;
    }
    return nil;
}

- (NSDictionary *)dictionaryOrNilForKeyPath:(NSString *)path{
    NSDictionary * res = [self safeValueForKeyPath:path];
    if ([res isKindOfClass:[NSDictionary class]]){
        return res;
    }
    return nil;
}

- (NSString *)stringOrNilForKeyPath:(NSString *)path{
    NSString * res = [self safeValueForKeyPath:path];
    if ([res isKindOfClass:[NSString class]]){
        return res;
    }
    return nil;
}

- (NSNumber *)numberOrNilForKeyPath:(NSString *)path{
    NSNumber * res = [self safeValueForKeyPath:path];
    if ([res isKindOfClass:[NSNumber class]]){
        return res;
    }
    return nil;
}

- (NSString *)descriptionForFields:(NSArray *)fields prefix:(NSString *)prefix{
    if (!prefix){
        prefix = @"";
    }
    NSMutableString * str = [NSMutableString new];
    for (id field in fields) {
        NSString * fieldName = [NSString castObject:field];
        if (fieldName != nil){
            if ([self respondsToSelector:NSSelectorFromString(fieldName)]){
                [str appendFormat:@"%@%@: %@\n", prefix, fieldName, [self valueForKey:fieldName]];
            }
        }
    }
    return [NSString stringWithString:str];
}

+ (instancetype) safeObjectForKey:(NSString *)key fromDictionary:(NSDictionary *)dict{
    NSDictionary * safeDict = [NSDictionary castObject:dict];
    NSString * safeKey = [NSString castObject:key];
    return [self castObject:safeDict[safeKey]];
}


// safe stubs for the case this methods are called from object that not implmented them
// classes like NSDictionary have own implementation

- (NSString *) stringForKey:(id)key{
    return nil;
}

- (NSArray *) arrayForKey:(id)key{
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)key{
    return nil;
}

- (NSNumber *)numberForKey:(id)key{
    return nil;
}

- (void) setValuesForKeys:(NSArray *)keys fromObject:(id)otherObject{
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setValue:[otherObject valueForKey:key] forKey:key];
    }];
}


@end
