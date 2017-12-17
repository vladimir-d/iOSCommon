//
//  VDCommonMacro.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 11/1/16.
//  Copyright (c) 2017. All rights reserved.
//

#ifndef VDCommonMacro_h
#define VDCommonMacro_h

#endif /* VDCommonMacro_h */


#define USE_WEAKSELF __typeof__(self) __weak weakSelf = self;

#if !defined(COMPARE_RESULT)
#define COMPARE_RESULT(A,B) ({__typeof__(A) __a = (A); __typeof__(B) __b = (B); (__a > __b) ? NSOrderedDescending : (__a < __b) ? NSOrderedAscending : NSOrderedSame;})
#endif

#if !defined(CLAMP)
#define CLAMP(A,X,B)	({ __typeof__(A) __a = (A); __typeof__(X) __x = (X); __typeof__(B) __b = (B);  __x < __a ? __a :  (__x > __b) ? __b : __x; })
#endif
