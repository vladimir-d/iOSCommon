//
//  KHCommonFunctions.h
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDCommonMacro.h"
#import "VDNumericFunctions.h"

void gcdAsyncOnMainQueue(dispatch_block_t block);
void gcdAfterOnMainQueue(NSTimeInterval delayInSeconds, dispatch_block_t block);
BOOL equallStrings(NSString * str1, NSString * str2);

NSString * hMSStringFromTime(NSTimeInterval time, NSString * delimiter);

id alt(id obj, id defaultObj);

