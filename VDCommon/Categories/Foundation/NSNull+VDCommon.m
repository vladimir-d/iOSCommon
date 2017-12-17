//
//  NSNull+VDCommon.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "NSNull+VDCommon.h"

@implementation NSNull (VDCommon)


- (void)forwardInvocation:(NSInvocation *)invocation{
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

- (BOOL) isNull{
    return YES;
}

@end
